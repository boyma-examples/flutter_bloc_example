import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/modules/auth-core/ui/widgets/screen_back.dart';

import '../../../../generated/l10n.dart';
import '../../../auth-core/data/auth_repository.dart';
import '../../../auth-core/domain/app_auth_bloc/app_auth_bloc.dart';
import '../../../common-core/widgets/big_bottom_textbutton.dart';
import '../../../utils/nav_utils.dart';
import '../domain/sms_entering_args.dart';
import '../domain/sms_entering_bloc/sms_entering_bloc.dart';
import '../domain/sms_entering_bloc/sms_entering_bloc_state.dart';
import '../domain/timer_bloc/timer_bloc.dart';
import '../domain/timer_bloc/timer_bloc_state.dart';

class SmsEnteringScreen extends StatelessWidget {
  final SmsEnteringArgs smsEnteringArgs;

  const SmsEnteringScreen({
    Key? key,
    required this.smsEnteringArgs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SmsEnteringBloc, SmsEnteringBlocState>(
      listener: (context, state) {
        if (state is SmsEnteringBlocStateSuccess) {
          navigateBack(context);
        }
      },
      buildWhen: (prevstate, state) {
        return state is! SmsEnteringBlocStateSuccess;
      },
      builder: (context, state) {
        if (state is SmsEnteringBlocStateProgress) {
          return Stack(
            children: const [
              ScreenBackground(),
              Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ],
          );
        } else if (state is SmsEnteringBlocStateNormal) {
          return ScreenBackground(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    S.of(context).enter_code,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    S.of(context).enter_code_msg(smsEnteringArgs.number),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                  BlocBuilder<TimerBloc, TimerBlocState>(
                      builder: (context, state) {
                    if (state is TimerBlocStateStarted) {
                      return Text(
                        S.of(context).sms_code_repeat_time(state.timeElapsed),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      );
                    } else if (state is TimerBlocStateStopped) {
                      return TextButton(
                        onPressed: () {
                          context
                              .read<SmsEnteringBloc>()
                              .onRepeatSendClick(smsEnteringArgs.number);
                        },
                        child: Text(
                          S.of(context).repeat_sms,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                    return Container();
                  }),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: const TextField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Код",
                              labelStyle: TextStyle(color: Colors.grey),
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Center(
                    child: BigBottomTextButton(
                      text: S.of(context).next,
                      onClick: () {
                        context.read<SmsEnteringBloc>().onEnteredCode();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

///router
void navToSmsEnteringScreen(
  BuildContext context,
  SmsEnteringArgs args,
) {
  var timerBloc = TimerBloc();
  navTo(
    context: context,
    screenWidget: MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: timerBloc,
        ),
        BlocProvider(
          lazy: false,
          create: (c) => SmsEnteringBloc(
            authRepository: AuthRepositoryMockImpl(),
            timerBloc: timerBloc,
            appAuthBloc: context.read<AppAuthBloc>(),
          )..requestSms(args.number),
        ),
      ],
      child: SmsEnteringScreen(smsEnteringArgs: args),
    ),
  );
}

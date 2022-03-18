import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/modules/auth-core/ui/widgets/screen_back.dart';
import 'package:flutter_bloc_example/modules/auth-screens/sms_entering/domain/sms_entering_args.dart';

import '../../../../generated/l10n.dart';
import '../../../common-core/widgets/big_bottom_textbutton.dart';
import '../../sms_entering/ui/sms_entering_screen.dart';
import '../domain/phone_entering_bloc/phone_entering_bloc.dart';

class PhoneEnteringScreen extends StatelessWidget {
  const PhoneEnteringScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimateIfVisibleWrapper(
      child: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _animWidget(
                      key: const ValueKey("logint"),
                      child: const Text(
                        "Вход",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    _animWidget(
                      key: const ValueKey("username"),
                      child: Container(
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
                              child: TextField(
                                style: const TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                onChanged: (tel) {
                                  context
                                      .read<PhoneEnteringBloc>()
                                      .onTelChanged(tel);
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Номер телефона",
                                  labelStyle: TextStyle(color: Colors.grey),
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    _animWidget(
                      key: const ValueKey("nextbtn"),
                      child: Center(
                        child: BigBottomTextButton(
                          text: S.of(context).next,
                          onClick: () {
                            _navToSmsEnteringScreen(
                              context,
                              context
                                  .read<PhoneEnteringBloc>()
                                  .normalState()
                                  .number,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// -----------------------------------
  ///   NAVIGATE METHODS
  /// -----------------------------------
  void _navToSmsEnteringScreen(
    BuildContext context,
    String number,
  ) {
    navToSmsEnteringScreen(
      context,
      SmsEnteringArgs(number: number),
    );
  }

  Widget _animWidget({
    required Key key,
    required Widget child,
  }) {
    return AnimateIfVisible(
      key: key,
      duration: const Duration(milliseconds: 500),
      builder: (
        BuildContext context,
        Animation<double> animation,
      ) =>
          SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(animation),
        child: FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: child,
        ),
      ),
    );
  }
}

///router
Widget navToPhoneEnteringScreenWidget(
  BuildContext context,
) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        lazy: false,
        create: (c) => PhoneEnteringBloc(),
      ),
    ],
    child: const PhoneEnteringScreen(),
  );
}

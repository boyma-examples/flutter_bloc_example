import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/modules/auth-core/domain/app_auth_bloc/app_auth_bloc.dart';
import 'package:flutter_bloc_example/modules/feature-list-core/data/models/item_dto.dart';
import 'package:flutter_bloc_example/modules/feature-list-core/ui/widgets/square_button.dart';

import '../../../feature-list-core/data/feature_list_api.dart';
import '../../../feature-list-core/data/feature_list_repository.dart';
import '../../../feature-list-core/domain/feature_list_bloc/feature_list_bloc.dart';
import '../../../feature-list-core/domain/feature_list_bloc/feature_list_bloc_state.dart';
import '../widgets/item_list.dart';

class FeatureListScreen extends StatelessWidget {
  const FeatureListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Меню",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SquareButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onClick: () {
                      onAddItemClick(context);
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SquareButton(
                    icon: const Icon(
                      Icons.exit_to_app_rounded,
                      color: Colors.white,
                    ),
                    onClick: () {
                      context.read<AppAuthBloc>().clearAuth();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return BlocBuilder<FeatureListBloc, FeatureListBlocState>(
      builder: (context, state) {
        if (state is FeatureListBlocStateError) {
          return const Center(
            child: Text("error"),
          );
        } else if (state is FeatureListBlocStateData) {
          return GridView.builder(
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: state.list.length,
            itemBuilder: (BuildContext ctx, index) {
              return ItemListWidget(
                title: (state).list.elementAt(index).title,
                center: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loader.gif',
                    placeholderScale: 5,
                    image: (state).list.elementAt(index).url,
                  ),
                ),
                onDelete: () {
                  onDeleteItem(context, (state).list.elementAt(index));
                },
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void onAddItemClick(BuildContext context) {
    context.read<FeatureListBloc>().onAddItemClick();
  }

  void onDeleteItem(BuildContext context, SomeItemDto e) {
    context.read<FeatureListBloc>().onDeleteItemClick(e);
  }

  /// -----------------------------------
  ///   NAVIGATE METHODS
  /// -----------------------------------
}

///router
Widget navToFeatureListScreenWidget(
  BuildContext context,
) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        lazy: false,
        create: (c) => FeatureListBloc(
          featureListRepository: FeatureListRepositoryImpl(
            FeatureListApi(),
          ),
        )..loadData(),
      ),
    ],
    child: const FeatureListScreen(),
  );
}

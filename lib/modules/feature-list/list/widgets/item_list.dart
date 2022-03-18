import 'package:flutter/material.dart';

import '../../../feature-list-core/ui/widgets/square_button.dart';

class ItemListWidget extends StatelessWidget {
  final String title;
  final Widget center;
  final Function onDelete;

  const ItemListWidget({
    Key? key,
    required this.title,
    required this.center,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(alignment: Alignment.center, child: center),
        Align(
          alignment: Alignment.topRight,
          child: SquareButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onClick: () {
              onDelete();
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(title, style: const TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

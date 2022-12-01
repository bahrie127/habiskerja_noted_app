import 'package:flutter/material.dart';

import 'package:flutter_notes_app/models/note.dart';
import 'package:flutter_notes_app/pages/detail_page.dart';
import 'package:flutter_notes_app/utils/constant.dart';
import 'package:intl/intl.dart';

class CardWidget extends StatelessWidget {
  final int index;
  final Note data;
  const CardWidget({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = cardColors[index % cardColors.length];
    final time = DateFormat('dd-MM-yyyy hh:mm', 'id_ID').format(data.time);
    final minHeight = getMinHeight(index);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              data.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

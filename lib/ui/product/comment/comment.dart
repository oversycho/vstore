// ignore: camel_case_types
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vstore/data/comment.dart';
import 'package:vstore/theme.dart';

class commentItem extends StatelessWidget {
  final CommentEntity data;
  const commentItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: DarkThemeColors.secondaryTextColor,
          width: 0.6,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.title, style: themeData.textTheme.titleSmall),
                  Text(
                    data.email,
                    style: themeData.textTheme.labelSmall!.apply(
                      color: const Color.fromARGB(144, 158, 158, 162),
                    ),
                  ),
                ],
              ),
              Text(
                data.date,
                style: themeData.textTheme.labelSmall!.apply(
                  color: const Color.fromARGB(144, 158, 158, 162),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(data.content, style: TextStyle(height: 1.7)),
        ],
      ),
    );
  }
}

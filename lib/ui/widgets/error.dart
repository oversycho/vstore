import 'package:flutter/material.dart';
import 'package:vstore/common/exception.dart';

class AppErrorrWidget extends StatelessWidget {
  final AppException exception;
  final GestureTapCallback onPressed;
  const AppErrorrWidget({
    super.key,
    required this.exception,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(exception.message),
        ElevatedButton(onPressed: onPressed, child: Text('تلاش مجدد')),
      ],
    );
  }
}

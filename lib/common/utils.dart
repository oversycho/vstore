import 'package:flutter/cupertino.dart';

extension PriceLabel on int {
  String get withPriceLabel => '$this تومان';
}

const defultScrollPhysics = BouncingScrollPhysics();

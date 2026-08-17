part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartResponse cartResponse;

  const CartSuccess(this.cartResponse);
  @override
  List<Object> get props => [cartResponse];
}

class CartErorr extends CartState {
  final AppException exception;

  const CartErorr(this.exception);
}

class CartAuthRequired extends CartState {}

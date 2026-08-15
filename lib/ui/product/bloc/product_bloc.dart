import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:vstore/common/exception.dart';
import 'package:vstore/data/repo/cart_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ICartRepository cartRepository;
  ProductBloc(this.cartRepository) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is CartAddButtonClick) {
        try {
          emit(ProductAddToCartButtonLoading());
          await Future.delayed(Duration(seconds: 1));
          final result = await cartRepository.addToCart(event.productId);
          emit(ProductAddToCartSuccess());
        } catch (e) {
          emit(ProductAddToCartError(AppException()));
        }
      }
    });
  }
}

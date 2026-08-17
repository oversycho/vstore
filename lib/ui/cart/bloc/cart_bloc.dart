import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vstore/common/exception.dart';
import 'package:vstore/data/cart_response.dart';
import 'package:vstore/data/repo/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository cartRepository;
  CartBloc(this.cartRepository) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      if (event is CartStarted) {
        try {
          emit(CartLoading());
          final result = await cartRepository.getcart();
          emit(CartSuccess(result));
        } catch (e) {
          emit(CartErorr(AppException()));
        }
      }
    });
  }
}

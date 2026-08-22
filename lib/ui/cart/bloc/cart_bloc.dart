import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vstore/common/exception.dart';
import 'package:vstore/data/auth_info.dart';
import 'package:vstore/data/cart_response.dart';
import 'package:vstore/data/repo/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository cartRepository;
  CartBloc(this.cartRepository) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      if (event is CartStarted) {
        final authInfo = event.authInfo;
        if (authInfo == null || authInfo.accessToken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          await LoadCartItems(emit);
        }
      } else if (event is CartAuthInfoChanged) {
        if (event.authInfo == null || event.authInfo!.accessToken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          if (state is CartAuthRequired) {
            await LoadCartItems(emit);
          }
        }
      }
    });
  }
  Future<void> LoadCartItems(Emitter<CartState> emit) async {
    try {
      emit(CartLoading());
      final result = await cartRepository.getcart();
      emit(CartSuccess(result));
    } catch (e) {
      emit(CartErorr(AppException()));
    }
  }
}

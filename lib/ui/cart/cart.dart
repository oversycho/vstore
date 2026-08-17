import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vstore/common/utils.dart';
import 'package:vstore/data/auth_info.dart';
import 'package:vstore/data/repo/auth_repository.dart';
import 'package:vstore/data/source/cart_data_source.dart';
import 'package:vstore/theme.dart';
import 'package:vstore/ui/auth/auth.dart';
import 'package:vstore/ui/cart/bloc/cart_bloc.dart';
import 'package:vstore/ui/widgets/image.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('سبد خرید')),
      body: BlocProvider<CartBloc>(
        create: (context) {
          final bloc = CartBloc(cartReposiorty);
          bloc.add(CartStarted());
          return bloc;
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CupertinoActivityIndicator());
            } else if (state is CartErorr) {
              return Center(child: Text(state.exception.message));
            } else if (state is CartSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final data = state.cartResponse.cartItems[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: DarkThemeColors.surfaceColor,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(88, 24, 23, 23),
                          blurRadius: 20,
                        ),
                      ],
                    ),

                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: ImageLoadingService(
                                  imageUrl: data.product.imageUrl,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data.product.title,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text('تعداد'),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          CupertinoIcons.plus_rectangle,
                                        ),
                                      ),
                                      Text(data.count.toString()),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          CupertinoIcons.minus_rectangle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data.product.previousPrice.withPriceLabel,
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: DarkThemeColors.secondaryTextColor,
                                    ),
                                  ),
                                  Text(data.product.price.withPriceLabel),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1, indent: 24, endIndent: 24),
                        TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('حذف از سبد خرید'),
                              const SizedBox(width: 8),
                              const Icon(CupertinoIcons.delete),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: state.cartResponse.cartItems.length,
              );
            } else {
              throw Exception('state is not supported');
            }
          },
        ),
      ),
      /* ValueListenableBuilder<AuthInfo?>(
        valueListenable: AuthRepository.AuthChangeNotifier,
        builder: (context, authState, child) {
          bool isAuthenticated =
              authState != null && authState!.accessToken.isNotEmpty;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isAuthenticated
                      ? 'خوش آمدید'
                      : 'لطفا وارد حساب کاربری خود شوید',
                ),
                isAuthenticated
                    ? ElevatedButton(
                        onPressed: () {
                          authRepository.signOut();
                        },
                        child: const Text('خروج'),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                              builder: (context) => AuthScreen(),
                            ),
                          );
                        },
                        child: const Text('ورود'),
                      ),
                ElevatedButton(
                  onPressed: () async {
                    await authRepository.refreshToken();
                  },
                  child: const Text('refresh Token'),
                ),
              ],
            ),
          );
        },
      ), */
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vstore/data/auth_info.dart';
import 'package:vstore/data/repo/auth_repository.dart';
import 'package:vstore/data/source/cart_data_source.dart';
import 'package:vstore/ui/auth/auth.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    cartReposiorty
        .getcart()
        .then((value) async {
          debugPrint(value.toString());
        })
        .catchError((e) {
          debugPrint(e.toString());
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('سبد خرید')),
      body: ValueListenableBuilder<AuthInfo?>(
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
      ),
    );
  }
}

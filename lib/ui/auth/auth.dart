import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vstore/data/repo/auth_repository.dart';
import 'package:vstore/theme.dart';
import 'package:vstore/ui/auth/bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController(
    text: "test@gmail.com",
  );
  final TextEditingController passwordController = TextEditingController(
    text: "123456",
  );
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Theme(
        data: themeData.copyWith(
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: DarkThemeColors.primaryTextColor),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color.fromARGB(255, 40, 40, 41),

                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          snackBarTheme: SnackBarThemeData(
            actionTextColor: DarkThemeColors.primaryTextColor,
            contentTextStyle: themeData.textTheme.labelMedium!.apply(
              fontSizeDelta: 1.5,
            ),
            backgroundColor: DarkThemeColors.surfaceColor,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              minimumSize: WidgetStatePropertyAll(Size(double.infinity, 56)),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              backgroundColor: WidgetStatePropertyAll(
                DarkThemeColors.primaryTextColor,
              ),
              foregroundColor: WidgetStatePropertyAll(
                DarkThemeColors.surfaceColor,
              ),
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: DarkThemeColors.backgroundColor,
          body: BlocProvider<AuthBloc>(
            create: (context) {
              final bloc = AuthBloc(authRepository);
              bloc.stream.forEach((state) {
                if (state is AuthSuccess) {
                  Navigator.of(context).pop();
                } else if (state is AuthErorr) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.exception.message)),
                  );
                }
              });
              bloc.add(AuthStarted());
              return bloc;
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(48, 5, 48, 5),
              child: BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) {
                  return current is AuthLoading ||
                      current is AuthInitial ||
                      current is AuthErorr;
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/img/vstore_logo.png', width: 120),
                      const SizedBox(height: 18),
                      Text(
                        state.isLoginMode ? 'خوش آمدید' : 'ثبت نام',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        state.isLoginMode
                            ? 'لطفا وارد حساب کاربری خود شوید'
                            : 'حساب کاربری خود را بسازید',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(label: Text('آدرس ایمیل')),
                      ),
                      const SizedBox(height: 16),
                      _PasswordTextField(controller: passwordController),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthButtonIsCliked(
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                        },
                        child: state is AuthLoading
                            ? CupertinoActivityIndicator(
                                color: DarkThemeColors.backgroundColor,
                              )
                            : Text(
                                state.isLoginMode ? 'ورود' : 'ثبت نام',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                      ),
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthBloc>(
                            context,
                          ).add(AuthModeChageISClicked());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.isLoginMode
                                  ? 'آیا حساب کاربری ندارید؟ '
                                  : ' حساب کاربری دارید ؟',
                            ),
                            SizedBox(width: 8),
                            Text(
                              state.isLoginMode ? 'ثبت نام' : 'ورود',
                              style: TextStyle(
                                color: DarkThemeColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({required this.controller});
  final TextEditingController controller;
  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: obscureText
              ? Icon(CupertinoIcons.eye_slash)
              : Icon(CupertinoIcons.eye),
        ),
        label: Text('رمز عبور'),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vstore/data/repo/auth_repository.dart';
import 'package:vstore/theme.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Theme(
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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(48, 5, 48, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/img/vstore_logo.png', width: 120),
              const SizedBox(height: 18),
              Text(
                isLogin ? 'خوش آمدید' : 'ثبت نام',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                isLogin
                    ? 'لطفا وارد حساب کاربری خود شوید'
                    : 'حساب کاربری خود را بسازید',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(label: Text('آدرس ایمیل')),
              ),
              const SizedBox(height: 16),
              _PasswordTextField(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  authRepository.login("oversycho41@gmail.com", "123456789");
                },
                child: Text(
                  isLogin ? 'ورود' : 'ثبت نام',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 18),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin
                          ? 'آیا حساب کاربری ندارید؟ '
                          : ' حساب کاربری دارید ؟',
                    ),
                    SizedBox(width: 8),
                    Text(
                      isLogin ? 'ثبت نام' : 'ورود',
                      style: TextStyle(color: DarkThemeColors.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({super.key});

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
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

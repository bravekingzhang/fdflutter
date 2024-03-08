import 'package:fdflutter/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: user.when(
            data: (data) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TDText(
                  '用户登录',
                  font: TDTheme.of(context).fontHeadlineLarge,
                  textColor: TDTheme.of(context).brandNormalColor,
                ),
                const SizedBox(height: 46),
                TDInput(
                  leftLabel: '用户名',
                  required: true,
                  controller: controllers[0],
                  backgroundColor: Colors.white,
                  hintText: '请输入用户名',
                  onChanged: (text) {
                    controllers[0].text = text;
                  },
                  onClearTap: () {
                    controllers[0].clear();
                  },
                ),
                const SizedBox(height: 16),
                TDInput(
                  leftLabel: '密码',
                  required: true,
                  controller: controllers[1],
                  backgroundColor: Colors.white,
                  hintText: '请输入登录密码',
                  onChanged: (text) {
                    controllers[1].text = text;
                  },
                  onClearTap: () {
                    controllers[1].clear();
                  },
                ),
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TDButton(
                      type: TDButtonType.outline,
                      size: TDButtonSize.large,
                      shape: TDButtonShape.rectangle,
                      theme: TDButtonTheme.primary,
                      onTap: () {
                        //login
                        ref
                            .read(userProvider.notifier)
                            .login(controllers[0].text, controllers[1].text);
                      },
                      child: const Text('Login'),
                    ),
                    const TDText('   or   '),
                    TDButton(
                      type: TDButtonType.outline,
                      size: TDButtonSize.large,
                      shape: TDButtonShape.rectangle,
                      theme: TDButtonTheme.defaultTheme,
                      onTap: () {
                        TDToast.showText('Register button clicked',
                            context: context);
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
                TDButton(
                  size: TDButtonSize.large,
                  shape: TDButtonShape.rectangle,
                  theme: TDButtonTheme.defaultTheme,
                  onTap: () {
                    //login
                    Routemaster.of(context).push('/');
                  },
                  child: const Text('已登录，直接跳转到首页'),
                ),
              ],
            ),
            error: (error, stackTrace) => Text(' $error'),
            loading: () => const TDLoading(
              size: TDLoadingSize.large,
              icon: TDLoadingIcon.activity,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:fdflutter/core/localization/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(AppLocale.settingPageTitle.getString(context))),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TDText(
              '01 选择语言',
              font: TDTheme.of(context).fontTitleLarge,
              textColor: TDTheme.of(context).fontGyColor1,
            ),
            const SizedBox(height: 16),
            TDRadioGroup(
              key: GlobalKey(debugLabel: 'language'),
              onRadioGroupChange: (selectedId) => _localization.translate(
                selectedId ?? 'en',
              ),
              selectId: _localization.currentLocale!.languageCode,
              cardMode: true,
              direction: Axis.horizontal,
              directionalTdRadios: const [
                TDRadio(
                  id: 'en',
                  title: '英文',
                  cardMode: true,
                ),
                TDRadio(
                  id: 'zh',
                  title: '中文',
                  cardMode: true,
                ),
                TDRadio(
                  id: 'ja',
                  title: '小日子',
                  cardMode: true,
                ),
              ],
            ),
            const SizedBox(height: 16),
            TDText(
              '02 主体模式',
              font: TDTheme.of(context).fontTitleLarge,
              textColor: TDTheme.of(context).fontGyColor1,
            ),
            const SizedBox(height: 16),
            TDRadioGroup(
              key: GlobalKey(debugLabel: 'themeMode'),
              onRadioGroupChange: (selectedId) =>
                  AdaptiveTheme.of(context).setThemeMode(selectedId == 'Dark'
                      ? AdaptiveThemeMode.dark
                      : selectedId == 'Light'
                          ? AdaptiveThemeMode.light
                          : AdaptiveThemeMode.system),
              selectId: AdaptiveTheme.of(context).mode.modeName,
              cardMode: true,
              direction: Axis.horizontal,
              directionalTdRadios: const [
                TDRadio(
                  id: 'Dark',
                  title: '暗黑',
                  cardMode: true,
                ),
                TDRadio(
                  id: 'Light',
                  title: '白天',
                  cardMode: true,
                ),
                TDRadio(
                  id: 'System',
                  title: '更随系统',
                  cardMode: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.title,
    required this.content,
  });

  final String? title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(title ?? '')),
          const Text(' : '),
          Expanded(child: Text(content ?? '')),
        ],
      ),
    );
  }
}

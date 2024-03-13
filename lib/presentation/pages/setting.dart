import 'package:fdflutter/core/localization/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
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
      body: SettingsList(sections: [
        SettingsSection(
          title: const Text('General settings'),
          tiles: [
            SettingsTile.navigation(
                title: const Text('Language'),
                leading: const Icon(Icons.language),
                descriptionInlineIos: true,
                description: Text(
                    languageName(_localization.currentLocale!.languageCode)),
                onPressed: (BuildContext context) {
                  // show bottom sheet
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      // show picker
                      return SizedBox(
                        height: 200,
                        child: CupertinoPicker(
                          itemExtent: 50,
                          useMagnifier: true,
                          onSelectedItemChanged: (int index) {
                            // change language
                            _localization.translate(
                              mapLocales[index].languageCode,
                            );
                          },
                          children: mapLocales
                              .map((e) => Text(languageName(e.languageCode)))
                              .toList(),
                        ),
                      );
                    },
                  );
                }),
            SettingsTile.navigation(
                title: const Text('Theme'),
                leading: const Icon(Icons.dark_mode),
                descriptionInlineIos: true,
                description: Text(AdaptiveTheme.of(context).mode.modeName),
                onPressed: (BuildContext context) {
                  // show bottom sheet
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      // show picker
                      return SizedBox(
                        height: 200,
                        child: CupertinoPicker(
                            itemExtent: 50,
                            useMagnifier: true,
                            onSelectedItemChanged: (int index) {
                              // change language
                              AdaptiveTheme.of(context)
                                  .setThemeMode(themeList[index].$1);
                            },
                            children:
                                themeList.map((e) => Text(e.$2)).toList()),
                      );
                    },
                  );
                }),
          ],
        ),
      ]),
    );
  }

  List<(AdaptiveThemeMode, String)> themeList = <(AdaptiveThemeMode, String)>[
    (AdaptiveThemeMode.light, "Light"),
    (AdaptiveThemeMode.dark, "Dark"),
    (
      AdaptiveThemeMode.system,
      "System",
    )
  ];

  String languageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'zh':
        return '简体中文';
      case 'ja':
        return '小日子';
      default:
        return 'English';
    }
  }
}

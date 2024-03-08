import 'package:fdflutter/core/localization/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

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
      appBar: AppBar(title: Text(AppLocale.title.getString(context))),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: const Text('English'),
                    onPressed: () {
                      _localization.translate('en');
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    child: const Text('中文'),
                    onPressed: () {
                      _localization.translate('zh');
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    child: const Text('日本語'),
                    onPressed: () {
                      _localization.translate('ja', save: false);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ItemWidget(
              title: 'Current Language',
              content: _localization.getLanguageName(),
            ),
            ItemWidget(
              title: 'Font Family',
              content: _localization.fontFamily,
            ),
            ItemWidget(
              title: 'Locale Identifier',
              content: _localization.currentLocale.localeIdentifier,
            ),
            ItemWidget(
              title: 'String Format',
              content: Strings.format(
                'Hello %a, this is me %a.',
                ['Dara', 'Sopheak'],
              ),
            ),
            ItemWidget(
              title: 'Context Format String',
              content: context.formatString(
                AppLocale.thisIs,
                [AppLocale.title, 'LATEST'],
              ),
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

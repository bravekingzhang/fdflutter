import 'package:flutter/material.dart';
import '../providers/example_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExamplePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exampleData = ref.watch(exampleDataProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Example Page')),
      body: Center(child: Text(exampleData)),
    );
  }
}

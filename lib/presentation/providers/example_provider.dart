import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../usecases/get_example_data.dart';

final exampleDataProvider = FutureProvider<String>((ref) async {
  final getExampleData = ref.read(getExampleDataProvider);
  final exampleEntity = await getExampleData();
  return exampleEntity.data;
});

// Define other providers as needed

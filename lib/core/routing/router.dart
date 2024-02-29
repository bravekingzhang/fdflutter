import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:fdflutter/presentation/pages/example_page.dart';

final RouteMap routes = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(child: ExamplePage()),
    // Add other routes as needed
  },
);

import 'package:flutter/material.dart';
import 'package:food_app/pages/welcome.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qsifqppazmutvmuyxwob.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFzaWZxcHBhem11dHZtdXl4d29iIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTczNDc4MjMsImV4cCI6MjA3MjkyMzgyM30.rWfbbFOajmenD-GNuRRipxsaZYVXleFJd_VDrAFJO6U',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery App',
      home: const WelcomeScreen(),
    );
  }
}

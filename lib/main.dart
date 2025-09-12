import 'package:flutter/material.dart';
import 'package:food_app/pages/welcome.dart';
import 'package:food_app/pages/bottomnav.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    // Listen for auth state changes (GitHub login will trigger this)
    supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      if (session != null) {
        // User is logged in -> go to BottomNav
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BottomNav()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery App',
      home: const WelcomeScreen(),
    );
  }
}

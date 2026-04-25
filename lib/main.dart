import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zlyakkbhmctanmjtruou.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpseWFra2JobWN0YW5tanRydW91Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzY4NzEzNTEsImV4cCI6MjA5MjQ0NzM1MX0.j2YNuRvmVyZi1Td2OaTBMlGr2CAIPNq8rTm61Ae-UFw', // 👈 paste here
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
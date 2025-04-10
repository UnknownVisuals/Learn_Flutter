import 'package:flutter/material.dart';
import 'package:learn_flutter/signin_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Supabase.initialize(
    url: 'https://zonsjxxjpumsauhjfkiz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpvbnNqeHhqcHVtc2F1aGpma2l6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE3ODE5MTgsImV4cCI6MjA1NzM1NzkxOH0.gIKUhbCYZKZRiT42iY2DxG1Sq7ih4bzC9U5Xxlhe5cE',
  );

  runApp(const MyApp());
}

// Get a reference your Supabase client
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SigninPage(),
    );
  }
}

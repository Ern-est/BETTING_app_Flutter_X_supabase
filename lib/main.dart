import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url:
        'https://yabjtpyjtwbdjsdmnwfc.supabase.co', // Replace with your Project URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlhYmp0cHlqdHdiZGpzZG1ud2ZjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDgzNTMxNDEsImV4cCI6MjA2MzkyOTE0MX0.wxZa65V0W5JVwXuAIIOERn1HBDFAgGf8UqDsQabF4fg', // Replace with your Anon Key
  );

  runApp(const BetMateApp());
}

class BetMateApp extends StatelessWidget {
  const BetMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BetMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

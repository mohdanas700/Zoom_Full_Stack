import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoom_full_stack/resources/auth_methods.dart';
import 'package:zoom_full_stack/screens/home_screen.dart';
import 'package:zoom_full_stack/screens/login_screen.dart';
import 'package:zoom_full_stack/screens/video_call_screen.dart';
import 'package:zoom_full_stack/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:572793570031:ios:cad97874c792fccc70511a',
      apiKey: 'AIzaSyBbd5UGa6injiajIreW9ki7j_xZicNrRXQ',
      projectId: '572793570031',
      messagingSenderId: '572793570031',
      measurementId: 'YOUR_MEASUREMENT_ID', // Optional: Can be left empty or null if you're not using Google Analytics
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Full Stack Zoom',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/video-call': (context) => const VideoCallScreen()
      },
      home: StreamBuilder(
        stream: AuthMethods().authChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return const HomeScreen();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}

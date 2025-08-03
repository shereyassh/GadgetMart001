import 'package:dummytest/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'loginPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('Flutter bindings initialized');
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized');
  } catch (e, stack) {
    print('Firebase initialization failed: $e');
    print(stack);
  }
  runApp(const MyApp());
  print('runApp called');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gadgetmartbnp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5F6FA), // light grey background
        primaryColor: Color(0xFF757575), // metal grey
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFF5F6FA), // match background
          foregroundColor: Color(0xFF232323), // dark text
          elevation: 0,
        ),
        cardColor: Colors.white, // white for cards/panels/inputs
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFF00B4FF), // blue accent
          primary: Color(0xFF757575), // metal grey
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF232323)), // main text
          bodyMedium: TextStyle(color: Color(0xFF757575)), // secondary text
          labelLarge: TextStyle(color: Color(0xFF00B4FF)), // for highlights
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white, // input background
          border: OutlineInputBorder(),
          labelStyle: TextStyle(color: Color(0xFF232323)), // dark label
          hintStyle: TextStyle(color: Color(0xFF757575)), // grey hint
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF00B4FF), // blue for buttons
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: First(),
    );
  }
}

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    print('First build called');
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print('StreamBuilder builder called, connectionState: ${snapshot.connectionState}, hasData: ${snapshot.hasData}, data: ${snapshot.data}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('Waiting for auth state...');
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error in auth state: ${snapshot.error}');
            return Center(child: Text('Something went wrong!'));
          } else if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              print('Navigating to LoginPage');
              return LoginPage();
            } else {
              print('Navigating to HomePage');
              return const HomePage();
            }
          }
          print('Unknown state, returning empty');
          return const SizedBox.shrink();
        },
      ),
    );
  }
}


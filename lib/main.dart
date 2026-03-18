import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // CEK SESSION LOGIN
  Future<Widget> getStartPage() async {
    bool isLogin = await AuthService.isLogin();
    return isLogin ? const HomePage() : const LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login App',

      // 🎨 THEME BIAR BAGUS
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 12,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ),

      // 🚀 START PAGE (CEK LOGIN)
      home: FutureBuilder<Widget>(
        future: getStartPage(),
        builder: (context, snapshot) {
          // loading saat cek session
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          // kalau ada error
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text("Terjadi kesalahan")),
            );
          }

          // tampilkan halaman
          return snapshot.data!;
        },
      ),
    );
  }
}

//
// 🔵 SPLASH SCREEN (LOADING AWAL)
//
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.flutter_dash, size: 80, color: Colors.white),
              SizedBox(height: 20),
              CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

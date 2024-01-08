import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';
import '../widgets/background_image.dart';
import 'login_screen.dart';
import 'main_bottom_nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void splashScreenTimeOut() async {
    bool isLoggedIn = await Auth.checkUserAuthState();

    Future.delayed(const Duration(seconds: 2)).then(
          (value) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
          isLoggedIn ? const MainBottomNavScreen() : const LoginScreen(),
        ),
            (route) => false,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    splashScreenTimeOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WithBackGroundImage(
        showBottomCircularLoading: true,
        child: Center(
          child: Image.network('https://img.freepik.com/premium-vector/task-manager-vector-illustration-effective-time-management_427922-186.jpg?w=2000',
            width: 400,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:moduletwelveassignment_taskmanager/ui/screens/signup_screen.dart';
import '../../data/models/user_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../../style/style.dart';
import '../controller/auth_controller.dart';
import '../controller/input_validations.dart';
import '../widgets/background_image.dart';
import '../widgets/snack_bar.dart';
import 'forget_password_screen.dart';
import 'main_bottom_nav_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailInputTEController = TextEditingController();
  final TextEditingController _passwordInputTEController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool loginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WithBackGroundImage(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 60,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Task Manager",
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailInputTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      validator: FormValidation.emailValidation,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordInputTEController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                      validator: FormValidation.inputValidation,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: loginInProgress == false,
                        replacement: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Center(
                              child: CircularProgressIndicator(
                                color: PrimaryColor.color,
                              )),
                        ),
                        child: ElevatedButton(
                            onPressed: _login,
                            child:
                            const Icon(Icons.arrow_circle_right_rounded)),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const ForgetPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forget Password ?",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have Account?",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(color: PrimaryColor.color),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    loginInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.login,
      body: {
        "email": _emailInputTEController.text.trim(),
        "password": _passwordInputTEController.text,
      },
      isLogin: true,
    );

    loginInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      await Auth.saveUserInformation(
        response.jsonResponse["token"],
        UserModel.fromJson(response.jsonResponse['data']),
      );
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainBottomNavScreen(),
            ),
                (route) => false);
      }
    } else {
      if (response.statusCode == 401) {
        if (mounted) {
          showSnackBar(context, "Email or Password is Incorrect.", true);
        }
      } else {
        if (mounted) {
          showSnackBar(context, "Login Failed! Please try again.", true);
        }
      }
    }
  }

  @override
  void dispose() {
    _emailInputTEController.dispose();
    _passwordInputTEController.dispose();
    super.dispose();
  }
}
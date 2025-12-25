import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_page.dart';
import 'signUp.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Login API call
  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    final url = Uri.parse("http://10.0.2.2:8081/auth/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      print("Status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        // Save token to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);
        print("✅ Login successful. Token: $token");

        // Show success dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            // After a short delay, automatically navigate to Dashboard
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardPage()),
              );
            });

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.check_circle, color: Color(0xFFE655A8), size: 60),
                  SizedBox(height: 16),
                  Text(
                    "Login Successful!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Welcome back to Health AI.",
                    style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        );
      } else {
        final errorMsg = jsonDecode(response.body)['error'] ?? response.body;
        print("❌ Login failed: $errorMsg");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Login failed: $errorMsg")));
      }
    } catch (e) {
      print("⚠️ Error during login: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF1F6),
      body: SafeArea(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              // Background image
              SizedBox(
                height: screenHeight * 0.35,
                width: screenWidth,
                child: Image.asset(
                  'assets/backgroundLogin.jpeg',
                  fit: BoxFit.cover,
                ),
              ),

              // White card
              Positioned(
                top: screenHeight * 0.30,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Log in to your Health AI account.',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Email field
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email or Username',
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              color: Color(0xFFE655A8),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFDF1F6),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password field
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Color(0xFFE655A8),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFDF1F6),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Login button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await login(
                                context,
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE655A8),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Sign up
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Color(0xFF666666)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SignUpPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE655A8),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

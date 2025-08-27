import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:cloud_functions/cloud_functions.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginEmailController.text.trim(),
        password: _loginPasswordController.text.trim(),
      );
      Fluttertoast.showToast(msg: "Login successful 🚀");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? "Login failed");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🔮 پس‌زمینه انیمیشنی
          CircularParticle(
            key: UniqueKey(),
            awayRadius: 80,
            numberOfParticles: 150,
            speedOfParticles: 1.2,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            onTapAnimation: true,
            particleColor: Colors.white.withOpacity(.6),
            awayAnimationDuration: const Duration(milliseconds: 600),
            maxParticleSize: 4,
            isRandSize: true,
            isRandomColor: true,
            connectDots: true,
          ),

          // 📦 کارت شیشه‌ای
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: GlassmorphicContainer(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 550,
                borderRadius: 30,
                blur: 20,
                alignment: Alignment.center,
                border: 2,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.05),
                  ],
                  stops: const [0.1, 1],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purpleAccent.withOpacity(0.5),
                    Colors.blueAccent.withOpacity(0.5),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // متن خوشامد
                      AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            'Welcome Back!',
                            textStyle: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                            colors: [
                              Colors.deepPurple,
                              Colors.purpleAccent,
                              Colors.blueAccent,
                              Colors.pinkAccent,
                            ],
                          ),
                        ],
                        isRepeatingAnimation: true,
                      ),
                      const SizedBox(height: 20),

                      // تب ورود و ثبت‌نام
                      TabBar(
                        controller: _tabController,
                        tabs: const [
                          Tab(text: "Login"),
                          Tab(text: "Register"),
                        ],
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.deepPurple.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildLoginTab(),
                            _RegisterStepper(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _labeledField("Enter your Email", _loginEmailController, "Email"),
        _labeledField("Enter your Password", _loginPasswordController, "Password", obscure: true),
        const SizedBox(height: 30),
        _customButton("Login", _login),
      ],
    );
  }

  Widget _labeledField(String label, TextEditingController controller, String hint, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            obscureText: obscure,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: Colors.white.withOpacity(0.15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.purpleAccent, width: 2),
              ),
              prefixIcon: Icon(
                hint == "Email" ? Icons.email_outlined : Icons.lock_outline,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customButton(String text, Function() onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Colors.purpleAccent, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent.withOpacity(0.6),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}

// 🌟 ثبت‌نام مرحله‌ای با OTP واقعی
class _RegisterStepper extends StatefulWidget {
  @override
  State<_RegisterStepper> createState() => _RegisterStepperState();
}

class _RegisterStepperState extends State<_RegisterStepper> {
  int _currentStep = 0;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _generatedOtp = "";

  Future<void> _sendOtp() async {
    if (_emailController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter your email ❌");
      return;
    }

    // تولید OTP 6 رقمی
    _generatedOtp = (100000 + (DateTime.now().millisecondsSinceEpoch % 900000)).toString();

    try {
      final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('sendOtpEmail');
      final response = await callable.call(<String, dynamic>{
        'email': _emailController.text.trim(),
        'otp': _generatedOtp,
      });

      Fluttertoast.showToast(msg: response.data['message']);
    } catch (e) {
      Fluttertoast.showToast(msg: "خطا در ارسال OTP: $e");
    }
  }

  bool _validatePassword(String pass) {
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
    return regex.hasMatch(pass);
  }

  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      Fluttertoast.showToast(msg: "Passwords do not match ❌");
      return;
    }
    if (!_validatePassword(_passwordController.text)) {
      Fluttertoast.showToast(
          msg: "Password must be 8+ chars, include upper, lower & number 🔐");
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Fluttertoast.showToast(msg: "Account created 🎉");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? "Registration failed ❌");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _currentStep,
      onStepContinue: () async {
        if (_currentStep == 0) {
          if (_emailController.text.isEmpty || _nameController.text.isEmpty) {
            Fluttertoast.showToast(msg: "Please fill all fields");
            return;
          }
          await _sendOtp();
          setState(() => _currentStep += 1);
        } else if (_currentStep == 1) {
          if (_otpController.text == _generatedOtp) {
            setState(() => _currentStep += 1);
          } else {
            Fluttertoast.showToast(msg: "Invalid verification code ❌");
          }
        } else if (_currentStep == 2) {
          await _register();
        }
      },
      onStepCancel: () {
        if (_currentStep > 0) {
          setState(() => _currentStep -= 1);
        }
      },
      steps: [
        Step(
          title: const Text("Basic Info"),
          content: Column(
            children: [
              _field("Full Name", _nameController, Icons.person),
              _field("Email", _emailController, Icons.email),
            ],
          ),
          isActive: _currentStep >= 0,
        ),
        Step(
          title: const Text("Verify Email"),
          content: Column(
            children: [
              const Text("Enter the 6-digit code sent to your email"),
              _field("Verification Code", _otpController, Icons.lock),
            ],
          ),
          isActive: _currentStep >= 1,
        ),
        Step(
          title: const Text("Set Password"),
          content: Column(
            children: [
              _field("Password", _passwordController, Icons.lock, obscure: true),
              _field("Confirm Password", _confirmPasswordController, Icons.lock, obscure: true),
            ],
          ),
          isActive: _currentStep >= 2,
        ),
      ],
    );
  }

  Widget _field(String hint, TextEditingController controller, IconData icon,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: Icon(icon, color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

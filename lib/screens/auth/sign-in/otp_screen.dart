import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:urban_nest/backend/auth/auth_model.dart';
import 'package:urban_nest/screens/home/home_screen.dart';
import 'package:urban_nest/screens/home/index_screen.dart';

class OtpScreen extends StatefulWidget {
  final String userId;
  final String mobileNumber;

  const OtpScreen({
    super.key,
    required this.userId,
    required this.mobileNumber,
  });

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isVerifying = false;
  final AuthService _authService = AuthService();
  

  void _verifyOTP() async {
    final otp = _otpController.text.trim();
    print(widget.userId);

    if (otp.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter the OTP')),
      );
      return;
    }

    try {
      
      final session = await _authService.verifyPhoneAuth(widget.userId, otp);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phone verification successful!')));

      // Navigate to the dashboard or home screen
      Get.to(() => const IndexScreen());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OTP Verification")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter the OTP sent to ${widget.mobileNumber}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                labelText: "OTP",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            _isVerifying
                ? const Center(child: CircularProgressIndicator())
                : InkWell(
                  onTap: _verifyOTP,
                  child: const Card(
                      color: Colors.blue,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("Verify OTP"),
                      ),
                    ),
                ),
          ],
        ),
      ),
    );
  }
}

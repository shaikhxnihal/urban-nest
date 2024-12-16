import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:urban_nest/screens/home/home_screen.dart';
import 'package:urban_nest/screens/home/index_screen.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String mobileNumber;

  const OtpScreen({
    super.key,
    required this.verificationId,
    required this.mobileNumber,
  });

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isVerifying = false;

  void _verifyOtp() async {
    if (_otpController.text.isEmpty || _otpController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 6-digit OTP")),
      );
      return;
    }

    setState(() => _isVerifying = true);

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _otpController.text.trim(),
      );

      await auth.signInWithCredential(credential);

      setState(() => _isVerifying = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Phone number verified successfully!")),
      );

      // Navigate to Home or Dashboard
      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      setState(() => _isVerifying = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP or verification failed")),
      );
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
                  onTap: () {
                    Get.to(() => const IndexScreen());
                  },
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

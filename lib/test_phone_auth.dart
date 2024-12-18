import 'package:flutter/material.dart';

import 'backend/auth/auth_model.dart'; // Import your AuthService

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isOTPSent = false;
  String _userId = ''; // Store the user ID for OTP verification

  void _sendOTP() async {
    final phoneNumber = _phoneController.text.trim();

    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your phone number')),
      );
      return;
    }

    try {
      await _authService.startPhoneAuth(phoneNumber, _userId);
      setState(() {
        _isOTPSent = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP sent successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void _verifyOTP() async {
    final otp = _otpController.text.trim();

    if (otp.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the OTP')),
      );
      return;
    }

    try {
      final session = await _authService.verifyPhoneAuth(_userId, otp);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone verification successful!')));

      // Navigate to the dashboard or home screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!_isOTPSent)
              Column(
                children: [
                  TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _sendOTP,
                    child: const Text('Send OTP'),
                  ),
                ],
              ),
            if (_isOTPSent)
              Column(
                children: [
                  TextField(
                    controller: _otpController,
                    decoration: const InputDecoration(labelText: 'Enter OTP'),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _verifyOTP,
                    child: const Text('Verify OTP'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'otp_screen.dart';

// class MobileNumberScreen extends StatefulWidget {
//   @override
//   _MobileNumberScreenState createState() => _MobileNumberScreenState();
// }

// class _MobileNumberScreenState extends State<MobileNumberScreen> {
//   final TextEditingController _phoneController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;

//   void _sendOTP() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);

//       FirebaseAuth auth = FirebaseAuth.instance;

//       await auth.verifyPhoneNumber(
//         phoneNumber: _phoneController.text.trim(),
//         verificationCompleted: (PhoneAuthCredential credential) {
//           // Auto-complete OTP
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           setState(() => _isLoading = false);
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(e.message ?? "Verification failed")),
//           );
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           setState(() => _isLoading = false);
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => OtpScreen(verificationId: verificationId),
//             ),
//           );
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           // Handle timeout
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Mobile Number Login")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Enter your mobile number",
//                 style: TextStyle(fontSize: 18),
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 controller: _phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   labelText: "Mobile Number",
//                   hintText: "+1 123 456 7890",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter your mobile number";
//                   }
//                   if (!RegExp(r'^\+[1-9]\d{1,14}$').hasMatch(value)) {
//                     return "Enter a valid phone number with country code";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               _isLoading
//                   ? Center(child: CircularProgressIndicator())
//                   : ElevatedButton(
//                       onPressed: _sendOTP,
//                       child: Text("Send OTP"),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

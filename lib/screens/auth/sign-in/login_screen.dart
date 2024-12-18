import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:urban_nest/backend/auth/auth_model.dart';
import 'package:urban_nest/constants/image_links.dart';
import 'package:urban_nest/screens/auth/sign-in/otp_screen.dart';
import 'package:urban_nest/screens/auth/sign-in/phone_auth_screen.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  
  

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();
  
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
      Get.to(() => OtpScreen(userId: _userId, mobileNumber: _phoneController.text,));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        toolbarHeight: 200,
        flexibleSpace: Container(
          width: width,
          height:200,
          color: Colors.transparent,
          child:  Column(
            children: [
              SizedBox(height: height / 12,),
              const Text('URBAN NEST', style: TextStyle(color: Colors.white, fontSize: 36),),
              Text('All in one Real-Estate', style: TextStyle(color: Colors.grey.shade200, fontSize: 16),),
              SizedBox(height: height / 25,),
              Text('Buy | Sell | Rent - Commercial | Residential', style: TextStyle(color: Colors.grey.shade200, fontSize: 16),),
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FlutterCarousel(items: [
              Container(
                height: 500,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(LoginScreenImages.slider_one), fit: BoxFit.cover)
                ),
                
              ),
                Container(
                height: 500,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(LoginScreenImages.slider_two), fit: BoxFit.cover)
                ),
                
              ),
               Container(
                height: 500,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(LoginScreenImages.slider_three), fit: BoxFit.cover)
                ),
              ),
            ], options: FlutterCarouselOptions(
              viewportFraction: 0.999,
              height: 500,
              enableInfiniteScroll: true,
              floatingIndicator: true
            )),
            SizedBox(height: height / 35,),
            const Text('Please signin to continue', style: TextStyle(color: Colors.black, fontSize: 20),),
            SizedBox(height: height / 25,),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _phoneController,
                    onEditingComplete: () => _sendOTP,
                    keyboardType: TextInputType.phone,
                    decoration:  InputDecoration(
                      labelText: "Enter your phone no.",
                      prefixIcon: Icon(Icons.phone),
                      border: InputBorder.none,
                      suffixIcon: InkWell(
                        onTap: _sendOTP,
                        child: Icon(Icons.arrow_right_alt)),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/google.png'),
                  ),
                  title: Text("Continue with Google"),
                  trailing: Icon(Icons.arrow_right_alt),
                ),
              ),
            ),
           
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: height/15,
        width: width,
        child: const Center(
          child: Text("Terms & Conditions"),
        ),
      ),
    );
  }
}
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';

class SampleTestScreen extends StatefulWidget {
   SampleTestScreen({super.key});

  final Client client = Client().setProject('67628bb600216f03b34c');
  
  @override
  State<SampleTestScreen> createState() => _SampleTestScreenState();
}

class _SampleTestScreenState extends State<SampleTestScreen> {
  List<models.Country> _countries = [];

  void getCountries(){
    Locale locale = Locale(widget.client);

    Future<models.CountryList> result = locale.listCountries();

    result.then((res){
      setState(() {
        _countries = res.countries;
      });
    }).catchError((error){
      debugPrint(error);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test Screen"),),

      body: SingleChildScrollView(
        child: Column(
          children: _countries.map((c)=> Text(c.name)).toList()
        ),
      ),
      bottomNavigationBar: Container(
        height: 150,
        
        child: ElevatedButton(onPressed: getCountries, child: Center(child: Text("Get"),))),
    );
  }
}
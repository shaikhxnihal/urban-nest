import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_nest/components/cards/home_product_card.dart';
import 'package:urban_nest/components/cards/home_product_card_horiz.dart';
import 'package:urban_nest/components/delegates/custom_search_delegate.dart';
import 'package:urban_nest/constants/image_links.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:urban_nest/screens/home/property_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<String> _smallCardsImage = [
    LoginScreenImages.slider_one,
    LoginScreenImages.slider_two,
    LoginScreenImages.slider_three,
    LoginScreenImages.slider_one
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text("Urban Nest", style: TextStyle(fontSize: 26),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              label: AnimatedTextKit(
                isRepeatingAnimation: true,
                repeatForever: true,
                
                animatedTexts: [
                ColorizeAnimatedText("1200+ Properties Available", textStyle: const TextStyle(fontSize: 12), colors: [ Colors.green, Colors.black])
              ]),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child:  Text("Get the best properties \nnearest to you.", style: TextStyle(fontSize: 32, color: Colors.grey.shade800), textAlign: TextAlign.start,),
            ),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchBar()
            ),
            const Divider(),
            ListTile(
              leading: const Icon(CupertinoIcons.building_2_fill),
              title: Text("Hot Properties", style: TextStyle(fontSize: 24, color: Colors.grey.shade800), textAlign: TextAlign.start,),
             ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_smallCardsImage.length, (index) {
                  return GestureDetector(
                    
                    onTap: () {
                      Get.to(() => PropertyDetailScreen(title: "Property ${index + 1}", location: "City ${index + 1}", price: "\$${(index + 1) * 100}k", imageUrl: _smallCardsImage[index], description: "description"));
                    },
                    child: PropertyCardHoriz(
                      title: "Property ${index + 1}",
                      location: "City ${index + 1}",
                      price: "\$${(index + 1) * 100}k",
                      imageUrl: _smallCardsImage[index],
                    ),
                  );
                }),
              ),
            ),
             const Padding(
               padding: EdgeInsets.only(left: 20, right: 20),
               child: Divider(),
             ),
            const SizedBox(height: 10,),
             ListTile(
              leading: const Icon(CupertinoIcons.building_2_fill),
              title: Text("Upcoming Projects", style: TextStyle(fontSize: 24, color: Colors.grey.shade800), textAlign: TextAlign.start,),
             ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return PropertyCard(imageUrl: LoginScreenImages.slider_one, title: "Billa Hone", location: "New Jersey", price: "P.O.S", propertyType: "For Sale", onViewDetails: (){
                  Get.to(() => PropertyDetailScreen(title: "Property ${index + 1}", location: "City ${index + 1}", price: "\$${(index + 1) * 100}k", imageUrl: _smallCardsImage[index], description: "description"));
                });
              },
            ),
          ],
        ),
      ),
      );
  }
}


class CupertinoSearchBar extends StatefulWidget {
  @override
  State<CupertinoSearchBar> createState() => _CupertinoSearchBarState();
}

class _CupertinoSearchBarState extends State<CupertinoSearchBar> {
  TextEditingController _textEditingController = TextEditingController();
  bool _clearIconEnable = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.search,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
           Expanded(
            child: TextField(
              onTap: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              controller: _textEditingController,
              onChanged: (value){
                if (value.isNotEmpty) {
                  setState(() {
                  _clearIconEnable = true;
                });
                }else{
                  setState(() {
                  _clearIconEnable = false;
                });
                }
                
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _textEditingController.text = "";
                _clearIconEnable = false;
              });
            },
            icon:  Icon(
              CupertinoIcons.xmark_circle_fill,
              color: _clearIconEnable ? Colors.black : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class PropertyDetailScreen extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final String imageUrl;
  final String description;

  const PropertyDetailScreen({
    Key? key,
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.3),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Property Details", style: TextStyle(color: Colors.white),),
        leadingWidth: 35,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      
      body: CustomScrollView(
        slivers: [
          // Sliver AppBar for image
          SliverAppBar(
            expandedHeight: 300,
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(color: Colors.blue),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              background: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Property Details Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Price: $price",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    icon: const Icon(Icons.phone, color: Colors.white),
                    label: const Text(
                      "Contact Agent",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    icon: const Icon(Icons.bookmark_border, color: Colors.white),
                    label: const Text(
                      "Save Property",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:project/app/Models/Product.dart';
// // Import controller LatihanController
// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:project/app/utils/widgets/bottom_nav_bar.dart';

// class LatihanView extends StatefulWidget {
//   const LatihanView({Key? key}) : super(key: key);

//   @override
//   State<LatihanView> createState() => _LatihanViewState();
// }

// class _LatihanViewState extends State<LatihanView> {
//   late Future<Catalog> _futureCatalog;

//   @override
//   void initState() {
//     super.initState();
//     _futureCatalog = fetchCatalog();
//   }

//   Future<Catalog> fetchCatalog() async {
//     final response =
//         await http.get(Uri.parse('https://api.zalando.com/categories'));

//     if (response.statusCode == 200) {
//       return Catalog.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load data from the URL');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Catalog View'),
//       ),
//       body: FutureBuilder<Catalog>(
//         future: _futureCatalog,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData) {
//             return Center(child: Text('No Data Available'));
//           }

//           final catalog = snapshot.data!;
//           return ListView(
//             children: [
//               ListTile(
//                 title: Text('Page: ${catalog.page}'),
//               ),
//               ListTile(
//                 title: Text('Size: ${catalog.size}'),
//               ),
//               ListTile(
//                 title: Text('Total Elements: ${catalog.totalElements}'),
//               ),
//               ListTile(
//                 title: Text('Total Pages: ${catalog.totalPages}'),
//               ),
//               ListTile(
//                 title: Text('Sections:'),
//               ),
//               for (var section in catalog.content)
//                 ListTile(
//                   title: Text('Key: ${section.key}'),
//                   subtitle: Text('Name: ${section.name}'),
//                 ),
//             ],
//           );
//         },
//       ),
//       bottomNavigationBar: BottomNavBar(index: 0),
//     );
//   }
// }

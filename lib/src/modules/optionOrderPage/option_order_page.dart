import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/category.dart';
import '../../firebase/category_firestore.dart'; // Make sure to import the correct path for CategoryFireStore

class OptionOrderPage extends StatefulWidget {
  const OptionOrderPage({Key? key}) : super(key: key);

  @override
  _OptionOrderPageState createState() => _OptionOrderPageState();
}

class _OptionOrderPageState extends State<OptionOrderPage> {
  late final Stream<QuerySnapshot> _stream=
  FirebaseFirestore.instance.collection('Category').snapshots();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe6e0c7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF492803),
        title: const Text(
          'Orders',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            fontFamily: 'Lora',
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
        child: StreamBuilder(
            stream: _stream ,
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return const Center(child:CircularProgressIndicator()) ;
              }
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    Categories categories=Categories(
                        snapshot.data!.docs[index].id,
                        snapshot.data!.docs[index]['name'],
                        snapshot.data!.docs[index]['image_url'],
                    );
                    return CardCategory(category: categories);
                  });
            }
        )
    )

        );
  }
}



class CardCategory extends StatelessWidget {
  CardCategory({
    Key? key,
    required this.category,
  }) : super(key: key);

 Categories category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.network(
            category.imageUrl, // Use the image URL from Firebase Storage
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          category.name, // Use the category name from the Category object
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Itim',
            fontWeight: FontWeight.w600,
            color: Color(0xFF492803),
          ),
        ),
      ],
    );
  }
}

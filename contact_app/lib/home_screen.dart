import 'dart:io';

import 'package:contact_app/screen/add_new_contact_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        title: const Text('Contact List'),
        actions: [
          IconButton(onPressed: (){
            setState(() {

            });}, icon:const Icon(Icons.restore_rounded,color: Colors.black,))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          arrForm.isEmpty ? Center(child: Text('Add Contact List')) :
          Expanded(
            child: ListView.builder(
              itemCount: arrForm.length,
                itemBuilder: (context, index) {
              return ListTile(
                leading: Image(image: FileImage(File(arrForm[index]['image']))),
                title: Text(arrForm[index]['name']),
                subtitle: Text(arrForm[index]['phone']),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewContactScreen())).then((value) => setState(() {

                  }),);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

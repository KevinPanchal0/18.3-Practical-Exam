import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

List<Map<String, dynamic>> arrForm = [];


class AddNewContactScreen extends StatefulWidget {
  const AddNewContactScreen({super.key});

  @override
  State<AddNewContactScreen> createState() => _AddNewContactScreenState();
}

class _AddNewContactScreenState extends State<AddNewContactScreen> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
        title: const Text('New Contact'),


      ),
      body: Column(
        children: [
          Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  const SizedBox(height: 25,),
                  Center(
                    child: _image == null
                        ? InkWell(
                            onTap: getImage,
                            child: const CircleAvatar(
                                maxRadius: 60, child: Icon(Icons.add,size: 50,)))
                        : CircleAvatar(
                            maxRadius: 60,
                            backgroundImage: FileImage(File(_image!.path))),
                  ),
                  const SizedBox(height: 25,),
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name Field is Empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.drive_file_rename_outline),
                      label: Text('Name'),
                      border: OutlineInputBorder()
                    ),
                  ),
                  const SizedBox(height: 25,),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: AutofillHints.telephoneNumber,
                      prefixIcon: Icon(Icons.phone),
                      label: Text(
                        'Phone',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone Field is Empty';
                      } else if (value.length > 10) {
                        return 'No. must be 10 digit long';
                      } else if (value.length < 10) {
                        return 'No. must be 10 digit greater';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25,),

                  ElevatedButton(onPressed:_submitForm, child: const Text('Save Contact'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
        arrForm.add(
          {
            'name': _nameController.text,
            'phone': _phoneController.text,
            'image' : _image!.path,
          },
        );

        final String fileName = '00_${_nameController.text}_${_phoneController.text}';
        final Directory doc =await getApplicationDocumentsDirectory();
        final file = File('${doc.path}/$fileName.pdf');
        print(file);
      Navigator.pop(context);

    }
  }
  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

}

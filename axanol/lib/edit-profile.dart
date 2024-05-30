import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
    final Map<String, dynamic> userData;

  const EditProfile({super.key, required this.userData});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.userData['fname'] ?? '';
    _lastNameController.text = widget.userData['lname'] ?? '';
    _mobileController.text = widget.userData['mobile'] ?? '';
    _addressController.text = widget.userData['address'] ?? '';
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.orange,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _image == null
                          ? AssetImage('assets/profile_picture.png') as ImageProvider
                          : FileImage(_image!),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet()),
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              buildTextField("First Name", true, controller: _firstNameController),
              SizedBox(height: 20),
              buildTextField("Last Name", true, controller: _lastNameController),
              SizedBox(height: 20),
              buildTextField("Mobile Number", true, controller: _mobileController),
              SizedBox(height: 20),
              buildTextField("Password", true, controller: _passwordController, isPassword: true),
              SizedBox(height: 20),
              buildTextField("Address", true, controller: _addressController),
              SizedBox(height: 20),
              buildTextField("Detail", true, controller: _detailController, isMultiline: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, bool isRequired, {bool isPassword = false, bool isMultiline = false, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      maxLines: isMultiline ? 4 : 1,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: labelText + ' ',
            style: TextStyle(color: Colors.black, fontFamily: 'Roboto'),
            children: [
              if (isRequired)
                TextSpan(
                  text: '*',
                  style: TextStyle(color: Colors.red, fontFamily: 'Roboto'),
                ),
            ],
          ),
        ),
        filled: true,
        fillColor: Color(0xFFF3F5F5),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 2.0),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                label: Text("Camera"),
              ),
              TextButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                label: Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
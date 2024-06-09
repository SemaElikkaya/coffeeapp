import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  final String email;

  ProfilePage({required this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditingName = false;
  bool isEditingLastname = false;
  bool isEditingEmail = false;
  bool isEditingPhoneNumber = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  void fetchUserData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/user/${widget.email}'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        nameController.text = data['name'];
        lastnameController.text = data['lastname'];
        emailController.text = data['email'];
        phoneNumberController.text = data['phone_number'];
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to fetch user data')));
    }
  }

  void updateUserData() async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:3000/updateUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'name': nameController.text,
        'lastname': lastnameController.text,
        'email': emailController.text,
        'phone_number': phoneNumberController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User data updated successfully')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update user data')));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildEditableField('Name', nameController, isEditingName, () {
              setState(() {
                isEditingName = true;
              });
            }),
            buildEditableField(
                'Lastname', lastnameController, isEditingLastname, () {
              setState(() {
                isEditingLastname = true;
              });
            }),
            buildEditableField('Email', emailController, isEditingEmail, () {
              setState(() {
                isEditingEmail = true;
              });
            }),
            buildEditableField(
                'Phone Number', phoneNumberController, isEditingPhoneNumber,
                () {
              setState(() {
                isEditingPhoneNumber = true;
              });
            }),
            Spacer(),
            ElevatedButton(
              onPressed: updateUserData,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEditableField(String label, TextEditingController controller,
      bool isEditing, Function onEdit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isEditing
            ? Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(labelText: label),
                ),
              )
            : Expanded(
                child: Text(
                  controller.text,
                  style: TextStyle(fontSize: 16),
                ),
              ),
        GestureDetector(
          onTap: onEdit(),
          child: Text(
            'Change',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

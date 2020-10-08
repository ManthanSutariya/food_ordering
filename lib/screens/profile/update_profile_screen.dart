import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_ordering/screens/provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

final picker = ImagePicker();
File profilePicture;
final TextEditingController _userNameController = TextEditingController();

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.pink),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.pink,
            ),
          ),
          actions: [
            Consumer<CurrentUser>(
              builder: (context, currentUser, child) {
                return GestureDetector(
                  onTap: () async {
                    await currentUser.updateUser(displayName: _userNameController.text);
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.pink, fontSize: size.height / 45),
                  )),
                );
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(size.height / 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      var image =
                          await picker.getImage(source: ImageSource.gallery);
                      setState(() {
                        profilePicture = File(image.path);
                      });
                    },
                    child: Container(
                      height: size.height / 10,
                      width: size.width / 5,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(size.height / 50)),
                        child: profilePicture == null
                            ? Icon(Icons.cloud_upload)
                            : Image(
                                image: FileImage(profilePicture),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width / 30,
                  ),
                  Text('Change Photo'),
                ],
              ),
              SizedBox(
                height: size.height / 25,
              ),
              Text('Name'),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
              ),
              SizedBox(
                height: size.height / 25,
              ),
              Text('Phone Number'),
              GestureDetector(
                onTap: () {
                  _updatePhoneNumberBottomSheet(size: size, context: context);
                },
                child: AbsorbPointer(
                  absorbing: true,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add One',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 25,
              ),
              Text('location'),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Choose Location',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final TextEditingController _phoneNumber = TextEditingController();

_updatePhoneNumberBottomSheet({context, size}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: EdgeInsets.all(size.height / 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Phone Number',
                style: TextStyle(
                    fontSize: size.height / 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height / 40,
              ),
              Text('Phone Number'),
              TextField(
                controller: _phoneNumber,
                decoration: InputDecoration(
                  hintText: 'Edit',
                ),
              ),
              SizedBox(
                height: size.height / 40,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: double.infinity),
                child: RaisedButton(
                  onPressed: () {
                    print(_phoneNumber.text);
                  },
                  color: Colors.pinkAccent,
                  padding: EdgeInsets.all(size.height / 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(size.width / 30),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontSize: size.height / 45, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

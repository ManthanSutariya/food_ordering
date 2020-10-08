import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_ordering/main.dart';
import 'package:food_ordering/screens/profile/update_profile_screen.dart';
import 'package:food_ordering/screens/provider/provider.dart';
import 'package:provider/provider.dart';

final String back = 'assets/image2.svg';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: size.height / 1.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.width / 35),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateProfile()));
                              },
                              child: Text('Edit'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height / 60,
                        ),
                        Consumer<CurrentUser>(
                          builder: (context, currentUser, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentUser.userName ?? '-',
                                      style: TextStyle(
                                          fontSize: size.height / 30,
                                          color: Colors.white),
                                    ),
                                    Text(currentUser.userEmail),
                                    Text('View Profile >'),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print('upload screens.profile');
                                  },
                                  child: Container(
                                    height: size.height / 10,
                                    width: size.width / 5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.height / 50)),
                                      child: Container(
                                        color: Colors.amber,
                                      ),
                                      // child: profilePicture == null
                                      //     ? Icon(Icons.cloud_upload)
                                      //     : Image(
                                      //         image: FileImage(profilePicture),
                                      //         fit: BoxFit.cover,
                                      //       ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        AspectRatio(
                          aspectRatio: 3,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: getAccountScreenMainMenu(
                                    size: size,
                                    icon: Icons.settings,
                                    title: 'Setting'),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: getAccountScreenMainMenu(
                                    size: size,
                                    icon: Icons.notifications_none,
                                    title: 'Notification'),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: getAccountScreenMainMenu(
                                    size: size,
                                    icon: Icons.payment,
                                    title: 'Payments'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer<CurrentUser>(
                    builder: (context, currentUser, child) {
                      return Positioned(
                        bottom: 1,
                        right: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Food Order',
                              style: TextStyle(
                                  fontSize: size.height / 30,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              height: size.height / 30,
                            ),
                            getAccountScreenMenu(
                                icon: Icons.bookmark_border,
                                title: 'Your Order',
                                size: size),
                            SizedBox(
                              height: size.height / 60,
                            ),
                            getAccountScreenMenu(
                                icon: Icons.book,
                                title: 'Address Book',
                                size: size,
                                color: Colors.black38),
                            SizedBox(
                              height: size.height / 60,
                            ),
                            getAccountScreenMenu(
                                icon: Icons.help_outline,
                                title: 'Help On Ordering',
                                size: size),
                            SizedBox(
                              height: size.height / 30,
                            ),
                            FlatButton(
                              onPressed: () {
                                currentUser.SignOut();
                                if (currentUser.currentUser == null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()));
                                }
                              },
                              color: Colors.pinkAccent,
                              child: Text('Sign out'),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: size.height / 3.4,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  color: Colors.black12,
                  height: size.height / 5.5,
                  width: double.infinity,
                  // margin: EdgeInsets.only(left: size.height/30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Live \n For',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: size.height / 20),
                      ),
                      Text(
                        'Food',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: size.height / 20,
                            color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

getAccountScreenMenu({IconData icon, String title, color, size}) {
  return Row(
    children: [
      Icon(
        icon,
        color: color,
      ),
      SizedBox(
        width: size.width / 30,
      ),
      Text(
        title,
        style: TextStyle(fontSize: size.height / 45),
      ),
    ],
  );
}

getAccountScreenMainMenu({size, IconData icon, String title}) {
  return Container(
    margin: EdgeInsets.all(size.width / 30),
    child: Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white10,
          maxRadius: size.height / 30,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: size.height / 70,
        ),
        Text(title)
      ],
    ),
  );
}

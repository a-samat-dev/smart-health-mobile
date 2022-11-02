import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/sign_in_screen.dart';
import 'package:mobile/screens/sign_up_screen.dart';
import 'package:mobile/state/LoginState.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(builder: (context, loginState, child) {
      bool isLoggedIn = loginState.isLoggedIn;

      if (loginState.isLoggedIn) {
        return Drawer(
            child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 40),
                      color: Colors.white,
                      height: 100,
                      child: ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.heartPulse,
                            color: Colors.red,
                            size: 40,
                          ),
                          title: Text(
                            'SmartHealth',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 26),
                          )),
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.home),
                          title: Text(
                            'Home',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text(
                            'Contacts',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Divider(
                          thickness: 3,
                        ),
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text(
                            'Sign Out',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    )
                  ],
                )));
      } else {
        return Drawer(
            child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 40),
                      color: Colors.white,
                      height: 100,
                      child: ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.heartPulse,
                            color: Colors.red,
                            size: 40,
                          ),
                          title: Text(
                            'SmartHealth',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 26),
                          )),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Column(
                      children: [
                        ListTile(
                          onTap: () => Navigator.pushReplacementNamed(
                              context, HomeScreen.routeName),
                          leading: Icon(Icons.home),
                          title: Text(
                            'Home',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text(
                            'Contacts',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, SignInScreen.routeName);
                          },
                          leading: Icon(Icons.login),
                          title: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          onTap: () => Navigator.pushNamed(
                              context, SignUpScreen.routeName),
                          leading: Icon(Icons.app_registration),
                          title: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  ],
                )));
      }
    });
  }
}

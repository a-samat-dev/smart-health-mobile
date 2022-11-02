import 'package:flutter/material.dart';
import 'package:mobile/state/LoginState.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/sign-in';

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(builder: (context, loginState, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Smart Health'),
        ),
        body: TextButton(
          onPressed: () {
            loginState.setIsLoggedIn(!loginState.isLoggedIn);
          },
          child: Text('Sign In Page'),
        ),
        drawer: MainDrawer(),
      );
    });
  }
}

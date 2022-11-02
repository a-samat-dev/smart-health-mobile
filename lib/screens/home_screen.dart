import 'package:flutter/cupertino.dart';
import 'package:mobile/screens/screen_skeleton.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return ScreenSkeleton(Column(
      children: [
        Image(image: const AssetImage('assets/images/home_screen.jpeg')),
        Expanded(
            child: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [],
          )),
        ))
      ],
    ));
  }
}

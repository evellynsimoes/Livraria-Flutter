import 'package:flutter/material.dart';

class Gotohome extends StatelessWidget {
  const Gotohome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,

          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/fundoGoToHome.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Color.fromRGBO(13, 68, 186, 0.7), 
                BlendMode.srcATop,
              ),
            ),
            
          ),
        ),
      ),
    );
  }
}
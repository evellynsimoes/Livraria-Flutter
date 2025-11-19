import 'package:flutter/material.dart';
import 'Home.dart';

class Gotohome extends StatelessWidget {
  const Gotohome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.80,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/fundoGoToHome.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Color.fromRGBO(13, 68, 186, 0.7),
                    BlendMode.srcATop,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(120),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Each page\nread is a\nnew\nhorizon\nconquered.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Home()),
                // );
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2F53D8),
                padding: EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "START",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

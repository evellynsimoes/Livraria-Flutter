import 'package:dreambound/goToHome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'goToHome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),

      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();

  String correctUser = "eve";
  String correctPass = "123";

  String message = "";

  void Login() {
    if (user.text == correctUser && password.text == correctPass) {
      setState(() => message = "");
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => Gotohome()),
      );
    } else {
      setState(() => message = "Existem credenciais incorretas");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D44BA), Color(0xFF993186)],
          ),
        ),

        //faz a tela ter rolagem se o conteúdo for maior que ela
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),

              Image.asset("images/logoBranca.png", height: 100),

              SizedBox(height: 15),

              Text(
                "DreamBound",
                style: GoogleFonts.averiaSerifLibre(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.normal,
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Login",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 40),

              TextField(
                controller: user,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Username",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 20),

              TextField(
                controller: password,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 50),

              SizedBox(
                width: 220,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    //cor do texto do botao
                    foregroundColor: Color(0xFF0D44BA),
                    //retangulo com borda arredondada
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () { Login(); },
                  child: Text(
                    "Login",
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                    ),
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

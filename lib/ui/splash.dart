import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'enterCode.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
   
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      
      getAccessToken().then((value) {
        print("ÈempID: $empID");
        Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => new CodePage()));
       
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          child: new Image.asset(
            "assets/logo.jpg",
            fit: BoxFit.fill,
          ),
        
        ),
      ),
    );
  }

  int empID;
  Future<void> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      empID = prefs.getInt("EmpID");
    });
  }
}

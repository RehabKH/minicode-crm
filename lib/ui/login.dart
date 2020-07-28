import 'package:flutter/material.dart';
import 'package:minicode_crm/api/loginApi.dart';
import 'package:minicode_crm/translation/localHelper.dart';
import 'package:minicode_crm/translation/localizations.dart';
import 'commonUI.dart';
import 'package:minicode_crm/ui/dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  CommonUI commonUIObj;
  TextEditingController nameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  LoginApi loginApiObj = new LoginApi();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  Animation animation, delayAnimation, muchDelayAnimation, mMuchDelayAnimation;
  bool isVisible = false;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 4), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    muchDelayAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));
    mMuchDelayAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    commonUIObj = new CommonUI(context);
    double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
        animation: animationController,
        builder: (context, Widget child) {
          return Scaffold(
              // appBar: AppBar(
              //   elevation: 0.0,
              //   title:Text("login page"),
              //   centerTitle: true,
              // ),
              body: Form(
            key: _key,
            child: Container(
                color: Colors.indigo[200],
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
// SizedBox(height:MediaQuery.of(context).size.height/3),
                    SizedBox(height: 30.0),
                    Transform(
                      transform: Matrix4.translationValues(
                          animation.value * width, 0.0, 0.0),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                helper.onLocaleChanged(new Locale("ar"));
                              },
                              child: Container(
                                  height: 40.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5)),
                                  ),
                                  child: Center(
                                    child: Text("عربي"),
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                helper.onLocaleChanged(new Locale("en"));
                              },
                              child: Container(
                                  height: 40.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5)),
                                  ),
                                  child: Center(
                                    child: Text("ُEnglish",
                                        style: TextStyle(color: Colors.white)),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 100.0),
                    Transform(
                      transform: Matrix4.translationValues(
                          delayAnimation.value * width, 0.0, 0.0),
                      child: Center(
                          child: Text(AppLocalizations.of(context).signIn,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0))),
                    ),
                    SizedBox(height: 60.0),

                    Transform(
                      transform: Matrix4.translationValues(
                          delayAnimation.value * width, 0.0, 0.0),
                      child: commonUIObj.buildTextField(
                          AppLocalizations.of(context).Name,
                          nameController,
                          TextInputType.emailAddress,
                          context,
                          errorMsg: nameErrorMsg),
                    ),
                    SizedBox(height: 10.0),
                    Transform(
                      transform: Matrix4.translationValues(
                          delayAnimation.value * width, 0.0, 0.0),
                      child: commonUIObj.buildTextField(
                          AppLocalizations.of(context).pass,
                          passController,
                          TextInputType.text,
                          context,
                          errorMsg: passErrorMsg),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Transform(
                        transform: Matrix4.translationValues(
                            mMuchDelayAnimation.value * width, 0.0, 0.0),
                        child: InkWell(
                          onTap: () {
                            final formState = _key.currentState;
                            if (formState.validate()) {
                              loginApiObj
                                  .login(
                                      nameController.text, passController.text)
                                  .then((val) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new Home()));
                              });
                            }
                          },
                          child: Container(
                            height: 40.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              AppLocalizations.of(context).signIn,
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Center(
                    //     child: InkWell(
                    //         onTap: () {
                    //              Navigator.of(context).push(MaterialPageRoute(
                    //               builder: (BuildContext context) =>
                    //                   new RegisterPage()));
                    //         },
                    //         child: Text(AppLocalizations.of(context).notHasAcc,
                    //             style: TextStyle(fontSize: 17.0
                    //             ,color:Colors.white,decoration: TextDecoration.underline
                    //             ))))
                  ],
                )),
          ));
        });
  }

  String nameErrorMsg(String val) {
    if (val.isEmpty) {
      return "please enter your name";
    }
    return null;
  }

  String passErrorMsg(String val) {
    if (val.isEmpty) {
      return "please enter password";
    }
    return null;
  }
}

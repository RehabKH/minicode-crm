import 'package:flutter/material.dart';
import 'package:minicode_crm/api/loginApi.dart';
import 'package:minicode_crm/translation/localHelper.dart';
import 'package:minicode_crm/translation/localizations.dart';
//import 'package:minicode_crm/ui/animationbtn/Component21.dart';/
import 'package:minicode_crm/ui/commonUI.dart';
import 'package:toast/toast.dart';

import 'login.dart';

class CodePage extends StatefulWidget {
  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage>
    with SingleTickerProviderStateMixin {
  LoginApi confirmCodeObj = new LoginApi();
  CommonUI commonUIObj;
  Animation animation, delayAnimation, muchDelayAnimation;

  AnimationController animationController;
  TextEditingController codeController = new TextEditingController();
  bool loading = false;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    muchDelayAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
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
                      muchDelayAnimation.value * width, 0.0, 0.0),
                  child: commonUIObj.buildTextField(
                      AppLocalizations.of(context).enterCode, codeController, TextInputType.text, context,
                      errorMsg: onTextEditingCompleteFunc),
                ),
                SizedBox(height: 10.0),

                Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Transform(
                    transform: Matrix4.translationValues(
                        muchDelayAnimation.value * width, 0.0, 0.0),
                    child: InkWell(
                      onTap: () {
                        final formState = _key.currentState;
                        if (formState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          confirmCodeObj
                              .confirmCode(codeController.text)
                              .then((val) {
                            // Toast.show(val, context,
                            //     duration: Toast.LENGTH_LONG,
                            //     gravity: Toast.CENTER);
                            setState(() {
                              loading = false;
                            });
                            if (val == "Done") {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new LoginPage()));
                            }
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
                            child: (loading)
                                ? CircularProgressIndicator()
                                : Text(
                                    AppLocalizations.of(context).submit,
                                    style: TextStyle(color: Colors.white),
                                  )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ));
      },
    );
  }

  String onTextEditingCompleteFunc(String val) {
    if (val != "MiniCode") {
      return "code you entered not correct";
    } else if (val.isEmpty) {
      return "please enter code";
    } else {
      return null;
    }
  }
}

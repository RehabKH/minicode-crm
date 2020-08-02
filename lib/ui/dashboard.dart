import 'dart:io';
import 'package:flutter/material.dart';
import 'package:minicode_crm/api/dashBoardApi.dart';
import 'package:minicode_crm/translation/localizations.dart';
import 'package:minicode_crm/ui/addLead.dart';
import 'package:minicode_crm/ui/enterCode.dart';
import 'package:minicode_crm/ui/leadDetails.dart';
import 'package:minicode_crm/ui/leadsPage.dart';
import 'package:minicode_crm/ui/searchPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/custompopup.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int notificationCount;
  DashBoardApi dbApi = new DashBoardApi();
  bool loading = true;
  Animation animation, delayAnimation, muchDelayAnimation, mMuchDelayAnimation;
  var notificationResult;
  AnimationController animationController;
  List<CustomPopupMenu> notificationList = new List<CustomPopupMenu>();

  @override
  void initState() {
    super.initState();
    dbApi.getDashboardStages().then((val) {
      getUserData().then((val) {
        print("emp id: $empID");
        dbApi.getNotificationList(empID.toString()).then((val2) {
          dbApi.getNotificationCount(empID.toString()).then((val3) {
            setState(() {
              loading = false;
              notificationResult = val2;
              notificationCount = val3;
            });
            for (int i = 0; i < notificationResult.length; i++) {
              setState(() {
                notificationList.add(
                  CustomPopupMenu(
                      clientName: notificationResult[i]["ClientName"],
                      clientID: notificationResult[i]["ClientID"].toString(),
                      clientPhone: notificationResult[i]["ClientMobile"],
                      creationDate:
                          DateTime.parse(notificationResult[i]["CreationDate"]),
                      projectName: notificationResult[i]["ProjectName"],
                      stageID: notificationResult[i]["StageID"].toString(),
                      stageName:
                          (Localizations.localeOf(context).languageCode == "en")
                              ? notificationResult[i]["StageName"]
                              : notificationResult[i]["StageNameAr"],
                      lastComment: notificationResult[i]["LastComment"]),
                );
              });
            }
          });
        });
      });
    });

    animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    muchDelayAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(-0.8, 1.0, curve: Curves.fastOutSlowIn)));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: AnimatedBuilder(
          animation: animationController,
          builder: (context, Widget child) {
            return Scaffold(
                body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/bg.png"),
                          fit: BoxFit.cover),
                    ),
                    child: (loading || dbApi.allDashboardStages.length < 0)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              )
                            ],
                          )
                        : ListView(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    height: 55.0,
                                    child: PopupMenuButton(
                                      icon: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.topRight,
                                                height: 15.0,
                                                width: 15.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Text(
                                                    notificationCount
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10.0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.notifications_active,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                      elevation: 3.2,
                                      onCanceled: () {
                                        print('You have not chossed anything');
                                      },
                                      tooltip: 'recent notification',
                                      itemBuilder: (BuildContext context) {
                                        return notificationList
                                            .map((CustomPopupMenu choice) {
                                          return PopupMenuItem(
                                            value: choice,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            new LeadDetails(
                                                              name: choice
                                                                  .clientName,
                                                              mobile: choice
                                                                  .clientPhone,
                                                              projectName: choice
                                                                  .clientPhone,
                                                              stageName: choice
                                                                  .stageName,
                                                              creationDate: choice
                                                                  .creationDate,
                                                              stageID: choice
                                                                  .stageID,
                                                              clientID: choice
                                                                  .clientID,
                                                            )));
                                              },
                                              child: ListTile(
                                                title: Text(choice.clientName,
                                                    style: TextStyle(
                                                        color: Colors.indigo)),
                                                subtitle: Text(
                                                  (choice.lastComment == null)
                                                      ? ""
                                                      : choice.lastComment +
                                                          ", " +
                                                          choice.creationDate
                                                              .toString()
                                                              .substring(0, 10),
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          4),
                                  Text(
                                    AppLocalizations.of(context).welcome +
                                        " " +
                                        userName,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 120.0, right: 120.0),
                                child: Transform(
                                  transform: Matrix4.translationValues(
                                      animation.value * width, 0.0, 0.0),
                                  child: InkWell(
                                    onTap: () {
                                      logout();
                                    },
                                    child: Container(
                                        height: 30.0,
                                        width: 80.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: Center(
                                            child: Text(
                                                AppLocalizations.of(context)
                                                    .logout,
                                                style: TextStyle(
                                                    color: Colors.indigo)))),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Transform(
                                  transform: Matrix4.translationValues(
                                      muchDelayAnimation.value * width,
                                      0.0,
                                      0.0),
                                  child: _buildGridView()),
                              SizedBox(height: 10.0),
                            ],
                          )),
                floatingActionButton:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  FloatingActionButton.extended(
                    heroTag: "btn1",
                    elevation: 0.2,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => new SearchPage()));
                    },
                    label: Text(AppLocalizations.of(context).search),
                    backgroundColor: Colors.indigo[100],
                  ),
                  SizedBox(width: 10.0),
                  FloatingActionButton.extended(
                    heroTag: "btn2",
                    elevation: 0.2,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => new AddLead()));
                    },
                    label: Text(AppLocalizations.of(context).addLead),
                    backgroundColor: Colors.indigo[100],
                  ),
                ]));
          }),
    );
  }

  Widget _buildGridView() {
    return Container(
      height: MediaQuery.of(context).size.height / 2 + 200.0,
      child: GridView.builder(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => new LeadsPage(
                        stageID: dbApi.allDashboardStages[index]["StageID"],
                      )));
            },
            child: Material(
              elevation: 0.5,
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // SizedBox(height:20.0),
                          Text(
                            (Localizations.localeOf(context).languageCode ==
                                    "en")
                                ? (dbApi.allDashboardStages[index]
                                            ["StageName"] !=
                                        null)
                                    ? dbApi.allDashboardStages[index]
                                        ["StageName"]
                                    : ""
                                : (dbApi.allDashboardStages[index]
                                            ["StageNameAr"] !=
                                        null)
                                    ? dbApi.allDashboardStages[index]
                                        ["StageNameAr"]
                                    : "",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 20.0),

                          Container(
                              height: 20.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                  child: Text(
                                      (dbApi.allDashboardStages[index]
                                                  ["ClientsCount"] !=
                                              null)
                                          ? dbApi.allDashboardStages[index]
                                                  ["ClientsCount"]
                                              .toString()
                                          : "",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )))),
                        ],
                      ),
                    ),
                  )),
            ),
          );
        },
        itemCount: dbApi.allDashboardStages.length,
        padding: const EdgeInsets.only(left: 20, right: 20.0),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 6.0,
          childAspectRatio: 1.3,
          mainAxisSpacing: 7.0,
        ),
      ),
    );
  }

  String userName = "";
  int empID;
  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString("UserName");
      empID = prefs.getInt("EmpID");
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => new CodePage()));
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text((Localizations.localeOf(context).languageCode == "en")
              ? 'Rewind and remember'
              : "تنبيهات وتذكر"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text((Localizations.localeOf(context).languageCode == "en")
                    ? 'Are you sure'
                    : "هل انت متأكد"),
                Text((Localizations.localeOf(context).languageCode == "en")
                    ? 'you want to exit'
                    : "انك تريد الحروج من التطبيق"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text((Localizations.localeOf(context).languageCode == "en")
                  ? 'Cancel'
                  : "إلغاء"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text((Localizations.localeOf(context).languageCode == "en")
                  ? "exit"
                  : "خروج"),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }
}

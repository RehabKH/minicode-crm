import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flexible/flexible.dart';
import 'package:minicode_crm/api/dashBoardApi.dart';
import 'package:minicode_crm/translation/localizations.dart';
import 'package:minicode_crm/ui/commonUI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class AddAction extends StatefulWidget {
  final String type;
  final String stageID;
  final String clientID;
  final String name;
  final String mobile;
  final String projectName;
  final String creationDate;
  final String stageName;

  final String channelName;
  final String lastComment;

  AddAction(
      {this.type,
      this.clientID,
      this.stageID,
      this.name,
      this.mobile,
      this.projectName,
      this.stageName,
      this.creationDate,
      this.channelName,
      this.lastComment});
  @override
  _AddActionState createState() => _AddActionState();
}

class _AddActionState extends State<AddAction> {
  DateTime nextActionDate;
  DateTime actionDate;
  bool nextActionDateVisible = false;
  TextEditingController commentController = new TextEditingController();
  TextEditingController stageController = new TextEditingController();
  DashBoardApi dashBoardApi = new DashBoardApi();
  CommonUI commonUIObj;
  bool isLoading = true;
  TextEditingController actionComment = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashBoardApi.getAllStages().then((val) {
      setState(() {
        isLoading = false;
      });
    });
    setState(() {
      actionComment.text = widget.lastComment;
    });
  }

  @override
  Widget build(BuildContext context) {
    commonUIObj = new CommonUI(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(
        AppLocalizations.of(context).addAction,
        style: TextStyle(color: Colors.white),
      )),
      body: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.indigo, width: 2)),
          child: (isLoading)
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                          backgroundColor: Colors.indigoAccent)
                    ],
                  ),
                )
              : ListView(
                  children: <Widget>[
                    SizedBox(height: 50.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                      child: Text(
                        (Localizations.localeOf(context).languageCode == "en")
                            ? "Lead Description"
                            : "وصف العميل",
                        style: TextStyle(color: Colors.indigo, fontSize: 15.0),
                      ),
                    ),
                    ScreenFlexibleWidget(
                        // 1. Wrap with `ScreenFlexibleWidget`

                        child: Builder(builder: (BuildContext context) {
                      return Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 50.0, right: 50.0),
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.indigo,
                              primaryColorDark: Colors.indigo,
                            ),
                            child: TextField(
                              controller: actionComment,
                              style: TextStyle(color: Colors.indigo[300]),
                              textDirection: (Localizations.localeOf(context)
                                          .languageCode ==
                                      "ar")
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              keyboardType: TextInputType.text,
                              maxLines: null,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.indigo[50],
                                  contentPadding: EdgeInsets.all(5.0),
                                  border: new OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  hintText:
                                      AppLocalizations.of(context).actionDesc,
                                  hintStyle:
                                      TextStyle(color: Colors.indigo[300])),
                            ),
                          ),
                        ),
                      );
                    })),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                      child: Text(
                        (Localizations.localeOf(context).languageCode == "en")
                            ? "Lead Stage"
                            : "مرحلة العميل",
                        style: TextStyle(color: Colors.indigo, fontSize: 15.0),
                      ),
                    ),
                    (Localizations.localeOf(context).languageCode == "en")
                        ? commonUIObj.dropDownUI(dashBoardApi.currentStage,
                            dashBoardApi.stageList, onChangeStage)
                        : commonUIObj.dropDownUI(dashBoardApi.currentStageAr,
                            dashBoardApi.stageListAr, onChangeStage),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 50.0),
                          Text(
                              (Localizations.localeOf(context).languageCode ==
                                      "en")
                                  ? "Action Date"
                                  : "تاريخ اللإجراء",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo)),
                          Spacer(
                            flex: 2,
                          ),

                          // Flexible(child: SizedBox(width: 20.0)),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: FlatButton(
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2000, 3, 5),
                                      maxTime: DateTime(2020, 6, 7),
                                      onChanged: (date) {
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    print('confirm $date');
                                    setState(() {
                                      actionDate = date;
                                    });
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.ar);
                                },
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 90.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.indigo, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          (actionDate.toString() == null ||
                                                  actionDate.toString() ==
                                                      "null")
                                              ? ""
                                              : actionDate
                                                  .toString()
                                                  .substring(0, 10),
                                          style:
                                              TextStyle(color: Colors.indigo),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Icon(Icons.edit, color: Colors.indigo)
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    (nextActionDateVisible &&
                            dashBoardApi.currentStage != "select" &&
                            dashBoardApi.currentStage != "اختر")
                        ? Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 50.0),
                                Text(
                                    AppLocalizations.of(context).nextActionDate,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo)),
                            
                                Spacer(
                                  flex: 1,
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: FlatButton(
                                      onPressed: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(2000, 3, 5),
                                            maxTime: DateTime(2020, 6, 7),
                                            onChanged: (date) {
                                          print('change $date');
                                        }, onConfirm: (date) {
                                          print('confirm $date');
                                          setState(() {
                                            nextActionDate = date;
                                          });
                                        },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.ar);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 90.0,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.indigo,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(2)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                (nextActionDate.toString() ==
                                                            null ||
                                                        nextActionDate
                                                                .toString() ==
                                                            "null")
                                                    ? ""
                                                    : nextActionDate
                                                        .toString()
                                                        .substring(0, 10),
                                                style: TextStyle(
                                                    color: Colors.indigo),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10.0),
                                          Icon(Icons.edit, color: Colors.indigo)
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 50.0, right: 50.0),
                      child: InkWell(
                        onTap: () {
                          if (dashBoardApi.currentStage == "select" ||
                              dashBoardApi.currentStageAr == "اختر") {
                            Toast.show("stage should't be empty", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.CENTER,
                                backgroundColor: Colors.indigo);
                          } else if (actionComment.text.isEmpty) {
                            Toast.show("please write description", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.CENTER,
                                backgroundColor: Colors.indigo);
                          } else if (actionDate == null ||
                              nextActionDate == null) {
                            Toast.show("please write date", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.CENTER,
                                backgroundColor: Colors.indigo);
                          } else {
                            getUserData().then((val) {
                              dashBoardApi
                                  .addAction(
                                      actionDate.toString(),
                                      widget.clientID,
                                      actionComment.text,
                                      empID.toString(),
                                      dashBoardApi.currentStageID.toString(),
                                      nextActionDate.toString())
                                  .then((val) {
                                if (val == "success") {
                                  Toast.show(
                                      'action added successfully', context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.CENTER);
                                  setState(() {
                                    actionComment.text = "";
                                    nextActionDate = null;
                                    actionDate = null;
                                  });
                                }
                              });
                            });
                          }
                          },
                        child: Container(
                          height: 40.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            AppLocalizations.of(context).submit,
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ],
                )),
    );
  }

  int empID;
  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      empID = prefs.getInt("EmpID");
    });
  }

  void onChangeStage(String value) {
    print(value);
    setState(() {
      dashBoardApi.currentStage = value;
      dashBoardApi.currentStageAr = value;
    });
    for (int i = 0; i < dashBoardApi.allStages.length; i++) {
      if (value == dashBoardApi.allStages[i]["StageName"] ||
          value == dashBoardApi.allStages[i]["StageNameAr"]) {
        setState(() {
          dashBoardApi.currentStageID = dashBoardApi.allStages[i]["StageID"];

          nextActionDateVisible =
              dashBoardApi.allStages[i]["ShowNextActionDate"];
        });
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flexible/flexible.dart';
import 'package:minicode_crm/api/dashBoardApi.dart';
import 'package:minicode_crm/translation/localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'commonUI.dart';

class AddLead extends StatefulWidget {
  @override
  _AddLeadState createState() => _AddLeadState();
}

class _AddLeadState extends State<AddLead> {
  CommonUI commonUIObj;
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  TextEditingController leadName = new TextEditingController();
  TextEditingController leadPhone = new TextEditingController();
  TextEditingController leadEmail = new TextEditingController();
  TextEditingController leadNote = new TextEditingController();
  DashBoardApi dbApi = new DashBoardApi();
  bool loadingAdd = false;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    dbApi.getAllProjects().then((val) {
      dbApi.getAllStages().then((val) {
        dbApi.getAllChannels().then((val) {
          setState(() {
            loading = false;
          });
          print(dbApi.channelList.toString() + "," + dbApi.currentChannel);
        });
      });
    });
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    commonUIObj = new CommonUI(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).addLead),
        centerTitle: true,
      ),
      body: Form(
        key: _key,
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.indigoAccent[100],
            child: (loading)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                          backgroundColor: Colors.indigoAccent)
                    ],
                  )
                : ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 60.0, right: 60.0, bottom: 10.0),
                        child: Text(
                          AppLocalizations.of(context).Name,
                          style:
                              TextStyle(color: Colors.indigo, fontSize: 15.0),
                        ),
                      ),
                      commonUIObj.buildTextField(
                          AppLocalizations.of(context).Name,
                          leadName,
                          TextInputType.text,
                          context,
                          errorMsg: errorName),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 60.0, right: 60.0, bottom: 10.0),
                        child: Text(
                          AppLocalizations.of(context).phone,
                          style:
                              TextStyle(color: Colors.indigo, fontSize: 15.0),
                        ),
                      ),
                      commonUIObj.buildTextField(
                          AppLocalizations.of(context).phone,
                          leadPhone,
                          TextInputType.phone,
                          context,
                          errorMsg: errorPhone),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 60.0, right: 60.0, bottom: 10.0),
                        child: Text(
                          AppLocalizations.of(context).email,
                          style:
                              TextStyle(color: Colors.indigo, fontSize: 15.0),
                        ),
                      ),
                      commonUIObj.buildTextField(
                        AppLocalizations.of(context).email,
                        leadEmail,
                        TextInputType.emailAddress,
                        context,
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 60.0, right: 60.0, bottom: 10.0),
                        child: Text(
                          AppLocalizations.of(context).writeComment,
                          style:
                              TextStyle(color: Colors.indigo, fontSize: 15.0),
                        ),
                      ),
                      ScreenFlexibleWidget(
                          // 1. Wrap with `ScreenFlexibleWidget`

                          child: Builder(builder: (BuildContext context) {
                        return Container(
                           child: Padding(
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: TextField(
                              controller: leadNote,
                              onChanged: (val) {
                              },
                              maxLines: null,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.indigo[50].withOpacity(0.8),
                                  contentPadding: EdgeInsets.all(5.0),
                                  hintText:
                                      AppLocalizations.of(context).writeComment,
                                  hintStyle:
                                      TextStyle(color: Colors.indigo[300]),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  )),
                            ),
                          ),
                        );
                      })),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 60.0, right: 60.0, bottom: 10.0),
                        child: Text(
                          (Localizations.localeOf(context).languageCode == "en")
                              ? "select project name"
                              : "اختر اسم المشروع",
                          style:
                              TextStyle(color: Colors.indigo, fontSize: 15.0),
                        ),
                      ),
                      (Localizations.localeOf(context).languageCode == "en")?
                      commonUIObj.dropDownUI(dbApi.currentProject,
                          dbApi.projectList, onChangeProject):
                          commonUIObj.dropDownUI(dbApi.currentProjectAr,
                          dbApi.projectListAr, onChangeProject),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 60.0, right: 60.0, bottom: 10.0),
                        child: Text(
                          (Localizations.localeOf(context).languageCode == "en")
                              ? "select stage of lead"
                              : "اختر موقف العميل",
                          style:
                              TextStyle(color: Colors.indigo, fontSize: 15.0),
                        ),
                      ),
                      (Localizations.localeOf(context).languageCode == "en")
                          ? commonUIObj.dropDownUI(dbApi.currentStage,
                              dbApi.stageList, onChangeStage)
                          : commonUIObj.dropDownUI(dbApi.currentStageAr,
                              dbApi.stageListAr, onChangeStage),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 60.0, right: 60.0, bottom: 10.0),
                        child: Text(
                          (Localizations.localeOf(context).languageCode == "en")
                              ? "select channel name"
                              : "طريقة التعارف",
                          style:
                              TextStyle(color: Colors.indigo, fontSize: 15.0),
                        ),
                      ),
                      (Localizations.localeOf(context).languageCode == "en")
                          ? commonUIObj.dropDownUI(dbApi.currentChannel,
                              dbApi.channelList, onChangeChannel)
                          : commonUIObj.dropDownUI(dbApi.currentChannelAr,
                              dbApi.channelListAr, onChangeChannel),

                      SizedBox(height: 30.0),
                      InkWell(
                        onTap: () {
                          final formState = _key.currentState;
                          if (dbApi.currentChannel == "select" ||
                              dbApi.currentChannelAr == "اختر") {
                            Toast.show("channel should't be empty", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.CENTER);
                            if (dbApi.currentProject == "select") {
                              Toast.show("project should't be empty", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.CENTER);
                            }
                            if (dbApi.currentStage == "select" ||
                                dbApi.currentStageAr == "اختر") {
                              Toast.show("stage should't be empty", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.CENTER);
                            }
                          }
                          if (formState.validate() &&
                              (dbApi.currentChannel != "select" ||
                                  dbApi.currentChannelAr != "اختر") &&
                              (dbApi.currentProject != "select") &&
                              (dbApi.currentStage != "select" ||
                                  dbApi.currentStageAr != "اختر")) {
                            setState(() {
                              loadingAdd = true;
                            });
                            dbApi
                                .addLead(
                                    dbApi.currentProjectID,
                                    DateTime.now(),
                                    dbApi.currentStageID,
                                    dbApi.currentChannelID,
                                    leadNote.text,
                                    empID,
                                    leadPhone.text,
                                    leadName.text)
                                .then((val) {
                              setState(() {
                                loadingAdd = false;
                              });
                              if (val == "success") {
                                Toast.show('lead added successfully', context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.CENTER);
                                setState(() {
                                  leadName.text = "";
                                  leadPhone.text = "";
                                  leadEmail.text = "";

                                  leadNote.text = "";
                                });
                              }
                            });
                          }
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 50.0, right: 50.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width - 100.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Center(
                                  child: (loadingAdd)
                                      ? CircularProgressIndicator()
                                      : Text(
                                          AppLocalizations.of(context).submit,
                                          style:
                                              TextStyle(color: Colors.white)))),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      )
                    ],
                  )),
      ),
    );
  }
 void onChangeProject(String value) {
    print(value);
    setState(() {
      dbApi.currentProject = value;
      dbApi.currentProjectAr = value;
    });
    for (int i = 0; i < dbApi.allProjects.length; i++) {
      if (value == dbApi.allProjects[i]["ProjectName"]) {
        setState(() {
          dbApi.currentProjectID = dbApi.allProjects[i]["ProjectID"];
        });
      }
    }
    print(
        "selected project id:  ::::::::::" + dbApi.currentProjectID.toString());
  }

  void onChangeStage(String value) {
    print(value);
    setState(() {
      dbApi.currentStage = value;
      dbApi.currentStageAr = value;
    });
    for (int i = 0; i < dbApi.allStages.length; i++) {
      if (value == dbApi.allStages[i]["StageName"] ||
          value == dbApi.allStages[i]["StageNameAr"]) {
        setState(() {
          dbApi.currentStageID = dbApi.allStages[i]["StageID"];
        });
      }
    }
  }

  void onChangeChannel(String value) {
    print(value);
    setState(() {
      dbApi.currentChannel = value;
      dbApi.currentChannelAr = value;
    });
     for (int i = 0; i < dbApi.allChannel.length; i++) {
      if (value == dbApi.allChannel[i]["ChannelName"] ||
          value == dbApi.allChannel[i]["ChannelNameAr"]) {
        setState(() {
          dbApi.currentChannelID = dbApi.allChannel[i]["ChannelID"];
        });
      }
    }
  }

  int empID;
  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      empID = prefs.getInt("EmpID");
    });
  }

  String errorPhone(String phone) {
    if (phone.length != 11) {
      return "phone length not correct";
    } else if (!phone.startsWith("010") &&
        !phone.startsWith("011") &&
        !phone.startsWith("0155") &&
        !phone.startsWith("012")) {
      return "invalid phone format";
    }
    return null;
  }

  String errorName(String name) {
    if (name.length < 6) {
      return "name length can't be less than 6 digit";
    }
    return null;
   }
}

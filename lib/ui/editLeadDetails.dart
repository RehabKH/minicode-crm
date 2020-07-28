import 'package:flutter/material.dart';
import 'package:minicode_crm/api/dashBoardApi.dart';
import 'package:minicode_crm/models/leadDetails.dart';
import 'package:minicode_crm/translation/localizations.dart';
import 'package:minicode_crm/ui/commonUI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flexible/flexible.dart';

class EditLeadDetails extends StatefulWidget {
  final LeadModel leadModelList;
  EditLeadDetails(this.leadModelList);
  @override
  _EditLeadDetailsState createState() => _EditLeadDetailsState();
}

class _EditLeadDetailsState extends State<EditLeadDetails> {
  DateTime creationDate;
  DateTime nextActionDate;
  DashBoardApi dashBoardApi = new DashBoardApi();
  CommonUI commonUIObj;
  bool isLoading = true;
  TextEditingController leadName = new TextEditingController();
  TextEditingController leadMobile = new TextEditingController();
  TextEditingController leadDesc = new TextEditingController();

  bool loadingEdit = false;

  DateTime actionDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashBoardApi.getAllProjects().then((val) {
      dashBoardApi.getAllStages().then((val) {
        dashBoardApi.getAllChannels().then((val) {
          setState(() {
            isLoading = false;
            leadName.text = widget.leadModelList.clientName;
            leadMobile.text = widget.leadModelList.clientMobile;
            leadDesc.text = widget.leadModelList.lastComment;
            creationDate = widget.leadModelList.creationDate;
            nextActionDate = widget.leadModelList.nextActionDate;
          });
          print(dashBoardApi.channelList.toString() +
              "," +
              dashBoardApi.currentChannel);
        });
      });
    });
    getUserData();
  }

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    commonUIObj = new CommonUI(context);

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            (Localizations.localeOf(context).languageCode == "en")
                ? "Edit Lead Info"
                : "تعديل بيانات العميل",
            style: TextStyle(color: Colors.white),
          )),
      body: Form(
        key: _key,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo, width: 2)),
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
                      SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0, right: 60.0),
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
                          context),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                        child: Text(
                          AppLocalizations.of(context).phone,
                          style:
                              TextStyle(color: Colors.indigo, fontSize: 15.0),
                        ),
                      ),
                      commonUIObj.buildTextField(
                          AppLocalizations.of(context).phone,
                          leadMobile,
                          TextInputType.phone,
                          context),
                      SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                        child: Text(
                          AppLocalizations.of(context).leadComment,
                          style:
                              TextStyle(color: Colors.indigo, fontSize: 15.0),
                        ),
                      ),
                      ScreenFlexibleWidget(
                          // 1. Wrap with `ScreenFlexibleWidget`

                          child: Builder(builder: (BuildContext context) {
                        return Container(
                          // child :  commonUIObj.buildTextField("Lead Note", leadNote,TextInputType.text, context),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Theme(
                              data: new ThemeData(
                                primaryColor: Colors.indigo,
                                primaryColorDark: Colors.indigo,
                              ),
                              child: TextField(
                                controller: leadDesc,
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
                      SizedBox(height: 20.0),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
                      //   child: commonUIObj.buildTextField(
                      //       AppLocalizations.of(context).phone,
                      //       stageController,
                      //       TextInputType.phone,
                      //       context),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                        child: Text(
                          (Localizations.localeOf(context).languageCode == "en")
                              ? "select project name"
                              : "اختر اسم المشروع",
                          style:
                              TextStyle(color: Colors.indigo, fontSize: 15.0),
                        ),
                      ),
                      (Localizations.localeOf(context).languageCode == "en")
                          ? commonUIObj.dropDownUI(dashBoardApi.currentProject,
                              dashBoardApi.projectList, onChangeProject)
                          : commonUIObj.dropDownUI(
                              dashBoardApi.currentProjectAr,
                              dashBoardApi.projectListAr,
                              onChangeProject),
                      //  commonUIObj.buildTextField("project", leadPhone,TextInputType.phone, context),

                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                        child: Text(
                          (Localizations.localeOf(context).languageCode == "en")
                              ? "select channel name"
                              : "طريقة التعارف",
                          style:
                              TextStyle(color: Colors.indigo, fontSize: 15.0),
                        ),
                      ),
                      (Localizations.localeOf(context).languageCode == "en")
                          ? commonUIObj.dropDownUI(dashBoardApi.currentChannel,
                              dashBoardApi.channelList, onChangeChannel)
                          : commonUIObj.dropDownUI(
                              dashBoardApi.currentChannelAr,
                              dashBoardApi.channelListAr,
                              onChangeChannel),

                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                        child: Text(
                          (Localizations.localeOf(context).languageCode == "en")
                              ? "select stage of lead"
                              : "اختر موقف العميل",
                          style:
                              TextStyle(color: Colors.indigo, fontSize: 15.0),
                        ),
                      ),
                      (Localizations.localeOf(context).languageCode == "en")
                          ? commonUIObj.dropDownUI(dashBoardApi.currentStage,
                              dashBoardApi.stageList, onChangeStage)
                          : commonUIObj.dropDownUI(dashBoardApi.currentStageAr,
                              dashBoardApi.stageListAr, onChangeStage),
                      SizedBox(
                        height: 20.0,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(width: 50.0),
                            Text(AppLocalizations.of(context).creationDate,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo)),
                            Flexible(child: SizedBox(width: 20.0)),
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
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.indigo,
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            (widget.leadModelList
                                                        .creationDate ==
                                                    null )
                                                ? ( actionDate == null)?""
                                                : (actionDate.toString().substring(0,10)):widget
                                                    .leadModelList.creationDate
                                                    .toString(),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 50.0, right: 50.0),
                        child: InkWell(
                          onTap: () {
                            final formState = _key.currentState;
                            if (dashBoardApi.currentStage == "select" ||
                                dashBoardApi.currentStageAr == "اختر") {
                              Toast.show("stage should't be empty", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.CENTER);
                            }
                            if (actionDate == null) {
                              Toast.show(
                                  "creation date should't be empty", context,duration: Toast.LENGTH_LONG,
                                  gravity: Toast.CENTER,backgroundColor: Colors.indigo);
                            }
                            if (formState.validate() &&
                                (dashBoardApi.currentChannel != "select" ||
                                    dashBoardApi.currentChannelAr != "اختر") &&
                                (dashBoardApi.currentProject != "select") &&
                                (dashBoardApi.currentStage != "select" ||
                                    dashBoardApi.currentStageAr != "اختر") &&
                                actionDate != null) {
                              setState(() {
                                loadingEdit = true;
                              });
                              dashBoardApi
                                  .editLead(
                                      dashBoardApi.currentProjectID,
                                      actionDate,
                                      dashBoardApi.currentStageID,
                                      dashBoardApi.currentChannelID,
                                      leadDesc.text,
                                      empID,
                                      leadMobile.text,
                                      leadName.text)
                                  .then((val) {
                                setState(() {
                                  loadingEdit = false;
                                });
                                if (val == "success") {
                                  Toast.show('lead added successfully', context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.CENTER);
                                  setState(() {
                                    leadName.text = "";
                                    leadMobile.text = "";
                                    // lead.text = "";

                                    leadDesc.text = "";
                                  });
                                }
                              });
                            }

                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (BuildContext context) =>
                            //         new Home()));
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
                      SizedBox(height: 20.0)
                    ],
                  )),
      ),
    );
  }

  void onChangeProject(String value) {
    print(value);
    setState(() {
      dashBoardApi.currentProject = value;
      dashBoardApi.currentProjectAr = value;
    });
    for (int i = 0; i < dashBoardApi.allProjects.length; i++) {
      if (value == dashBoardApi.allProjects[i]["ProjectName"]) {
        setState(() {
          dashBoardApi.currentProjectID =
              dashBoardApi.allProjects[i]["ProjectID"];
        });
      }
    }
    print("selected project id:  ::::::::::" +
        dashBoardApi.currentProjectID.toString());
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
        });
      }
    }
  }

  void onChangeChannel(String value) {
    print(value);
    setState(() {
      dashBoardApi.currentChannel = value;
      dashBoardApi.currentChannelAr = value;
    });
    // if(Localizations.localeOf(context).languageCode == "en"){

    // }
    for (int i = 0; i < dashBoardApi.allChannel.length; i++) {
      if (value == dashBoardApi.allChannel[i]["ChannelName"] ||
          value == dashBoardApi.allChannel[i]["ChannelNameAr"]) {
        setState(() {
          dashBoardApi.currentChannelID =
              dashBoardApi.allChannel[i]["ChannelID"];
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
    // else if(name.startsWith())
  }
}

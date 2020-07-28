import 'package:flutter/material.dart';
import 'package:minicode_crm/api/dashBoardApi.dart';
import 'package:minicode_crm/translation/localizations.dart';
import 'package:minicode_crm/ui/commonUI.dart';
// import 'package:minicode_crm/ui/const.dart';
import 'package:minicode_crm/translation/localizations.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  CommonUI commonUIObj;
  String searchResult = "";
  TextEditingController leadNameController = new TextEditingController();
  TextEditingController leadPhoneController = new TextEditingController();
  // Const constObj = new Const();
// String selectedStage = "";
  DashBoardApi getDropDown = new DashBoardApi();
  var projectResult, stageResult;
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDropDown.getAllProjects().then((val1) {
      getDropDown.getAllStages().then((val2) {
        setState(() {
          loading = false;
          projectResult = val1;
          stageResult = val2;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    commonUIObj = new CommonUI(context);

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context).search,
              style: TextStyle(color: Colors.white))),
      body: Container(
          color: Colors.blueGrey[100],
          child: (loading)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    )
                  ],
                )
              : (searchResult.isNotEmpty)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Text(
                            searchResult,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black38,
                            ),
                          ),
                        )
                      ],
                    )
                  : ListView(
                      children: <Widget>[
                        SizedBox(height: 50.0),
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
                            leadNameController,
                            TextInputType.text,
                            context),

                        SizedBox(height: 10.0),
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
                            leadPhoneController,
                            TextInputType.phone,
                            context),
                        SizedBox(height: 10.0),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 60.0, right: 60.0,bottom: 10.0),
                          child: Text(
                            (Localizations.localeOf(context).languageCode ==
                                    "en")
                                ? "project"
                                : "المشروع",
                            style:
                                TextStyle(color: Colors.indigo, fontSize: 15.0),
                          ),
                        ),
                        (Localizations.localeOf(context).languageCode == "en")
                            ? commonUIObj.dropDownUI(getDropDown.currentProject,
                                getDropDown.projectList, onChangeProject)
                            : commonUIObj.dropDownUI(getDropDown.currentProjectAr,
                                getDropDown.projectListAr, onChangeProject),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     Container(
                        //       width: MediaQuery.of(context).size.width - 100.0,

                        //       // width: MediaQuery.of(context).size.width - 40.0,
                        //       decoration: BoxDecoration(
                        //           color: Colors.indigo[50].withOpacity(0.7),
                        //           borderRadius: BorderRadius.circular(10.0)),
                        //       child: new DropdownButton<String>(
                        //         hint: Text("Project"),
                        //         iconEnabledColor: Colors.indigo,
                        //         iconDisabledColor: Colors.indigo,
                        //         value: getDropDown.currentProject,
                        //         items:
                        //             getDropDown.projectList.map((String value) {
                        //           return new DropdownMenuItem<String>(
                        //             value: value,
                        //             child: Center(
                        //               // padding: const EdgeInsets.only(left:20.0,right:0.0),
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: new Text(value,
                        //                     style: TextStyle(
                        //                         color: Colors.indigo[300])),
                        //               ),
                        //             ),
                        //           );
                        //         }).toList(),
                        //         onChanged: (val) {
                        //           setState(() {
                        //             getDropDown.currentProject = val;
                        //           });
                        //           if (projectResult.length > 0) {
                        //             for (int i = 0;
                        //                 i < projectResult.length;
                        //                 i++) {
                        //               if (projectResult[i]["ProjectName"] ==
                        //                   val) {
                        //                 setState(() {
                        //                   getDropDown.currentProjectID =
                        //                       projectResult[i]["ProjectID"];
                        //                 });
                        //               }
                        //             }
                        //             print("Projectid :::::::::::::::" +
                        //                 getDropDown.currentProjectID
                        //                     .toString());
                        //           }
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 60.0,
                            right: 60.0,
                            bottom: 10.0
                          ),
                          child: Text(
                            (Localizations.localeOf(context).languageCode ==
                                    "en")
                                ? "stage"
                                : "موقف العميل",
                            style:
                                TextStyle(color: Colors.indigo, fontSize: 15.0),
                          ),
                        ),
                        (Localizations.localeOf(context).languageCode == "en")
                            ? commonUIObj.dropDownUI(getDropDown.currentStage,
                                getDropDown.stageList, onChangeStage)
                            : commonUIObj.dropDownUI(getDropDown.currentStageAr,
                                getDropDown.stageListAr, onChangeStage),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     Container(
                        //       width: MediaQuery.of(context).size.width - 100.0,
                        //       decoration: BoxDecoration(
                        //           color: Colors.indigo[50].withOpacity(0.7),
                        //           borderRadius: BorderRadius.circular(10.0)),
                        //       child: new DropdownButton<String>(

                        //         iconEnabledColor: Colors.indigo,
                        //         iconDisabledColor: Colors.indigo,
                        //         value: getDropDown.currentStage,
                        //         items:
                        //             getDropDown.stageList.map((String value) {
                        //           return new DropdownMenuItem<String>(
                        //             value: value,
                        //             child: Center(
                        //               // padding: const EdgeInsets.only(left:20.0,right:0.0),
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: new Text(value,
                        //                     style: TextStyle(
                        //                         color: Colors.indigo[300])),
                        //               ),
                        //             ),
                        //           );
                        //         }).toList(),
                        //         onChanged: (val) {},
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 50.0, right: 50.0),
                          child: InkWell(
                            onTap: () {
                              getDropDown
                                  .searchApi(
                                      getDropDown.currentProjectID,
                                      leadPhoneController.text,
                                      leadNameController.text,
                                      getDropDown.currentStageID)
                                  .then((val) {
                                if (val.toString() == "[]") {
                                  setState(() {
                                    searchResult = AppLocalizations.of(context)
                                        .dataNotFound;
                                  });
                                } else {
                                  setState(() {
                                    searchResult = val.toString();
                                  });
                                }
                              });
                            },
                            child: Container(
                              height: 40.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                AppLocalizations.of(context).search,
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        )
                      ],
                    )),
    );
  }

  onChangeStage(String val) {
    setState(() {
      getDropDown.currentStage = val;
      getDropDown.currentStageAr = val;
    });
    if (stageResult.length > 0) {
      for (int i = 0; i < stageResult.length; i++) {
        if (stageResult[i]["StageName"] == val ||
            stageResult[i]["StageNameAr"] == val) {
          setState(() {
            getDropDown.currentStageID = stageResult[i]["StageID"];
          });
        }
      }
      print("stageid :::::::::::::::" + getDropDown.currentStageID.toString());
    }
  }

  onChangeProject(String val) {
    setState(() {
      getDropDown.currentProject = val;
      getDropDown.currentProjectAr = val;

    });
    if (projectResult.length > 0) {
      for (int i = 0; i < projectResult.length; i++) {
        if (projectResult[i]["ProjectName"] == val ) {
          setState(() {
            getDropDown.currentProjectID = projectResult[i]["ProjectID"];
          });
        }
      }
      print("Projectid :::::::::::::::" +
          getDropDown.currentProjectID.toString());
    }
  }
}

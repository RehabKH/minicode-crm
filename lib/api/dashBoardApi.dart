import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:minicode_crm/api/loginApi.dart';

class DashBoardApi {
  var allStages, leads, allProjects, allDashboardStages, allChannel;
  LoginApi loginApi = new LoginApi();
  String currentProject = "",
      currentStage = "",
      currentChannel = "",
      currentProjectAr = "",
      currentDashboardStage;

  String currentStageAr = "",
      currentChannelAr = "",
      currentDashboardStageAr = "";
  int currentProjectID,
      currentStageID,
      currentChannelID,
      currentDashboardStageID;

  List<String> projectList = new List<String>();
  List<String> projectListAr = new List<String>();

  List<String> stageList = new List<String>();
  List<String> dashboardStageList = new List<String>();
  List<String> channelList = new List<String>();
  List<String> stageListAr = new List<String>();
  List<String> dashboardStageListAr = new List<String>();
  List<String> channelListAr = new List<String>();
  List<int> projectListID = new List<int>();
  List<int> stageListID = new List<int>();
  List<int> channelListID = new List<int>();
  List<int> dashboardStageListID = new List<int>();

  getAllStages() async {
    // print("phone: " + phone);
    await loginApi.getAccessToken();
    print(loginApi.token);
    var response =
        await http.get("http://104.196.134.107/AfitAPI/api/Stages", headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${loginApi.token}',
    });
    var result = json.decode(response.body);

    print("all stage result: " + result.toString());
    allStages = result;
    stageList.add("select");
    stageListAr.add("اختر");

    if (allStages.length > 0) {
      for (int i = 0; i < allStages.length; i++) {
        stageList.add((allStages[i]["StageName"] == null)
            ? ""
            : allStages[i]["StageName"]);
        stageListID.add(allStages[i]["StageID"]);

        stageListAr.add((allStages[i]["StageNameAr"] == null)
            ? ""
            : allStages[i]["StageNameAr"]);
        stageListID.add(allStages[i]["StageID"]);
      }
      currentStage = stageList[0];
      currentStageAr = stageListAr[0];

      currentStageID = stageListID[0];
// print("currentStageID::::::::::::::::::: "+currentStageID.toString());
    } else {
      currentStage = "No stage";
    }
    return allStages;
  }

  ///////////////////////////////////////get leads by stageID
  getLeadsByStageID(int stageID) async {
    // print("phone: " + phone);
    await loginApi.getAccessToken();
    print(loginApi.token);
    var response = await http.get(
        "http://104.196.134.107/AfitAPI/api/Clients/stage/$stageID",
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginApi.token}',
        });
    var result = json.decode(response.body);

    print("all lead result: " + result.toString());
    leads = result;
    return leads;
  }

  ///////////////////////get all project
  getAllProjects() async {
    // print("phone: " + phone);
    await loginApi.getAccessToken();
    print(loginApi.token);
    var response =
        await http.get("http://104.196.134.107/AfitAPI/api/Projects", headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${loginApi.token}',
    });
    var result = json.decode(response.body);

    print("all project result: " + result.toString());
    allProjects = result;
    projectList.add("select");
    projectListAr.add("اختر");

    if (allProjects.length > 0) {
      for (int i = 0; i < allProjects.length; i++) {
        projectList.add((allProjects[i]["ProjectName"] == null)
            ? ""
            : allProjects[i]["ProjectName"]);
        projectListAr.add((allProjects[i]["ProjectName"] == null)
            ? ""
            : allProjects[i]["ProjectName"]);
        projectListID.add(allProjects[i]["ProjectID"]);
      }
      currentProject = projectList[0];
      currentProjectAr = projectListAr[0];

      currentProjectID = (projectListID.length <= 0) ? 1 : projectListID[0];
    } else {
      currentProject = "No project";
    }
    return result;
  }

  ///////////////////////get all channel
  getAllChannels() async {
    // print("phone: " + phone);
    await loginApi.getAccessToken();
    print(loginApi.token);
    var response =
        await http.get("http://104.196.134.107/AfitAPI/api/Channels", headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${loginApi.token}',
    });
    var result = json.decode(response.body);

    print("all channel result: " + result.toString());
    allChannel = result;
    channelList.add("select");
    channelListAr.add("اختر");

    if (allChannel.length > 0) {
      for (int i = 0; i < allChannel.length; i++) {
        channelList.add((allChannel[i]["ChannelName"] == null)
            ? ""
            : allChannel[i]["ChannelName"]);
        channelListID.add(allChannel[i]["ChannelID"]);

        channelListAr.add((allChannel[i]["ChannelNameAr"] == null)
            ? ""
            : allChannel[i]["ChannelNameAr"]);
        channelListID.add(allChannel[i]["ChannelID"]);
      }
      currentChannel = channelList[0];
      currentChannelAr = channelListAr[0];

      currentChannelID = channelListID[0];
    } else {
      currentChannel = "No channel";
    }
    return allChannel;
  }

  ////////////////////////////////add lead
  addLead(int projectID, DateTime time, int stageID, int channelID,
      String comment, int empID, String mobile, String name) async {
    // print("phone: " + phone);
    await loginApi.getAccessToken();
    print("$projectID+$time+ $stageID+ $channelID+ $comment+$empID");
    print(DateTime(2018, 1, 13));
    var response =
        await http.post("http://104.196.134.107/AfitAPI/api/Clients", body: {
      "ClientName": name,
      "ClientMobile": mobile,
      "ProjectID": (projectID == null) ? "1" : projectID.toString(),
      "CreationDate": time.toString(),
      "StageID": stageID.toString(),
      "ChannelID": channelID.toString(),
      "LastComment": comment,
      "EmpID": empID.toString(),
    }, headers: {
      // 'Content-Type': 'application/json',
      // 'Accept': 'application/json',
      'Authorization': 'Bearer ${loginApi.token}',
    });
    var result = json.decode(response.body);
    print("add lead result: " + result.toString());

    if (result["Success"] == true) {
      return "success";
    } else {
      return result["Message"];
    }
  }

  /////////////////search
  searchApi(int projectID, String mobile, String name, int stageId) async {
    // print("phone: " + phone);
    await loginApi.getAccessToken();
    print("$projectID+$mobile+ $name+ $stageId");

    var response = await http.get(
        "http://104.196.134.107/AfitAPI/api/Clients/Search?ClientName=$name&ClientMobile=$mobile&ProjectID=$projectID&StageID=$stageId",
       
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${loginApi.token}',
        });
    var result = json.decode(response.body);
    print("search result: " + result.toString());
    return result;
  }

  /////////////////////////add action
  addAction(String actionDate, String clientID, String actionComment,
      String empID, String stageID, String newActionDate) async {
    await loginApi.getAccessToken();
    print(clientID +
        actionComment +
        empID +
        stageID +
        ",$newActionDate, $actionDate");
    var response = await http
        .post("http://104.196.134.107/AfitAPI/api/ClientActions", body: {
      "ActionDate": actionDate,
      "ClientID": clientID,
      "ActionComment": actionComment,
      "EmpID": empID,
      "StageID": stageID,
      "NewActionDate": newActionDate
    }, headers: {
      // 'Content-Type': 'application/json',
      // 'Accept': 'application/json',
      'Authorization': 'Bearer ${loginApi.token}',
    });
    var result = json.decode(response.body);
    print("add action result: " + result.toString());
    if (result["Success"] == true) {
      return "success";
    } else {
      return result["Message"];
    }
  }

  //////////////get notification count
  getNotificationCount(String empID) async {
    await loginApi.getAccessToken();
    print(empID);
    // print(clientID + actionComment + empID + stageID + ",$newActionDate");
    var response = await http.get(
        "http://104.196.134.107/AfitAPI/api/Clients/Alerts?EmpId=$empID"
        //     , body: {

        //   "EmpId": empID,

        // },
        ,
        headers: {
          // 'Content-Type': 'application/json',
          // 'Accept': 'application/json',
          'Authorization': 'Bearer ${loginApi.token}',
        });
    var result = json.decode(response.body);
    print("notification count result: " + result.toString());

    return result[0]["Count"];
  }

  /////////////////get notification list
  getNotificationList(String empID) async {
    await loginApi.getAccessToken();
    print(empID);
    // print(clientID + actionComment + empID + stageID + ",$newActionDate");
    var response = await http.get(
        "http://104.196.134.107/AfitAPI/api/Clients/AlertsList?EmpId=$empID",
        headers: {
          // 'Content-Type': 'application/json',
          // 'Accept': 'application/json',
          'Authorization': 'Bearer ${loginApi.token}',
        });
    var notificationResult = json.decode(response.body);
    print("notification list result: " + notificationResult.toString());
    return notificationResult;
  }

  ///////////////get all stage inside dashboard
  getDashboardStages() async {
    // print("phone: " + phone);
    await loginApi.getAccessToken();
    print(loginApi.token);
    var response = await http
        .get("http://104.196.134.107/AfitAPI/api/StagesClients", headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${loginApi.token}',
    });
    var result = json.decode(response.body);

    print("all dashboard stage result: " + result.toString());
    allDashboardStages = result;
    dashboardStageList.add("select");
    dashboardStageListAr.add("اختر");
    if (allDashboardStages.length > 0) {
      for (int i = 0; i < allDashboardStages.length; i++) {
        dashboardStageList.add((allDashboardStages[i]["StageName"] == null)
            ? ""
            : allDashboardStages[i]["StageName"]);
              dashboardStageList.add((allDashboardStages[i]["StageNameAr"] == null)
            ? ""
            : allDashboardStages[i]["StageNameAr"]);
        dashboardStageListID.add(allDashboardStages[i]["StageID"]);
      }
      currentDashboardStage = dashboardStageList[0];
      currentDashboardStageAr = dashboardStageListAr[0];

      currentDashboardStageID = dashboardStageListID[0];
// print("currentStageID::::::::::::::::::: "+currentStageID.toString());
    } else {
      currentDashboardStage = "No stage";

      currentDashboardStage = "لا يوجد بيانات لعرضها";

    }
    return allDashboardStages;
  }

  ////////////////////////////////add lead
  editLead(int projectID, DateTime time, int stageID, int channelID,
      String comment, int empID, String mobile, String name) async {
    // print("phone: " + phone);
    await loginApi.getAccessToken();
    print("$projectID+$time+ $stageID+ $channelID+ $comment+$empID");
    print(DateTime(2018, 1, 13));
    var response =
        await http.put("http://104.196.134.107/AfitAPI/api/Clients", body: {
      "ClientName": name,
      "ClientMobile": mobile,
      "ProjectID": (projectID == null) ? "1" : projectID.toString(),
      "CreationDate": time.toString(),
      "StageID": stageID.toString(),
      "ChannelID": channelID.toString(),
      "LastComment": comment,
      "EmpID": empID.toString(),
    }, headers: {
      // 'Content-Type': 'application/json',
      // 'Accept': 'application/json',
      'Authorization': 'Bearer ${loginApi.token}',
    });
    var result = json.decode(response.body);
    print("add lead result: " + result.toString());

    if (result["Success"] == true) {
      return "success";
    } else {
      return result["Message"];
    }
  }
}

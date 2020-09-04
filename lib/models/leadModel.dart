class LeadModel {
  int clientID;
  String clientName;
  String clientMobile;
  int projectID;
  String projectName;
  DateTime creationDate;
  int stageID;
  String stageName;
  String stageNameAr;
  int channelID;
  String channelName;
  String channelNameAr;
  String lastComment;
  DateTime nextActionDate;
  int empID;
 String empName;
  LeadModel(
      {this.clientID,
      this.clientName,
      this.clientMobile,
      this.projectID,
      this.projectName,
      this.creationDate,
      this.stageID,
      this.stageName,
      this.stageNameAr,
      this.channelID,
      this.channelName,
      this.channelNameAr,
      this.lastComment,
      this.nextActionDate,
      this.empID,this.empName});
}

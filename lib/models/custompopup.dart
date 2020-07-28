

class CustomPopupMenu {
  CustomPopupMenu(
      {this.clientID,
      this.clientName,
      this.clientPhone,
      this.creationDate,
      this.projectName,
      this.stageID,
      this.stageName,
      this.lastComment,
      this.nextActionDate});
  String clientName;
  String clientPhone;
  String clientID;
  String projectName;
  DateTime creationDate;
  String stageName;
  String stageID;
  String lastComment;
  DateTime nextActionDate;
}

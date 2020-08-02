import 'package:flutter/material.dart';
import 'package:minicode_crm/api/dashBoardApi.dart';
import 'leadDetails.dart';

class LeadsPage extends StatefulWidget {
  final int stageID;
  LeadsPage({this.stageID});
  @override
  _LeadsPageState createState() => _LeadsPageState();
}

class _LeadsPageState extends State<LeadsPage> {
  DashBoardApi dbApi = new DashBoardApi();
  bool loading = true;
  var allLeads;
  @override
  void initState() {
    super.initState();
    print("stage id: " + widget.stageID.toString());
    dbApi.getLeadsByStageID(widget.stageID).then((val) {
      setState(() {
        loading = false;
        allLeads = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 150.0,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              title: Text(
                  (Localizations.localeOf(context).languageCode == "en")
                      ? "Leads"
                      : "العملاء",
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
              background: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  image: AssetImage("assets/logo.jpg"),
                )),
              )

              //
              ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              child: (loading || allLeads == null)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      ],
                    )
                  : (allLeads.length == 0 || allLeads.toString() == "[]")
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text(
                                (Localizations.localeOf(context).languageCode ==
                                        "en")
                                    ? "No Leads Exist"
                                    : "لا يوجد عملاء",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black38,
                                ),
                              ),
                            )
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            SizedBox(height: 10.0),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                new LeadDetails(
                                                  name: allLeads[index]
                                                      ["ClientName"],
                                                  mobile: allLeads[index]
                                                      ["ClientMobile"],
                                                  projectName: allLeads[index]
                                                      ["ProjectName"],
                                                  stageName: (Localizations
                                                                  .localeOf(
                                                                      context)
                                                              .languageCode ==
                                                          "en")
                                                      ? allLeads[index]
                                                          ["StageName"]
                                                      : allLeads[index]
                                                          ["StageNameAr"],
                                                  creationDate: DateTime.parse(
                                                      allLeads[index]
                                                          ["CreationDate"]),
                                                  stageID: allLeads[index]
                                                          ["StageID"]
                                                      .toString(),
                                                  clientID: allLeads[index]
                                                          ["ClientID"]
                                                      .toString(),
                                                  channelName: (Localizations
                                                                  .localeOf(
                                                                      context)
                                                              .languageCode ==
                                                          "en")
                                                      ? allLeads[index]
                                                          ["ChannelName"]
                                                      : allLeads[index]
                                                          ["ChannelNameAr"],
                                                  lastComment: allLeads[index]
                                                      ["LastComment"],
                                                )));
                                  },
                                  child: Card(
                                    elevation: 0.2,
                                    child: ListTile(
                                      title: Text(allLeads[index]["ClientName"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text(
                                          (Localizations.localeOf(context)
                                                      .languageCode ==
                                                  "en")
                                              ? allLeads[index]["StageName"]
                                              : allLeads[index]["StageNameAr"],
                                          style: TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
            );
          },
          childCount: (allLeads == null) ? 0 : allLeads.length,
        ))
      ]),
    );
  }
}

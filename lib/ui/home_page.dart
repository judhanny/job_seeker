
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:job_seeker/models/applications_by_company.dart';
import 'package:job_seeker/models/job_application.dart';
import 'package:job_seeker/ui/company_applications_page.dart';
import 'package:job_seeker/ui/custom_colours.dart';
import 'package:job_seeker/utils/web_sample_job_application_loader.dart';

import 'companies_pie_chart_widget.dart';

class HomePage extends StatefulWidget{
  final ApplicationsByCompany companies;

  const HomePage({Key? key, required this.companies}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();

}

class HomePageState extends State<HomePage> {
  WebSampleJobApplicationLoader _webSampleJobApplicationLoader = new WebSampleJobApplicationLoader();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: _buildDashboard(),
    );
  }

  Widget _dashboardFromExistingData(){
    return (Padding(
          padding: const EdgeInsets.only(top: 12),
          child: StaggeredGridView.count(
          crossAxisCount: 4,
          staggeredTiles: _layout(),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          padding: const EdgeInsets.all(4),
          children: _tiles(),
    )));
  }


  List<StaggeredTile> _layout(){
    List<StaggeredTile> staggeredTiles = <StaggeredTile>[
      StaggeredTile.count(2, 2),
      StaggeredTile.count(2, 1),
      StaggeredTile.count(1, 1),
      StaggeredTile.count(1, 1),
    ];
    return staggeredTiles;
  }

  List<Widget> _tiles(){
    List<Widget> tiles = <Widget>[
      _companiesTile(CustomColours.INDIGO, Icons.account_balance_outlined),
      _PendingTile(CustomColours.TEAL, Icons.topic_outlined, "Applications"),
      _PendingTile(CustomColours.LIME_GREEN, Icons.location_city_outlined, "Job Locations"),
      _PendingTile(CustomColours.ROSE, Icons.timer, "Deadlines"),
    ];
    return tiles;
  }

  Widget _companiesTile(Color backgroundColor, IconData iconData ){
    int numCompanies = widget.companies.companiesMap.length;
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      child: InkWell(
        onTap: (){ Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CompanyApplications(companies: widget.companies, notifyParent: refresh)),
        );},
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$numCompanies Companies ", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold )),],
                  ),
                  CompaniesPieChart(widget.companies),
                ],
            ),
          ),
        ),
      ),
    );
  }

 Widget _buildDashboard(){
   if(widget.companies.companiesMap.isEmpty){
     return _buildDashboardFromInternetSource();
   }
   else{
     return _dashboardFromExistingData();
   }
 }

 FutureBuilder<List<JobApplication>> _buildDashboardFromInternetSource(){
    return FutureBuilder<List<JobApplication>>(

        future: _webSampleJobApplicationLoader.getSampleApplications(),
        builder: (context, snapshot){
          if (snapshot.hasError) print(snapshot.error);

          if(snapshot.hasData){
            widget.companies.addJobApplications(snapshot.data!);
            return _dashboardFromExistingData();
          }
          else{
            return Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  CircularProgressIndicator(),
                  Text("Fetching Sample Job Applications From Internet")
                ]));
          }
        }
    );
  }

  void refresh() {
    setState(() {});
  }

}

class _PendingTile extends StatelessWidget {
  final Color backgroundColor;
  final IconData iconData;
  final String title;

  const _PendingTile(this.backgroundColor, this.iconData, this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      child: InkWell(
        onTap: (){
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(
              '$title page implementation coming soon')));
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(
              iconData,
              color: Colors.black54,
            ),
                Text("# "+title, style: TextStyle(color: Colors.black54)),
                  Text("Coming soon", style: TextStyle(color: Colors.grey, fontSize: 12)),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
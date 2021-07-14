import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_seeker/models/application_status.dart';
import 'package:job_seeker/models/applications_by_company.dart';
import 'package:job_seeker/models/company.dart';
import 'package:job_seeker/models/job_application.dart';

import 'colour_generator.dart';
import 'new_job_application_form.dart';

class CompanyApplications extends StatefulWidget {
  final ApplicationsByCompany companies;

  const CompanyApplications({Key? key, required this.companies}) : super(key: key);

  @override
  _CompanyApplicationsState createState() => _CompanyApplicationsState();
}

class _CompanyApplicationsState extends State<CompanyApplications> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Companies'),
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
      body: _buildCompanyApplicationList(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Job Application', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: (){
            JobApplication application = JobApplication.blankApplication();
            _showNewApplicationFormDialog(application).then((value) {

              if(application.applicationStatus != ApplicationStatus.ERROR && application.applicationStatus != ApplicationStatus.DELETE){
                setState(() {
                  widget.companies.addJobApplication(application);
                });
              }
              else{
                String company = application.companyName;
                String title = application.jobTitle;
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(
                    'Error adding new job application for  $company - $title')));
              }
            });
          },
      ),
    );
  }



  Widget _buildCompanyApplicationList(){
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: widget.companies.companiesMap.values.map((company) => _individualCompany(company)).toList()
    );
  }

  Future _showNewApplicationFormDialog(JobApplication application){
      return showDialog(context: context,
          builder: (BuildContext context){
        return AlertDialog(
            title: Text("New Job Application", textAlign: TextAlign.center),
            content: new NewJobApplicationForm(application));
      });
  }

  Widget _individualCompany(Company company){
    String companyName = company.companyName;
    int numJobs  = company.getNumberOfApplications();
    return  Center(
        child: Container(
            padding: const EdgeInsets.all(16),
            color: ColourGenerator().getPastelColour(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.account_balance_outlined,
                  size: 25,
                  color: Colors.black,
                ),
                Text( '$companyName',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center),
                Text( '\n$numJobs Applications',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    textAlign: TextAlign.center)
              ],
            )
        )
    );
  }

}

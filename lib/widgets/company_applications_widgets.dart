import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_seeker/models/applications_by_company.dart';
import 'package:job_seeker/models/company.dart';
import 'package:job_seeker/models/contact.dart';
import 'package:job_seeker/models/job_application.dart';

import 'colour_generator.dart';
import 'new_job_application_form.dart';

class CompanyApplications extends StatefulWidget {
  const CompanyApplications({Key? key}) : super(key: key);

  @override
  _CompanyApplicationsState createState() => _CompanyApplicationsState();
}

class _CompanyApplicationsState extends State<CompanyApplications> {
  List<JobApplication> jobApplications =[];
  ApplicationsByCompany companies = new ApplicationsByCompany({});

  @override
  void initState() {
    super.initState();
    for(int x=0; x< 3; x++){ //num jobs
      for(int y=0; y < 60; y++){ //num companies
        JobApplication application = LocalJobApplicationCreator.getApplication(x+1, y+1);
        jobApplications.add(application);
        companies.addJobApplication(application);
      }
    }
  }

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
        tooltip: 'Add New Application', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: ()=> _showNewApplicationFormDialog(),
      ),
    );
  }

  Widget _buildJobApplicationList(){
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      children: jobApplications.map((job) => _individualApplication(job)).toList()
    );
  }

  Widget _buildCompanyApplicationList(){
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: companies.companiesMap.values.map((company) => _individualCompany(company)).toList()
    );
  }

  Future _showNewApplicationFormDialog(){
      return showDialog(context: context,
          builder: (BuildContext context){
        return AlertDialog(content: new NewJobApplicationForm());
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


  Widget _individualApplication(JobApplication application){
    String companyName = application.companyName;
    String jobTitle = application.jobTitle;
    return  Center(
        child: Container(
            padding: const EdgeInsets.all(16),
            color: ColourGenerator().getRandomColour(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.account_balance_outlined,
                  size: 25,
                  color: Colors.black,
                ),
                Text( 'Company = $companyName',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center),
                Text( 'Job Title = $jobTitle',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    textAlign: TextAlign.center)
              ],
            )
        )
    );
  }

}

class LocalJobApplicationCreator {

  static String title = "Hard Job";
  static String companyName = "Company";
  static String teamName = "Team";
  static DateTime appDate = DateTime.now();
  static DateTime deadline = new DateTime(
      appDate.year, appDate.month + 1, appDate.day);
  static String description = "Job description";
  static List<Contact> contacts = [new Contact("John", "Smith", "BoomCo", "Hiring Manager", "Not a nice man"),
    Contact("June", "Smith", "BoomCo", "HR Rep", "Hard to get hold of")];

  static JobApplication getApplication(int jobTitlePostfixNum, int companyPostfixNum) {
    return new JobApplication(
        title + ' $jobTitlePostfixNum', companyName+ ' $companyPostfixNum', teamName, appDate, deadline, description, contacts);
  }
}
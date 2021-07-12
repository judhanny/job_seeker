import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_seeker/models/applications_by_company.dart';
import 'package:job_seeker/models/company.dart';
import 'package:job_seeker/models/contact.dart';
import 'package:job_seeker/models/job_application.dart';

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
    for(int x=0; x< 3; x++){ //num jobs
      for(int y=0; y < 5; y++){ //num companies
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
        title: const Text('Applications By Company'),
      ),
      body: _buildCompanyApplicationList(),
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

  Widget _individualCompany(Company company){
    String companyName = company.companyName;
    int numJobs  = company.getNumberOfApplications();
    return  Center(
        child: Container(
            padding: const EdgeInsets.all(16),
            color: RandomColorModel().getColor(),
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
                Text( 'Num Applications = $numJobs ',
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
            color: RandomColorModel().getColor(),
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

class RandomColorModel {
  Random random = Random();
  Color getColor() {
    return Color.fromARGB(random.nextInt(300), random.nextInt(300),
        random.nextInt(300), random.nextInt(300));
  }
}

class LocalJobApplicationCreator {

  static String TITLE = "Hard Job";
  static String COMPANY_NAME = "Company";
  static String TEAM_NAME = "Team";
  static DateTime APP_DATE = DateTime.now();
  static DateTime DEADLINE = new DateTime(
      APP_DATE.year, APP_DATE.month + 1, APP_DATE.day);
  static String DESCRIPTION = "Job description";
  static List<Contact> CONTACTS = [new Contact("John", "Smith", "BoomCo", "Hiring Manager", "Not a nice man"),
    Contact("June", "Smith", "BoomCo", "HR Rep", "Hard to get hold of")];

  static JobApplication getApplication(int jobTitlePostfixNum, int companyPostfixNum) {
    return new JobApplication(
        TITLE + ' $jobTitlePostfixNum', COMPANY_NAME+ ' $companyPostfixNum', TEAM_NAME, APP_DATE, DEADLINE, DESCRIPTION, CONTACTS);
  }
}
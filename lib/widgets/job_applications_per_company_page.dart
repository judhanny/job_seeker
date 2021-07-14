import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_seeker/models/company.dart';
import 'package:job_seeker/models/job_application.dart';

import 'colour_generator.dart';

class JobApplicationsPerCompany extends StatefulWidget{
  final Company company;
  JobApplicationsPerCompany(this.company);

  @override
  _JobApplicationsPerCompanyState createState() => _JobApplicationsPerCompanyState();
}

class _JobApplicationsPerCompanyState extends State<JobApplicationsPerCompany> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company.companyName + " - Job Applications"),
      ),
      body: _buildJobApplicationList(),
    );
  }

  Widget _buildJobApplicationList(){
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: widget.company.applications.map((job) => _individualApplication(job)).toList()
    );
  }

  Widget _individualApplication(JobApplication application){
    String key = application.jobTitle +" " + application.teamName + " " + application.location;
    return  Center(
        child: Container(
          width: 170,
          height: 170,
          child: Card(
            color: ColourGenerator().getPastelColourForKey(key),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            child: new InkWell(
              splashColor: Colors.blue.withAlpha(30),
              child: _jobApplicationSummaryDisplay(application),
              onTap: (){
                print("PRESSED: Individual application " + key);
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JobApplicationsPerCompany(company)),
                );*/
              },
            ),
          ),
        )
    );
  }

  Widget _jobApplicationSummaryDisplay(JobApplication application) {
    String jobTitle = application.jobTitle;
    String team = application.teamName;
    String location = application.location;
    DateFormat dateFormatter = DateFormat('dd-MMMM-yyyy');
    String deadline = dateFormatter.format(application.applicationDeadline);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 25),
        Icon(
          Icons.topic_outlined,
          size: 25,
          color: Colors.black,
        ),
        Text('$jobTitle',
            style: TextStyle(fontSize: 18, color: Colors.black),
            textAlign: TextAlign.center),
        Text('\nTeam: $team',
            style: TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.center),
        Text('Location: $location',
            style: TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.center),
        Text('Deadline: $deadline',
            style: TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.center)
      ],
    );
  }
}
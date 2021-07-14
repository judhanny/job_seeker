

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_seeker/models/job_application.dart';

import 'colour_generator.dart';
import 'new_job_application_form.dart';

class JobApplications extends StatefulWidget{
  final List<JobApplication> jobApplications;
  const JobApplications({Key? key, required this.jobApplications}) : super(key: key);

  @override
  _JobApplicationsState createState() => _JobApplicationsState();
}

class _JobApplicationsState extends State<JobApplications> {

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
      body: _buildJobApplicationList(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Job Application', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: ()=> _showNewApplicationFormDialog(),
      ),
    );
  }

  Widget _buildJobApplicationList(){
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: widget.jobApplications.map((job) => _individualApplication(job)).toList()
    );
  }

  Widget _individualApplication(JobApplication application){
    String companyName = application.companyName;
    String jobTitle = application.jobTitle;
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

  Future _showNewApplicationFormDialog(){
    return showDialog(context: context,
        builder: (BuildContext context){
        JobApplication application = JobApplication.blankApplication();
        return AlertDialog(
              title: Text("New Job Application", textAlign: TextAlign.center),
              content: new NewJobApplicationForm(application));
        });
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_seeker/models/applications_by_company.dart';
import 'package:job_seeker/models/company.dart';
import 'package:job_seeker/models/job_application.dart';

import 'colour_generator.dart';
import 'job_applications_per_company_page.dart';
import 'new_job_application_form.dart';
import 'new_job_application_page.dart';

class CompanyApplications extends StatefulWidget {
  final ApplicationsByCompany companies;
  final Function() notifyParent;

  const CompanyApplications({Key? key, required this.companies, required this.notifyParent}) : super(key: key);

  @override
  _CompanyApplicationsState createState() => _CompanyApplicationsState();
}

class _CompanyApplicationsState extends State<CompanyApplications> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Companies'),
      ),
      body: _buildCompanyApplicationGrid(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Job Application', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewJobApplicationPage(widget.companies, refresh)),
          );
          },
      ),
    );
  }

  Widget _buildCompanyApplicationGrid(){
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
          width: 170,
          height: 170,
            child: Card(
              color: ColourGenerator().getPastelColourForKey(companyName),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              child: new InkWell(
                splashColor: Colors.blue.withAlpha(30),
                child: _companySummaryDisplay(companyName, numJobs),
                onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JobApplicationsPerCompany(company)),
                    );
                  },
              ),
            ),
        )
    );
  }

  Widget _companySummaryDisplay(String companyName, int numJobs){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 45),
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
    );
  }

  void refresh() {
    setState(() {
      //print("*** REFRESH from child called for COMPANY APPLICATIONS page");
      widget.notifyParent();
    });
  }

}

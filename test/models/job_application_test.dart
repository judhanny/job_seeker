import 'package:intl/intl.dart';
import 'package:job_seeker/models/application_status.dart';
import 'package:test/test.dart';
import 'package:job_seeker/models/job_application.dart';

import '../test_helpers/job_application_creator.dart';


void main(){

  test('test basic construction of job application', (){
    final JobApplication application = JobApplicationCreator.getApplication();
    expect(application.jobTitle, JobApplicationCreator.applicationTitle);
    expect(application.companyName, JobApplicationCreator.applicationCompanyName);
    expect(application.teamName, JobApplicationCreator.applicationTeamName);
    expect(application.applicationDate, JobApplicationCreator.applicationApplicationDate);
    expect(application.applicationDeadline, JobApplicationCreator.applicationDeadline);
    expect(application.jobDescription, JobApplicationCreator.applicationJobDescription);
    expect(application.applicationStatus, ApplicationStatus.IN_PROGRESS);
    expect(application.applicationContacts, JobApplicationCreator.applicationContacts);
  });

  test('test basic construction of job application from & to json', (){
    final JobApplication application = JobApplicationCreator.getApplication();
    Map<String, dynamic> json = application.toJson();
    final JobApplication appFromJson = JobApplication.fromJson(json);

    expect(application.jobTitle, appFromJson.jobTitle);
    expect(application.companyName, appFromJson.companyName);
    expect(application.teamName, appFromJson.teamName);
    expect(application.applicationDate, appFromJson.applicationDate);
    expect(application.applicationDeadline, appFromJson.applicationDeadline);
    expect(application.jobDescription, appFromJson.jobDescription);
    expect(application.applicationStatus, appFromJson.applicationStatus);
    expect(application.applicationContacts, appFromJson.applicationContacts);
  });

  test('test basic construction of blank application', (){
    final JobApplication application = JobApplication.blankApplication();
    DateTime now = DateTime.now();
    DateFormat dateFormatter = DateFormat('dd-MMMM-yyyy');
    String todaysDate = dateFormatter.format(now); //we're not that bothered about time in this app

    expect(application.jobTitle, "");
    expect(application.companyName, "");
    expect(application.teamName, "");
    expect(dateFormatter.format(application.applicationDate), todaysDate);
    expect(dateFormatter.format(application.applicationDeadline), todaysDate);
    expect(application.jobDescription, "");
    expect(application.applicationStatus, ApplicationStatus.IN_PROGRESS);
    expect(application.applicationContacts, []);
  });
}

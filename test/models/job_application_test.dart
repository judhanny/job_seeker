import 'package:job_seeker/models/application_status.dart';
import 'package:test/test.dart';
import 'package:job_seeker/models/job_application.dart';

import '../test_helpers/job_application_creator.dart';


void main(){

  test('test basic construction of job application', (){
    final JobApplication application = JobApplicationCreator.getApplication();
    expect(application.jobTitle, JobApplicationCreator.TITLE);
    expect(application.companyName, JobApplicationCreator.COMPANY_NAME);
    expect(application.teamName, JobApplicationCreator.TEAM_NAME);
    expect(application.applicationDate, JobApplicationCreator.APP_DATE);
    expect(application.applicationDeadline, JobApplicationCreator.DEADLINE);
    expect(application.jobDescription, JobApplicationCreator.DESCRIPTION);
    expect(application.applicationStatus, ApplicationStatus.IN_PROGRESS);
    expect(application.applicationContacts, JobApplicationCreator.CONTACTS);
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
}

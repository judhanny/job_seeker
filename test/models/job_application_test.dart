import 'package:job_seeker/models/application_status.dart';
import 'package:test/test.dart';
import 'package:job_seeker/models/job_application.dart';

String _title = "Job 1";
String _companyName = "Company 1";
String _teamName="Team 1";
DateTime _appDate = DateTime.now();
DateTime _deadline = new DateTime(_appDate.year, _appDate.month + 1, _appDate.day);
String _description = "Job description 1";

JobApplication getApplication(){
  return new JobApplication(_title, _companyName, _teamName, _appDate, _deadline, _description);
}

void main(){

  test('test basic construction of job application', (){
    final JobApplication application = getApplication();
    expect(application.jobTitle, _title);
    expect(application.companyName, _companyName);
    expect(application.teamName, _teamName);
    expect(application.applicationDate, _appDate);
    expect(application.applicationDeadline, _deadline);
    expect(application.jobDescription, _description);
    expect(application.applicationStatus, ApplicationStatus.IN_PROGRESS);
  });

  test('test basic construction of job application from & to json', (){
    final JobApplication application = getApplication();
    Map<String, dynamic> json = application.toJson();
    final JobApplication appFromJson = JobApplication.fromJson(json);

    expect(application.jobTitle, appFromJson.jobTitle);
    expect(application.companyName, appFromJson.companyName);
    expect(application.teamName, appFromJson.teamName);
    expect(application.applicationDate, appFromJson.applicationDate);
    expect(application.applicationDeadline, appFromJson.applicationDeadline);
    expect(application.jobDescription, appFromJson.jobDescription);
    expect(application.applicationStatus, appFromJson.applicationStatus);
  });
}

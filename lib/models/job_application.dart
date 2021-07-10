import 'package:job_seeker/models/application_status.dart';

class JobApplication{

  String jobTitle = "";
  String companyName ="";
  String teamName="";
  late DateTime applicationDate;
  late DateTime applicationDeadline;
  String jobDescription ="";
  late ApplicationStatus applicationStatus;

  JobApplication(this.jobTitle, this.companyName, this.teamName,
      this.applicationDate, this.applicationDeadline, this.jobDescription){
    applicationStatus = ApplicationStatus.IN_PROGRESS;
  }

  JobApplication.fromJson(Map<String, dynamic> json)
    : jobTitle = json['jobTitle'],
    companyName = json['companyName'],
    teamName = json['teamName'],
    applicationDate = DateTime.parse(json['applicationDate']),
    applicationDeadline = DateTime.parse(json['applicationDeadline']),
    jobDescription = json['jobDescription'],
    applicationStatus = ApplicationStatusHelper.getStatusFromString(json['applicationStatus']);

    Map<String, dynamic> toJson() => {
      'jobTitle': jobTitle,
      'companyName': companyName,
      'teamName': teamName,
      'applicationDate': applicationDate.toIso8601String(),
      'applicationDeadline': applicationDeadline.toIso8601String(),
      'jobDescription': jobDescription,
      'applicationStatus': ApplicationStatusHelper.getValue(applicationStatus),
    };
}
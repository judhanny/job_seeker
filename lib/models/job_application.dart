import 'package:job_seeker/models/application_status.dart';
import 'package:job_seeker/models/contact.dart';

class JobApplication{

  String jobTitle = "";
  String companyName ="";
  String teamName="";
  late DateTime applicationDate;
  late DateTime applicationDeadline;
  String jobDescription ="";
  late ApplicationStatus applicationStatus;
  List<Contact> applicationContacts = List.empty();

  JobApplication(this.jobTitle, this.companyName, this.teamName,
      this.applicationDate, this.applicationDeadline, this.jobDescription, this.applicationContacts){
    applicationStatus = ApplicationStatus.IN_PROGRESS;
  }

  JobApplication.blankApplication(){
    this.applicationDate = DateTime.now();
    this.applicationDeadline = DateTime.now();
    this.applicationStatus = ApplicationStatus.IN_PROGRESS;
  }

  JobApplication.fromJson(Map<String, dynamic> json)
    : jobTitle = json['jobTitle'],
    companyName = json['companyName'],
    teamName = json['teamName'],
    applicationDate = DateTime.parse(json['applicationDate']),
    applicationDeadline = DateTime.parse(json['applicationDeadline']),
    jobDescription = json['jobDescription'],
    applicationStatus = ApplicationStatusHelper.getStatusFromString(json['applicationStatus'],),
    applicationContacts = parseContactsFromJSON(json);

    Map<String, dynamic> toJson() => {
      'jobTitle': jobTitle,
      'companyName': companyName,
      'teamName': teamName,
      'applicationDate': applicationDate.toIso8601String(),
      'applicationDeadline': applicationDeadline.toIso8601String(),
      'jobDescription': jobDescription,
      'applicationStatus': ApplicationStatusHelper.getValue(applicationStatus),
      'applicationContacts' : applicationContacts,
    };

    static List<Contact> parseContactsFromJSON(Map<String, dynamic> json){
      List<dynamic> contactJSON = json['applicationContacts'];

      //In memory json encode & decodes parse straight to Contact objects
      if(contactJSON.length >0){
         var item = contactJSON[0];
         if(item is Contact){
            return new List<Contact>.from(contactJSON);
         }
      }

      //From file json decode needs more work to parse Contact objects
      final List<Contact> contacts = contactJSON
          .map<Contact>((m) => Contact.fromJson(Map<String, dynamic>.from(m)))
          .toList();
      return contacts;
    }

  @override
  String toString() {
    return 'JobApplication{jobTitle: $jobTitle, companyName: $companyName, teamName: $teamName, applicationDate: $applicationDate, applicationDeadline: $applicationDeadline, jobDescription: $jobDescription, applicationStatus: $applicationStatus, applicationContacts: $applicationContacts}';
  }
}
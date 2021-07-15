
import 'package:job_seeker/models/contact.dart';
import 'package:job_seeker/models/job_application.dart';


class JobApplicationCreator {

  static String applicationTitle = "Job";
  static String applicationCompanyName = "Company";
  static String applicationTeamName = "Team";
  static DateTime applicationApplicationDate = new DateTime(2021, 7, 15);
  static DateTime applicationDeadline = new DateTime(
      applicationApplicationDate.year, applicationApplicationDate.month + 1, applicationApplicationDate.day);
  static String applicationJobDescription = "Job description blah blah";
  static List<Contact> applicationContacts = [new Contact("John", "Smith", "BoomCo", "Hiring Manager", "Not a nice man"),
    Contact("June", "Smith", "BoomCo", "HR Rep", "Hard to get hold of")];
  static String location = "London";

  static JobApplication getApplication() {
    return new JobApplication(
        applicationTitle, applicationCompanyName, applicationTeamName, applicationApplicationDate, applicationDeadline,
        applicationJobDescription, applicationContacts, location);
  }

  static JobApplication getApplicationWithCustomisation(int jobTitlePostfixNum, int companyPostfixNum) {
    return new JobApplication(
        applicationTitle + ' $jobTitlePostfixNum', applicationCompanyName+ ' $companyPostfixNum', applicationTeamName,
        applicationApplicationDate, applicationDeadline, applicationJobDescription, applicationContacts, location);
  }
}
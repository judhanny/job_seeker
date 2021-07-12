
import 'package:job_seeker/models/contact.dart';
import 'package:job_seeker/models/job_application.dart';


class JobApplicationCreator {

  static String TITLE = "Job";
  static String COMPANY_NAME = "Company";
  static String TEAM_NAME = "Team";
  static DateTime APP_DATE = DateTime.now();
  static DateTime DEADLINE = new DateTime(
      APP_DATE.year, APP_DATE.month + 1, APP_DATE.day);
  static String DESCRIPTION = "Job description blah blah";
  static List<Contact> CONTACTS = [new Contact("John", "Smith", "BoomCo", "Hiring Manager", "Not a nice man"),
    Contact("June", "Smith", "BoomCo", "HR Rep", "Hard to get hold of")];

  static JobApplication getApplication() {
    return new JobApplication(
        TITLE, COMPANY_NAME, TEAM_NAME, APP_DATE, DEADLINE, DESCRIPTION, CONTACTS);
  }

  static JobApplication getApplicationWithCustomisation(int jobTitlePostfixNum, int companyPostfixNum) {
    return new JobApplication(
        TITLE + ' $jobTitlePostfixNum', COMPANY_NAME+ ' $companyPostfixNum', TEAM_NAME, APP_DATE, DEADLINE, DESCRIPTION, CONTACTS);
  }
}
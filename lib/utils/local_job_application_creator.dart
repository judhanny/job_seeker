import 'package:job_seeker/models/applications_by_company.dart';
import 'package:job_seeker/models/contact.dart';
import 'package:job_seeker/models/job_application.dart';


/// Utility designed to create a number of job applications that can be used for local testing purposes
/// Not to be used in production context
class LocalJobApplicationCreator {

  static String title = "Hard Job";
  static String companyName = "Company";
  static String teamName = "Team";
  static DateTime appDate = DateTime.now();
  static DateTime deadline = new DateTime(
      appDate.year, appDate.month + 1, appDate.day);
  static String description = "This is a job description for the role at this company.";

  static String getLocation(int numberOfJobs){
    String location = "London";
    int remainder = numberOfJobs % 7;

    switch(remainder){
      case 1: location = "Paris"; break;
      case 2: location = "Los Angeles"; break;
      case 3: location = "Hong Kong"; break;
      case 4: location = "Cape Town"; break;
      case 5: location = "Mumbai"; break;
      case 6: location = "Barcelona"; break;
    }
    return location;
  }

  static ApplicationsByCompany createApplicationsByCompany(int numberOfJobsPerCompany, int numberOfCompanies){
    ApplicationsByCompany companies = new ApplicationsByCompany({});
    for(int x=0; x< numberOfJobsPerCompany; x++){ //num jobs
      for(int y=0; y < numberOfCompanies; y++){ //num companies
        JobApplication application = LocalJobApplicationCreator.getApplication(x+1, y+1);
        companies.addJobApplication(application);
      }
    }
    return companies;
  }

  static List<JobApplication> createApplications(int numberOfJobsPerCompany, int numberOfCompanies){
    List<JobApplication> applications = [];
    for(int x=0; x< numberOfJobsPerCompany; x++){ //num jobs
      for(int y=0; y < numberOfCompanies; y++){ //num companies
        JobApplication application = LocalJobApplicationCreator.getApplication(x+1, y+1);
        applications.add(application);
      }
    }
    return applications;
  }
  static JobApplication getApplication(int numberOfJobs, int numberOfCompanies) {
    String location = getLocation(numberOfJobs);
    List<Contact> contacts = [new Contact("John", "Smith", companyName+ ' $numberOfCompanies', "Hiring Manager", "Not a nice man"),
      Contact("June", "Smith", companyName+ ' $numberOfCompanies', "HR Rep", "Hard to get hold of")];

    return new JobApplication(
        title + ' $numberOfJobs', companyName+ ' $numberOfCompanies', teamName, appDate, deadline, description, contacts, location);
  }
}
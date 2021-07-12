import 'job_application.dart';

class Company{
  String companyName ="";
  List<JobApplication> applications =[];

  Company(String companyName, List<JobApplication> applications){
    this.companyName = companyName.toUpperCase();
    this.applications = applications;
  }

  void addJobApplication(JobApplication application){
    applications.add(application);
  }

  int getNumberOfApplications(){
    return applications.length;
  }

}
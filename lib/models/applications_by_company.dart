import 'package:job_seeker/models/company.dart';
import 'job_application.dart';

class ApplicationsByCompany {
  Map<String, Company> companiesMap = {};

  ApplicationsByCompany(this.companiesMap);

  void addJobApplication(JobApplication application) {
    String companyName = application.companyName.toUpperCase();
    if (!companiesMap.containsKey(companyName)) {
      companiesMap[companyName] = new Company(companyName, [application]);
    }
    else {
      Company? company = companiesMap[companyName];
      if (company != null) {
        company.addJobApplication(application);
      }
    }
  }

  void addJobApplications(List<JobApplication> applications) {
    applications.forEach((application) {
      this.addJobApplication(application);
    });
  }

  int getTotalNumberOfApplications(){
    int total =0;
    companiesMap.forEach((companyName, company) {
      total += company.applications.length;
    });
    return total;
  }
}
import 'package:job_seeker/models/applications_by_company.dart';
import 'package:job_seeker/models/company.dart';
import 'package:test/test.dart';
import 'package:job_seeker/models/job_application.dart';

import '../test_helpers/job_application_creator.dart';

void main(){

  test('test basic construction of ApplicationsByCompany', (){
    ApplicationsByCompany companies = new ApplicationsByCompany({});
    final int numJobs = 5;
    final int numCompanies = 3;
    for(int x=0; x< numJobs; x++){
      for(int y=0; y < numCompanies; y++){
        JobApplication application = JobApplicationCreator.getApplicationWithCustomisation(x+1, y+1);
        companies.addJobApplication(application);
      }
    }

    expect(companies.companiesMap.length, numCompanies);

    for(var entry in companies.companiesMap.entries){
        Company value = entry.value;
        expect(value.getNumberOfApplications(), numJobs);
    }

  });

  test('test construction of ApplicationsByCompany from a list', () {
    ApplicationsByCompany companies = new ApplicationsByCompany({});
    final int numJobs = 6;
    final int numCompanies = 5;
    List<JobApplication> applications = [];
    for (int x = 0; x < numJobs; x++) {
      for (int y = 0; y < numCompanies; y++) {
        JobApplication application = JobApplicationCreator
            .getApplicationWithCustomisation(x + 1, y + 1);
        applications.add(application);
      }
    }

    companies.addJobApplications(applications);
    expect(companies.companiesMap.length, numCompanies);

    for (var entry in companies.companiesMap.entries) {
      Company value = entry.value;
      expect(value.getNumberOfApplications(), numJobs);
    }
  });

}


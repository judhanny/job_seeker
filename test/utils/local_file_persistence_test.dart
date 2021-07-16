import 'package:job_seeker/models/application_status.dart';
import 'package:job_seeker/models/job_application.dart';
import 'package:job_seeker/utils/local_file_persistence.dart';
import 'package:test/test.dart';

import '../test_helpers/job_application_creator.dart';


void main() {
  LocalFilePersistence persistence = LocalFilePersistence();
  test('test local file name getting', () async {
    String qualifier = "unitTest";
    String filename = await persistence.getFilename(qualifier);
    expect(filename, LocalFilePersistence.FILE_MAIN_DIRECTORY + "/" + qualifier + LocalFilePersistence.FILE_POSTFIX);
  });

  test('test is singleton', () async {
    LocalFilePersistence persistence2 = LocalFilePersistence();
    expect(true, persistence == persistence2);
  });

  test('testing writing & reading a single job application to file', () async{
    JobApplication application = JobApplicationCreator.getApplication();
    List<JobApplication> applicationList = [application];
    String qualifier = "unitTestWritingJobApp";
    persistence.saveApplicationList(applicationList, qualifier);

    List<JobApplication> fromFile = await persistence.readApplicationList(qualifier);

    expect(fromFile.length, applicationList.length);

    fromFile.forEach((applicationFromFile) {
      expect(applicationFromFile.jobTitle, JobApplicationCreator.applicationTitle);
      expect(applicationFromFile.companyName, JobApplicationCreator.applicationCompanyName);
      expect(applicationFromFile.teamName, JobApplicationCreator.applicationTeamName);
      expect(applicationFromFile.applicationDate, JobApplicationCreator.applicationApplicationDate);
      expect(applicationFromFile.applicationDeadline, JobApplicationCreator.applicationDeadline);
      expect(applicationFromFile.jobDescription, JobApplicationCreator.applicationJobDescription);
      expect(applicationFromFile.applicationStatus, ApplicationStatus.IN_PROGRESS);
      expect(applicationFromFile.applicationContacts, JobApplicationCreator.applicationContacts);
      expect(applicationFromFile.location, JobApplicationCreator.location);
    });
  });

  test('testing writing & reading multiple job applications to file', () async{
    JobApplication application = JobApplicationCreator.getApplication();
    JobApplication application2 = JobApplicationCreator.getApplication();
    String qualifier = "unitTestWritingMultipleJobApp";
    List<JobApplication> applicationList = [application, application2];
    persistence.saveApplicationList(applicationList, qualifier);

    List<JobApplication> fromFile = await persistence.readApplicationList(qualifier);

    expect(fromFile.length, applicationList.length);

    fromFile.forEach((applicationFromFile) {
      expect(applicationFromFile.jobTitle, JobApplicationCreator.applicationTitle);
      expect(applicationFromFile.companyName, JobApplicationCreator.applicationCompanyName);
      expect(applicationFromFile.teamName, JobApplicationCreator.applicationTeamName);
      expect(applicationFromFile.applicationDate, JobApplicationCreator.applicationApplicationDate);
      expect(applicationFromFile.applicationDeadline, JobApplicationCreator.applicationDeadline);
      expect(applicationFromFile.jobDescription, JobApplicationCreator.applicationJobDescription);
      expect(applicationFromFile.applicationStatus, ApplicationStatus.IN_PROGRESS);
      expect(applicationFromFile.applicationContacts, JobApplicationCreator.applicationContacts);
      expect(applicationFromFile.location, JobApplicationCreator.location);
    });

  });
}
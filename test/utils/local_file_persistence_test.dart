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

  test('testing writing & reading job application to file', () async{
    JobApplication application = JobApplicationCreator.getApplication();
    String qualifier = "unitTestWritingJobApp";
    Map<String, dynamic> jsonMap = application.toJson();
    persistence.saveObject(jsonMap, qualifier);

    Map<String, dynamic> fileJsonMap = await persistence.getObject(qualifier);
    JobApplication appFromFile = JobApplication.fromJson(fileJsonMap);

    expect(application.jobTitle, appFromFile.jobTitle);
    expect(application.companyName, appFromFile.companyName);
    expect(application.teamName, appFromFile.teamName);
    expect(application.applicationDate, appFromFile.applicationDate);
    expect(application.applicationDeadline, appFromFile.applicationDeadline);
    expect(application.jobDescription, appFromFile.jobDescription);
    expect(application.applicationStatus, appFromFile.applicationStatus);
    expect(application.applicationContacts, appFromFile.applicationContacts);
    expect(application.location, appFromFile.location);
  });
}
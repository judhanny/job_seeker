
import 'package:job_seeker/models/job_application.dart';
import 'package:job_seeker/utils/web_sample_job_application_loader.dart';
import 'package:test/test.dart';


void main() {

  test('test fetching data from the internet', () async{
    WebSampleJobApplicationLoader webSampleJobApplicationLoader = new WebSampleJobApplicationLoader();
    List<JobApplication> jobApplications =  await webSampleJobApplicationLoader.getSampleApplications();
    expect(jobApplications.length, 6);
  });
}
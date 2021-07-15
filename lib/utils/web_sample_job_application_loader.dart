
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:job_seeker/models/job_application.dart';

class WebSampleJobApplicationLoader{

  static const int OK = 200;
  final String SAMPLES_URL = "https://api.jsonbin.io/b/60f05c510cd33f7437c910a0";

  Future<http.Response> _fetchSampleJobApplications() {
    return http.get(Uri.parse(SAMPLES_URL));
  }

  Future<List<JobApplication>> getSampleApplications() async{
    List<JobApplication> applications = [];
    http.Response response =  await _fetchSampleJobApplications();

    if(response.statusCode == OK){
      applications=(json.decode(response.body) as List).map((i) =>  JobApplication.fromJson(i)).toList();
    }
    else{
      print("NOT OK Response status code is $response.statusCode . Body is $response.body");
    }
    return applications;
  }
}
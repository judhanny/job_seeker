import 'package:flutter/material.dart';
import 'package:job_seeker/ui/home_page.dart';

import 'models/applications_by_company.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApplicationsByCompany companies = new ApplicationsByCompany({});

    return MaterialApp(
        title: 'Job Seeker - Application Organiser',
        home: HomePage(companies: companies),
    );
  }
}


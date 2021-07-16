import 'package:flutter/material.dart';
import 'package:job_seeker/ui/company_applications_page.dart';

import 'models/applications_by_company.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApplicationsByCompany companies = new ApplicationsByCompany({});

    return MaterialApp(
        title: 'Job Application Organiser',
        home: CompanyApplications(companies: companies),
    );
  }
}


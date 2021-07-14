import 'package:flutter/material.dart';
import 'package:job_seeker/utils/local_job_application_creator.dart';
import 'package:job_seeker/widgets/company_applications_page.dart';

import 'models/applications_by_company.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApplicationsByCompany companies = LocalJobApplicationCreator.createApplicationsByCompany(3, 4);

    return MaterialApp(
        title: 'Startup Name Generator',
        home: CompanyApplications(companies: companies),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:job_seeker/widgets/company_applications_widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Startup Name Generator',
        home: CompanyApplications(),
    );
  }
}


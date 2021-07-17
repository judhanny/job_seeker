
import 'package:flutter/material.dart';
import 'package:job_seeker/models/application_status.dart';
import 'package:job_seeker/models/applications_by_company.dart';
import 'package:job_seeker/models/job_application.dart';

import 'job_application_basic_details_form.dart';
import 'job_application_dates_form.dart';
import 'job_application_job_description_form.dart';

class NewJobApplicationPage extends StatefulWidget {
  final ApplicationsByCompany companies;
  final Function() notifyParent;

  NewJobApplicationPage(this.companies, this.notifyParent);

  @override
  NewJobApplicationPageState createState() {
    return NewJobApplicationPageState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class NewJobApplicationPageState extends State<NewJobApplicationPage> {
  JobApplication jobApplication = JobApplication.blankApplication();

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {

    List<Step> steps = [
    Step(
      title: Text('Basic Details'),
      content: JobApplicationBasicDetailsForm(jobApplication),
      state: currentStep == 0 ? StepState.editing : StepState.indexed,
      isActive: true,
    ),
    Step(
      title: Text('Dates'),
      content: JobApplicationDatesForm(jobApplication),
      state: currentStep == 1 ? StepState.editing : StepState.indexed,
      isActive: true,
    ),
      Step(
        title: Text('Job Description'),
        content: JobApplicationJobDescriptionForm(jobApplication),
        state:  StepState.complete,
        isActive: true,
      ),
    ];


    return Scaffold(
      appBar: AppBar(
        title: Text("New Job Application"),
      ),
      body: Container(
        child: Stepper(
          currentStep: this.currentStep,
          steps: steps,
          type: StepperType.horizontal,
          onStepTapped: (step) {
            setState(() {
              currentStep = step;
            });
          },
          onStepContinue: () {
            setState(() {
              if (currentStep < steps.length - 1) {
                if (currentStep == 0 &&
                    JobApplicationBasicDetailsFormState.formKey.currentState!.validate()) {
                  currentStep = currentStep + 1;
                } else if (currentStep == 1 &&
                    JobApplicationDatesFormState.formKey.currentState!.validate()) {
                  currentStep = currentStep + 1;
                }
              } else {
                currentStep = 0;

                if (jobApplication.isValid()) {
                  setState(() {
                    widget.companies.addJobApplication(jobApplication);
                    widget.notifyParent();
                    Navigator.of(context).pop(true);
                  });
                }
                else {
                  if (jobApplication.applicationStatus ==  ApplicationStatus.ERROR) {
                    String company = jobApplication.companyName;
                    String title = jobApplication.jobTitle;
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(
                            'Error adding new job application for  $company - $title')));
                  }
                }
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (currentStep > 0) {
                currentStep = currentStep - 1;
              } else {
                jobApplication.applicationStatus = ApplicationStatus.DELETE;
                Navigator.of(context).pop(true);
              }
            });
          },
        ),
      ),
    );

  }



}
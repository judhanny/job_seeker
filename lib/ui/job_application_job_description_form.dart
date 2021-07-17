

import 'package:flutter/material.dart';
import 'package:job_seeker/models/job_application.dart';

class JobApplicationJobDescriptionForm extends StatefulWidget {

  final JobApplication jobApplication;
  JobApplicationJobDescriptionForm(this.jobApplication);

  @override
  State<StatefulWidget> createState() {
    return JobApplicationJobDescriptionFormState();
  }
}

class JobApplicationJobDescriptionFormState extends State<JobApplicationJobDescriptionForm> {

  static final formKey = GlobalKey<FormState>();
  TextEditingController _jobDescriptionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _jobDescriptionController.text = widget.jobApplication.jobDescription;

    return Container(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
           SizedBox(height: 20),
              TextFormField(
                minLines: 5,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                controller: _jobDescriptionController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.inventory_outlined,
                    color: Colors.grey,
                  ),
                  labelText: 'Job Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onChanged: (value) { widget.jobApplication.jobDescription = value; },
              ),
            ],
          ),
        )
    );
  }

}
import 'package:flutter/material.dart';
import 'package:job_seeker/models/job_application.dart';

class JobApplicationBasicDetailsForm extends StatefulWidget {

  final JobApplication jobApplication;
  bool editable;
  JobApplicationBasicDetailsForm(this.jobApplication, this.editable);

  @override
  State<StatefulWidget> createState() {
    return JobApplicationBasicDetailsFormState();
  }
}

class JobApplicationBasicDetailsFormState extends State<JobApplicationBasicDetailsForm> {
  static final formKey = GlobalKey<FormState>();
  TextEditingController _companyNameController = new TextEditingController();
  TextEditingController _jobTitleController = new TextEditingController();
  TextEditingController _teamNameController = new TextEditingController();
  TextEditingController _locationController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _companyNameController.text = widget.jobApplication.companyName;
    _jobTitleController.text = widget.jobApplication.jobTitle;
    _teamNameController.text = widget.jobApplication.teamName;
    _locationController.text = widget.jobApplication.location;

    return Container(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                enabled: widget.editable,
                maxLines: 1,
                controller: _companyNameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.account_balance_outlined,
                    color: Colors.grey,
                  ),
                  labelText: 'Company Name*',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a company name';
                  }
                  widget.jobApplication.companyName = value;
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                enabled: widget.editable,
                  maxLines: 1,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    labelText: 'Job Title *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a job title';
                    }
                    widget.jobApplication.jobTitle = value;
                    return null;
                  },
                  controller: _jobTitleController),
              SizedBox(height: 20),
              TextFormField(
                  enabled: widget.editable,
                  maxLines: 1,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.group,
                      color: Colors.grey,
                    ),
                    labelText: 'Team Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  onChanged: (value) { widget.jobApplication.teamName = value; },
                  controller: _teamNameController),
              SizedBox(height: 20),
              TextFormField(
                  enabled: widget.editable,
                  maxLines: 1,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.add_location,
                      color: Colors.grey,
                    ),
                    labelText: 'Location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  onChanged: (value) { widget.jobApplication.location = value; },
                  controller: _locationController),
            ],
          ),
        ));
  }

}
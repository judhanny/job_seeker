import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:job_seeker/models/application_status.dart';
import 'package:job_seeker/models/job_application.dart';


class NewJobApplicationForm extends StatefulWidget {
  final JobApplication jobApplication;

  NewJobApplicationForm(this.jobApplication);

  @override
  NewJobApplicationFormState createState() {
    return NewJobApplicationFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class NewJobApplicationFormState extends State<NewJobApplicationForm> {

  //JobApplication _jobApplication = JobApplication.blankApplication();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  DateFormat _dateFormatter = DateFormat('dd-MMMM-yyyy');
  TextEditingController _applicationDateTextController = new TextEditingController();
  TextEditingController _applicationDeadlineTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    _applicationDateTextController.text = _dateFormatter.format(widget.jobApplication.applicationDate);
    _applicationDeadlineTextController.text = _dateFormatter.format(widget.jobApplication.applicationDeadline);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: "Company Name *"
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a company name';
              }
              widget.jobApplication.companyName = value;
              return null;
            }
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Job Title *"
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a job title';
              }
              widget.jobApplication.jobTitle = value;
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Team Name"
            ),
            onChanged: (value) { widget.jobApplication.teamName = value; },
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Location"
            ),
            onChanged: (value) { widget.jobApplication.location = value; },
          ),
          TextFormField(
              controller: _applicationDateTextController,
              decoration: InputDecoration(
                  labelText: "Application Date"
              ),
              onTap: () => _selectDateValue(context,_applicationDateTextController, true)
          ),
          TextFormField(
              controller: _applicationDeadlineTextController,
              decoration: InputDecoration(
                  labelText: "Application Deadline"
              ),
              validator: (value) {
                if (value != null && widget.jobApplication.applicationDate != null
                    && widget.jobApplication.applicationDeadline.isBefore(widget.jobApplication.applicationDate)) {
                  return 'Deadline cannot precede application date';
                }
                return null;
              },
              onTap: () => _selectDateValue(context,_applicationDeadlineTextController, false)

          ),
          Expanded(
            child:
            TextFormField( decoration: InputDecoration(
                labelText: "Job Description"
            ),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              onChanged: (value) { widget.jobApplication.jobDescription = value; },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget> [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snack bar. In the real world,
                          // you'd often call a server or save the information in a database.
                          //print(widget.jobApplication);
                          String company = widget.jobApplication.companyName;
                          String title = widget.jobApplication.jobTitle;

                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(
                              'Processing New Application for $company - $title')));
                          Navigator.of(context).pop(true);
                        }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    child: Text("Save"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.jobApplication.applicationStatus = ApplicationStatus.DELETE;
                      Navigator.of(context).pop(true);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    child: Text("Cancel"),
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }

  void _selectDateValue(BuildContext context, TextEditingController controller, bool isApplicationDate) async {
    DateTime? newSelectedDate = await _getSelectedDate();
    if(newSelectedDate != null) {

      String presentationDate = _dateFormatter.format(newSelectedDate);
      if(isApplicationDate) {
        widget.jobApplication.applicationDate = newSelectedDate;
        _applicationDateTextController.text = presentationDate;
      }
      else{
        widget.jobApplication.applicationDeadline = newSelectedDate;
        _applicationDeadlineTextController.text = presentationDate;
      }
    }
  }

  Future<DateTime?> _getSelectedDate() {
    DateTime initialDate = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: new DateTime(initialDate.year -2, initialDate.month, initialDate.day),
      lastDate: new DateTime(initialDate.year +2, initialDate.month, initialDate.day),
    );
  }
}


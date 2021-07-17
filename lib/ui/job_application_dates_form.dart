import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_seeker/models/job_application.dart';

class JobApplicationDatesForm extends StatefulWidget {

  final JobApplication jobApplication;
  JobApplicationDatesForm(this.jobApplication);

  @override
  State<StatefulWidget> createState() {
    return JobApplicationDatesFormState();
  }
}

class JobApplicationDatesFormState extends State<JobApplicationDatesForm> {
  static final formKey = GlobalKey<FormState>();
  DateFormat _dateFormatter = DateFormat('dd-MMMM-yyyy');
  TextEditingController _applicationDateTextController = new TextEditingController();
  TextEditingController _applicationDeadlineTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _applicationDateTextController.text = _dateFormatter.format(widget.jobApplication.applicationDate);
    _applicationDeadlineTextController.text = _dateFormatter.format(widget.jobApplication.applicationDeadline);

    return Container(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                maxLines: 1,
                controller: _applicationDateTextController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                  ),
                  labelText: 'Application Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onTap: () => _selectDateValue(context,_applicationDateTextController, true),
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLines: 1,
                controller: _applicationDeadlineTextController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                  ),
                  labelText: 'Application Deadline',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value != null && widget.jobApplication.applicationDate != null
                      && widget.jobApplication.applicationDeadline.isBefore(widget.jobApplication.applicationDate)) {
                    return 'Deadline cannot precede application date';
                  }
                  return null;
                },
                onTap: () => _selectDateValue(context,_applicationDeadlineTextController, false),
              ),
            ],
          ),
        )
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
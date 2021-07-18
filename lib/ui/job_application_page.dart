import 'package:flutter/material.dart';
import 'package:job_seeker/models/job_application.dart';
import 'package:timelines/timelines.dart';

import 'forms/job_application_basic_details_form.dart';
import 'forms/job_application_dates_form.dart';
import 'forms/job_application_job_description_form.dart';
import 'utils/colour_generator.dart';

class JobApplicationPage extends StatefulWidget {
  final JobApplication jobApplication;

  JobApplicationPage(this.jobApplication);

  @override
  JobApplicationPageState createState() {
    return JobApplicationPageState();
  }
}

class JobApplicationPageState extends State<JobApplicationPage>{
  ColourGenerator _colourGenerator = ColourGenerator();
  late Color _baseColor;

  @override
  Widget build(BuildContext context) {
    String title = widget.jobApplication.summaryDetails();
    _baseColor = _colourGenerator.getPastelColourForKey(title);
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Application Details"),
      ),
      body: _buildJobApplicationDisplay(),
    );
  }


  Widget _buildJobApplicationDisplay(){
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        _sectionHeader("Basic Details"),
        SizedBox(height: 10),
        _basicDetails(),
        SizedBox(height: 20),
        _sectionHeader("Dates"),
        SizedBox(height: 10),
        _jobDateFields(),
        SizedBox(height: 20),
        _sectionHeader("Job Description"),
        SizedBox(height: 10),
        _jobDescriptionDetails(),
        //_applicationTimeline(),
      ],
    );
  }

  Widget _sectionHeader(String title){
    return
        ListTile(
          title: Text(title , style: TextStyle(fontWeight: FontWeight.bold)),
        );
  }

  Widget _basicDetails(){
    return JobApplicationBasicDetailsForm(widget.jobApplication, false);
  }

  Widget _jobDateFields(){
    return JobApplicationDatesForm(widget.jobApplication, false);
  }

  Widget _jobDescriptionDetails(){

    return JobApplicationJobDescriptionForm(widget.jobApplication, false);
  }

  Widget _applicationTimeline(){
    Color widgetColor = _colourGenerator.darken(_baseColor);
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          border: Border.all(color: widgetColor)
      ),
      child:
      Column(
        children: [
          ListTile(
            tileColor: widgetColor,
            title: Text("Application Timeline"),
            subtitle: Text("Some work to do on customising timeline"),
          ),
          SizedBox(
            height: 150,
            child: Timeline.tileBuilder(
              theme: TimelineThemeData(color: widgetColor, direction: Axis.horizontal),
              builder: TimelineTileBuilder.fromStyle(
                contentsAlign: ContentsAlign.alternating,
                contentsBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text('Timeline Event $index'),
                ),
                itemCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
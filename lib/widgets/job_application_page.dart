import 'package:flutter/material.dart';
import 'package:job_seeker/models/job_application.dart';
import 'package:timelines/timelines.dart';

import 'colour_generator.dart';

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
        title: Text(title),
      ),
      body: _buildJobApplicationDisplay(),
    );
  }


  Widget _buildJobApplicationDisplay(){
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _basicDetails(),
        _jobDescriptionDetails(),
        _applicationTimeline(),
      ],
    );
  }

  Widget _basicDetails(){
    return ListTile(
      tileColor: _colourGenerator.darken(_baseColor, 40),
      leading: Icon(Icons.info_outline),
      title: Text(widget.jobApplication.companyName +" - " +widget.jobApplication.jobTitle ),
      subtitle: Text("Team: "+widget.jobApplication.teamName + " Location: " + widget.jobApplication.location),
    );
  }

  Widget _jobDescriptionDetails(){
    Color widgetColor = _colourGenerator.darken(_baseColor);
    return
      Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            border: Border.all(color: widgetColor)
        ),
        child: Column(
          children: [
            ListTile(
              tileColor: widgetColor,
              title: Text("Job Description"),
              subtitle: Text("Some work to do on scrolling"),
            ),
            Text( widget.jobApplication.jobDescription, maxLines: 7,),
          ],
        ),
      );
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
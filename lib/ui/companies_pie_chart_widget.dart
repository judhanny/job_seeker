
import 'package:flutter/material.dart';
import 'package:job_seeker/models/applications_by_company.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CompaniesPieChart extends StatefulWidget {
  final ApplicationsByCompany companies;

  CompaniesPieChart(this.companies);

  @override
  _CompaniesPieChartState createState() => _CompaniesPieChartState();
}

class _CompaniesPieChartState extends State<CompaniesPieChart>{

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  List<ChartData> getChartData(){
    List<ChartData> chartData = [];
    widget.companies.companiesMap.entries.forEach((element) {
        chartData.add(new ChartData(element.key + " applications", element.value.applications.length));
    });

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = getChartData();

    return Expanded(
      child: Scaffold(
        body: Center(
          child: Container(
            width: 200,
            height: 200,
            child: SfCircularChart(
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                PieSeries<ChartData, String>(
                    enableTooltip: true,
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.company,
                    yValueMapper: (ChartData data, _) => data.value,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ChartData {
  String company;
  int value;

  ChartData(this.company, this.value);

}
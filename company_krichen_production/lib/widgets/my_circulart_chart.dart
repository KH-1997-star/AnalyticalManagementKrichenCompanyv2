import 'package:company_krichen_production/models/final_product.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyCircularChart extends StatefulWidget {
  final List<FinalProduct> pf;
  MyCircularChart({this.pf});

  _MyCircularChartState createState() => _MyCircularChartState();
}

class _MyCircularChartState extends State<MyCircularChart> {
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(text: 'statistique de mélange crée par article'),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        DoughnutSeries<FinalProduct, String>(
          dataSource: widget.pf,
          xValueMapper: (FinalProduct data, _) => data.article,
          yValueMapper: (FinalProduct data, _) => data.melange,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          enableTooltip: true,
        )
      ],
    );
  }
}

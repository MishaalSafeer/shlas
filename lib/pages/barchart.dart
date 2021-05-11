import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';


class chartsss extends StatefulWidget {
  @override
  _charts createState() => _charts();
}
class _charts extends State<chartsss> {
  Color level = Colors.green;
  double calcRupee(){
    double rupee = 0;
    int totConsump = 0;
    SimpleBarChart.data.forEach((v) {
      totConsump = totConsump + v.power;
    });

    if (totConsump < 101) {
      rupee = 13.85 * totConsump;
      level = Colors.green;
    } else {
      if (totConsump < 301) {
        rupee = 15.86 * totConsump;
        level = Colors.yellow;
      } else {
        if (totConsump < 700) {
          rupee = 16.83 * totConsump;
          level = Colors.orange;
        } else {
          rupee = 18.54 * totConsump;
          level = Colors.red;
        }
      }
    }
    return rupee;
  }
  Widget chartContainer = Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: const <Widget>[
      Icon(
        Icons.battery_charging_full,
        color: Colors.white,
        size: 250.0,
//        semanticLabel: 'Text to announce in accessibility modes',
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('POWER CONSUMPTION', style: TextStyle(
              fontSize: 30,
              height: 1.0,
              fontWeight: FontWeight.bold,
              color: Colors.white),),
          centerTitle: true,
          backgroundColor: Colors.indigo,
        ),

        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 450,
                child: chartContainer,
              ),
              SizedBox(
                height: 7,
              ),
//              Padding(
//                padding: EdgeInsets.only(top: 10),
//                child: Text('VIEW POWER CONSUMPTION', style: TextStyle(fontSize: 25,color: Colors.yellowAccent),
//                ),
//              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.yellowAccent,
//                    child: Text('SHOW',style: TextStyle(color: Colors.white), fontSize: 15.0,),
                    child: Text(
                      "VIEW USAGE",
                      style: TextStyle(
                        fontSize: 25 ,color: Colors.black ,fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        chartContainer = SimpleBarChart.withSampleData();
                      });
                    },

                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),

                  ),

                ],
              ),

              SizedBox(height: 0),
              CircleAvatar(
                maxRadius: 35,
                child: Text(
                  "  PKR  \n ${calcRupee().toInt()}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.yellowAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Consumption {
  final String days;
  final int power;

  Consumption(this.days, this.power);
}
class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,

      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(

            // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 15, // size in Pts.
                  color: charts.MaterialPalette.white),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.white))),

      /// Assign a custom style for the measure axis.
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(

            // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 18, // size in Pts.
                  color: charts.MaterialPalette.white),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.white))),

    );

  }
  static var data = [
    new Consumption('1st WEEK', 25),
    new Consumption('2nd WEEK', 70),
    new Consumption('3rd WEEK', 100),
    new Consumption('4th WEEK', 75),
  ];

  /// Create one series with sample hard coded data.
  static List<charts.Series<Consumption, String>> _createSampleData() {


    return [
      new charts.Series<Consumption, String>(
        id: 'power',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Consumption sales, _) => sales.days,
        measureFn: (Consumption sales, _) => sales.power,
        data: data,
      )
    ];
  }
}
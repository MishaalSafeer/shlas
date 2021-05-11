import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class slider extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('SCHEUDLE')),
          backgroundColor: Colors.blue[800],
        ),
        backgroundColor: Colors.black,
        body: SliderContainer(),
      ),
    );
  }
}

class ScheduleSwitchIcon extends StatelessWidget {
  final String label;
  final MaterialColor col;

  ScheduleSwitchIcon(this.label, this.col);

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.lightbulb_outline,
          color: col,
          size: 50.0,
        ),
        SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700]),
        )
      ],
    );
  }
}

class SliderContainer extends StatefulWidget {
  @override
  _SliderContainerState createState() => _SliderContainerState();
}

class _SliderContainerState extends State<SliderContainer> {
  static double _minVal = 0.0;
  static double _maxVal = 24.0;
  String dropDownVal = 'Bedroom';

  void makeRoom(List<int> l) {
    buildRowList(l);
  }

  //holds room along with Switch IDs
  static var roomSwitchList = [
    {
      'Room': 'Kitchen',
      'Switches': [1, 8]
    },
    {
      'Room': 'Living Room',
      'Switches': [6, 7]
    },
    {
      'Room': 'Bedroom',
      'Switches': [3, 4, 5, 2]
    }
  ];

  //this will hold switchNames, IDs alongwith their schedules
  //[{fan:{6: 1, 8: 0, 17: 1, 23: 0}}, {light: {}}]
  //keys represent hour of the day, corresponding values represent the state at that hour

  static var listOfSchedules = [
    {
      'ID': 1,
      'Name': 'Light',
      'Timing': {6: 1, 8: 0, 17: 1, 23: 0}
    },
    {
      'ID': 2,
      'Name': 'Night Bulb',
      'Timing': {6: 0, 23: 1}
    },
    {
      'ID': 3,
      'Name': 'Light',
      'Timing': {6: 1, 8: 0, 20: 1, 23: 0}
    },
    {
      'ID': 4,
      'Name': 'AC',
      'Timing': {6: 1, 8: 0, 17: 1, 23: 0}
    },
    {
      'ID': 5,
      'Name': 'FAN',
      'Timing': {6: 0, 23: 1}
    },
    {
      'ID': 6,
      'Name': 'FAN',
      'Timing': {6: 0, 23: 1}
    },
    {
      'ID': 7,
      'Name': 'Energy Saver',
      'Timing': {6: 0, 23: 1}
    },
    {
      'ID': 8,
      'Name': 'Exhaust',
      'Timing': {6: 1, 8: 0, 17: 1, 23: 0}
    }
  ];

  int count = 0;
  double vals = 0.0;
  List<int> lRoomSwitch = roomSwitchList[2]['Switches'];

  String sliderTime(double x) {
    int hh = x.toInt();
    var t = DateTime(2020, 1, 1, hh, 0);
    var newFormat = DateFormat('jm');
    String newT = newFormat.format(t);
    //print(newT);
    return newT;
  }

  MaterialColor colorSelecter(double x, Map sc) {
    var times = sc.keys;
    var lesser = times.where((e) => e <= x).toList()
      ..sort(); //List of the lesser values
    //print(lesser.last);
    var greater = times.where((e) => e >= x).toList()
      ..sort(); //List of the greater values
    if (lesser.isNotEmpty) {
      if (sc[lesser.last] == 1) {
        return Colors.green;
      } else {
        return Colors.pink;
      }
    } else {
      if (sc[greater.first] == 1) {
        return Colors.pink;
      } else {
        return Colors.green;
      }
    }
  }

  List<Widget> buildRowList(var listRoomSwitch) {
    List<Widget> l = [];
    for (int i = 0; i < ((listRoomSwitch.length / 3).ceil()); i++) {
      l.add(SizedBox(height: 10));
      l.add(buildRow(listRoomSwitch));
      l.add(SizedBox(height: 10));
      count = count + 3;
    }
    return l;
  }

  Row buildRow(var listRoomSwitch) {
    List<Widget> l = [];
    for (int i = count; i < count + 3; i++) {
      if (i < listRoomSwitch.length) {
        int room = listRoomSwitch[i];
        var x = (listOfSchedules.where((test) {
          return test['ID'] == room;
        })).first;
        l.add(ScheduleSwitchIcon(x['Name'], colorSelecter(vals, x['Timing'])));
      }
    }
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: l);
  }

  //body of the slider page
  @override
  Widget build(BuildContext context) {
    count = 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(20, 15)),
              color: Colors.blueGrey[800]),
          padding: EdgeInsets.all(10),
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.grey.shade900),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue[500],
                ),
                isDense: true,
                focusColor: Colors.black,
                value: dropDownVal,
                items: <String>['Bedroom', 'Living Room','Kitchen']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          color: Colors.blue[500],
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    List<int> temp = ((roomSwitchList.where((test) {
                      return test['Room'] == val;
                    })).first)['Switches'];
                    lRoomSwitch = temp;
                    makeRoom(temp);
                    dropDownVal = val;
                  });
                },
              ),
            ),
          ),
        ),
        //container that will show all switches
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
              border: Border.all(color: Colors.blue[700])),
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(10),
          //each row will show at most 3 switches
          child: Column(
            children: buildRowList(lRoomSwitch),
          ),
        ),
        //SizedBox(height: 30),
        //this column holds the slider and its labeller
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),gradient: LinearGradient(colors: [Colors.blue[900], Colors.orange[700], Colors.blue[900]])),
              child: SliderTheme(
                data: SliderThemeData(trackHeight: 10, activeTrackColor: Colors.blue[400], inactiveTrackColor: Colors.black),
                child: Slider(
                  min: _minVal,
                  max: _maxVal,
                  divisions: 24,
                  label: sliderTime(vals),
                  value: vals,
                  onChanged: (newVal) {
                    setState(() {
                      vals = newVal;
                    });
                  },
                ),
              ),
            ),
            //SizedBox(height: 5),
            Text('12am           6am          12pm            6pm        12am',
                style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600]))
          ],
        ),
      ],
    );
  }
}

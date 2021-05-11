import 'package:flutter/material.dart';
import 'package:auth/pages/login_page.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/foundation.dart';
//import 'package:bar_wow/subscriber_series.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:auth/pages/MainDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth/pages/barchart.dart';
import 'package:awesome_fonts/awesome_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auth/pages/buttonpage.dart';
extension ColorUtils on Color{
  Color mix(Color another,double amount){
    return Color.lerp(this,another,amount);
  }
}


class SMConationer1 extends StatefulWidget{
  final Widget child;
  final Color color;
  final double bevel;
  final Offset blurOffset;
  final bool shapes;
  final EdgeInsets padding;
  String ide;
  String c;

  SMConationer1({Key key, this.child,this.color, this.bevel=10.0, this.shapes, this.padding,this.ide,this.c}):
        this.blurOffset=Offset(bevel/2, bevel/2 ),super(key:key);
  @override
  _SMConationer1 createState() => _SMConationer1(userid: ide);
}
class _SMConationer1 extends State<SMConationer1>{
  _SMConationer1({this.userid});
  String userid="";
  bool _isPressed=false;
  final FirebaseAuth _auth=FirebaseAuth.instance;

  void _onTap(PointerDownEvent event){

    print(widget.c);
    //if(widget.c=='bathroom') {
      setState(() {
        print(userid);
        _isPressed=true;
          //Navigator.push(context, MaterialPageRoute(builder: (context) => bed(uid:userid,c:widget.c)),
        Navigator.push(context, MaterialPageRoute(builder: (context) => bed(uid:widget.ide,c:widget.c)),
      );

    });



  }

  void _onTapUp(PointerUpEvent event){
    setState(() {
      _isPressed=false;
    });
  }
  @override
  Widget build(BuildContext context){
    final color= this.widget.color ?? Theme.of(context).backgroundColor;
    return Listener(
        onPointerDown: _onTap,
        onPointerUp: _onTapUp,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              shape: widget.shapes ? widget.padding:BoxShape.circle,
              borderRadius:widget.shapes ? BorderRadius.circular(widget.bevel) : null,
              color: Colors.red,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _isPressed ? color: color.mix(Colors.white, 0.1),
                    _isPressed ? color.mix(Colors.black, 0.05): color,
                    _isPressed ? color.mix(Colors.black, 0.05): color,
                    color.mix(Colors.blue, _isPressed ? 0.2: 0.5)
                  ],
                  stops: [
                    0.0,
                    0.3,
                    0.6,
                    1.0,
                  ]
              ),
              boxShadow: _isPressed
                  ? null
                  :[
                BoxShadow(
                  blurRadius: widget.bevel,
                  offset: -widget.blurOffset,
                  color: color.mix(Colors.blue, 0.6),
                ),
                BoxShadow(
                  blurRadius: widget.bevel,
                  offset: widget.blurOffset,
                  color: color.mix(Colors.blue, 0.3),
                ),
              ]
          ),
          child: widget.child,
        )

    );
  }
}
class SMConationer2 extends StatefulWidget{
  final Widget child;
  final Color color;
  final double bevel;
  final Offset blurOffset;
  final bool shapes;
  final EdgeInsets padding;
  String c;
  String id;

  SMConationer2({Key key, this.child,this.color, this.bevel=10.0, this.shapes, this.padding,this.c,this.id}):
        this.blurOffset=Offset(bevel/2, bevel/2 ),super(key:key);
  @override
  _SMConationer2 createState() => _SMConationer2();
}
class _SMConationer2 extends State<SMConationer2>{
  bool _isPressed=false;
  void _onTap(PointerDownEvent event){
    setState(() {
      _isPressed=true;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>chartsss()),
      );
    });
  }
  void _onTapUp(PointerUpEvent event){
    setState(() {
      _isPressed=false;
    });
  }
  @override
  Widget build(BuildContext context){
    final color= this.widget.color ?? Theme.of(context).backgroundColor;
    return Listener(
        onPointerDown: _onTap,
        onPointerUp: _onTapUp,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              shape: widget.shapes ? widget.padding:BoxShape.circle,
              borderRadius:widget.shapes ? BorderRadius.circular(widget.bevel) : null,
              color: Colors.grey.shade200,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _isPressed ? color: color.mix(Colors.white, 0.1),
                    _isPressed ? color.mix(Colors.black, 0.05): color,
                    _isPressed ? color.mix(Colors.black, 0.05): color,
                    color.mix(Colors.blue, _isPressed ? 0.2: 0.5)
                  ],
                  stops: [
                    0.0,
                    0.3,
                    0.6,
                    1.0,
                  ]
              ),
              boxShadow: _isPressed
                  ? null
                  :[
                BoxShadow(
                  blurRadius: widget.bevel,
                  offset: -widget.blurOffset,
                  color: color.mix(Colors.blue, 0.6),
                ),
                BoxShadow(
                  blurRadius: widget.bevel,
                  offset: widget.blurOffset,
                  color: color.mix(Colors.blue, 0.3),
                ),
              ]
          ),
          child: widget.child,
        )

    );
  }
}
class SMConationer3 extends StatefulWidget{
  final Widget child;
  final Color color;
  final double bevel;
  final Offset blurOffset;
  final bool shapes;
  final EdgeInsets padding;
  String id;
  String c;

  SMConationer3({Key key, this.child,this.color, this.bevel=10.0, this.shapes, this.padding,this.id,this.c}):
        this.blurOffset=Offset(bevel/2, bevel/2 ),super(key:key);
  @override
  _SMConationer3 createState() => _SMConationer3();
}
class _SMConationer3 extends State<SMConationer3>{
  bool _isPressed=false;
  void _onTap(PointerDownEvent event){
    setState(() {
      _isPressed=true;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => lstviw()),
      );
    });
  }

  void _onTapUp(PointerUpEvent event){
    setState(() {
      _isPressed=false;
    });
  }
  @override
  Widget build(BuildContext context){
    final color= this.widget.color ?? Theme.of(context).backgroundColor;
    return Listener(
        onPointerDown: _onTap,
        onPointerUp: _onTapUp,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              shape: widget.shapes ? widget.padding:BoxShape.circle,
              borderRadius:widget.shapes ? BorderRadius.circular(widget.bevel) : null,
              color: Colors.grey.shade200,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _isPressed ? color: color.mix(Colors.white, 0.1),
                    _isPressed ? color.mix(Colors.black, 0.05): color,
                    _isPressed ? color.mix(Colors.black, 0.05): color,
                    color.mix(Colors.blue, _isPressed ? 0.2: 0.5)
                  ],
                  stops: [
                    0.0,
                    0.3,
                    0.6,
                    1.0,
                  ]
              ),
              boxShadow: _isPressed
                  ? null
                  :[
                BoxShadow(
                  blurRadius: widget.bevel,
                  offset: -widget.blurOffset,
                  color: color.mix(Colors.blue, 0.6),
                ),
                BoxShadow(
                  blurRadius: widget.bevel,
                  offset: widget.blurOffset,
                  color: color.mix(Colors.blue, 0.3),
                ),
              ]
          ),
          child: widget.child,
        )

    );
  }
}

























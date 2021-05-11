import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



class Scheduler extends StatefulWidget {
  String uid;
  String swid;
  String swid1;
  String swid2;
  String swid3;
  String name;

  Scheduler({Key key,this.uid,this.swid,this.swid1,this.swid2,this.swid3,this.name}): super(key: key);
  @override
  _Scheduler createState() =>_Scheduler ();
}

class _Scheduler extends State<Scheduler> {

  Timer myTimer;
  final fb = FirebaseDatabase.instance.reference().child("Weather");
  final durr = const Duration(seconds: 60);
  var yr = "2018";
  var mon = DateTime.now().month.toString();
  var day = DateTime.now().day.toString();
  var hr = DateTime.now().hour;
  var x;
  var x2;
  var x3;
  var x4;
  final databasereference2=FirebaseDatabase.instance.reference();
  //there are 4 functions for 4 switches
  //these functions contain if/else conditons to determine switches state

  void fetchDat(Function perform, {var c = 0}) {
    print('CALLED fetchDat');
    var res = '';
    var res1 = '';
    Map<dynamic, dynamic> vals;
    try {
      var h = (c + hr).toString();
      print(h);
      databasereference2
          .child(yr)
          .child(mon)
          .child(day)
          .child(h)
          .once()
          .then((DataSnapshot snapshot) {
        vals = snapshot.value;
        if (vals != null) {
          res = (vals.values).first['Temp'];
          res1 = (vals.values).first['Visibility'];
          print("The RECEIVED TEMP IS: ${res}");
          print("The RECEIVED VIS IS: ${res1}");
          if (res != null) {
            perform(double.parse(res), double.parse(res1));
          }
        } else {
          print("Vals was NULL");
          fetchDat(perform, c: c - 1);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void decTree() {
    fetchDat(condFan);
    fetchDat(condAC);
    fetchDat(condNightLight);
    fetchDat(condLight);
  }

  void condAC(double temp, double visibility) {
    print('CALLED condAC');
    var time = ((DateTime.now().hour) * 60) + (DateTime.now().minute);
    try {
      setState(() {
        if (temp <= 22.5) {
          //Switch OFF
          x='off';
          databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set('off');

        } else {
          if (time <= 253.7) {
            //Switch ON
            x='on';
            databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set('on');

          } else {
            if (time <= 789.7) {
              //Switch OFF
              x='off';
              databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set('off');
            } else {
              if (time <= 1037) {
                //Switch ON
                x='on';
                databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set('on');
              } else {
                if (time <= 1277.3) {
                  //Switch OFF
                  x='off';
                  databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set('off');
                } else {
                  //Switch ON
                  x='on';
                  databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set('on');
                }
              }
            }
          }
        }
        print('CHANGED AC');
        //databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set(x);
      });
    } catch (e) {
      print(e);
    }
  }

  void condNightLight(double temp, double visibility) {
    print('CALLED condNightLight');
    var time = ((DateTime.now().hour) * 60) + (DateTime.now().minute);
    try {
      setState(() {
        if (time <= 253.94) {
          //Switch ON
          x2='on';
          databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid1).set('on');
        } else {
          if (time <= 1270.52) {
            if (time <= 538.39) {
              if (temp <= 16.50) {
                //Switch ON
                x2='on';
                databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid1).set('on');
              } else {
                //switch OFF
                x2='off';
                databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid1).set('off');
              }
            } else {
              //switch OFF
              x2='off';
              databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid1).set('off');
            }
          } else {
            if (temp <= 17.50) {
              if (time <= 1354.96) {
                if (visibility <= 1012.50) {
                  //Switch ON
                  x2='on';
                  databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid1).set('on');
                } else {
                  //switch OFF
                  x2='off';
                  databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid1).set('off');
                }
              } else {
                //Switch ON
                x2='on';
                databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid1).set('on');
              }
            } else {
              //Switch ON
              x2='on';
              databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid1).set('on');
            }
          }
        }
        print('CHANGED NIGHTLIGHT');
        //databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set(x2);
      });
    } catch (e) {
      print(e);
    }
  }

  void condLight(double temp, double visibility) {
    print('CALLED condLight');
    var time = ((DateTime.now().hour) * 60) + (DateTime.now().minute);
    try {
      setState(() {
        if (time <= 254.68) {
          //switch OFF
          x3='off';
          databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('off');
        } else {
          if (time <= 439.15) {
            if (temp <= 14.50) {
              //switch OFF
              //x3='on';
              databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('off');
            } else {
              if (time <= 309.39) {
                if (visibility <= 1004.50) {
                  if (visibility <= 1000.50) {
                    //Switch ON
                    x3='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('on');
                  } else {
                    //Switch ON
                    x3='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('on');
                  }
                } else {
                  //switch OFF
                  x3='off';
                  databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('off');
                }
              } else {
                if (temp <= 16.50) {
                  if (visibility <= 1013.00) {
                    if (time <= 344.08) {
                      //switch OFF
                      x3='off';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('off');
                    } else {
                      //Switch ON
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('on');
                    }
                  } else {
                    //switch OFF
                    x3='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('off');
                  }
                } else {
                  //Switch ON
                  x3='on';
                  databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('on');
                }
              }
            }
          } else {
            if (time <= 1016.29) {
              if (time <= 820.96) {
                if (time <= 570.03) {
                  if (time <= 465.92) {
                    if (temp <= 14.50) {
                      //switch OFF
                      x3='off';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('off');
                    } else {
                      //Switch ON
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set('on');
                    }
                  } else {
                    //switch OFF
                    x3='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set('off');
                  }
                } else {
                  if (time <= 747.37) {
                    if (temp <= 18.50) {
                      //Switch ON
                      x3 = 'on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('on');
                    } else {
                      //switch OFF
                      x3='off';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('off');
                    }
                  } else {
                    if (visibility <= 1006.50) {
                      //Switch ON
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('on');
                    } else {
                      //switch OFF
                      x='off';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('off');
                    }
                  }
                }
              } else {
                if (time <= 923.14) {
                  if (time <= 832.44) {
                    //switch OFF
                    x3='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('off');
                  } else {
                    //switch OFF
                    x3='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('off');
                  }
                } else {
                  if (temp <= 24.50) {
                    //Switch ON
                    x3='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('on');
                  } else {
                    //switch OFF
                    x3='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('off');
                  }
                }
              }
            } else {
              if (time <= 1275.89) {
                if (time <= 1052.58) {
                  if (temp <= 23.50) {
                    //Switch ON
                    x3='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('on');
                  } else {
                    if (time <= 1032.33) {
                      //switch OFF
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('on');
                    } else {
                      //Switch ON
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('on');
                    }
                  }
                } else {
                  if (time <= 1273.88) {
                    //Switch ON
                    x3='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('on');
                  } else {
                    if (time <= 1275.18) {
                      //switch OFF
                      x3='off';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('off');
                    } else {
                      //Switch ON
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('on');
                    }
                  }
                }
              } else {
                if (temp <= 16.50) {
                  if (time <= 1391.12) {
                    if (temp <= 13.50) {
                      //Switch ON
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('on');
                    } else {
                      //Switch ON
                      x3='on';
                      databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('on');
                    }
                  } else {
                    //switch OFF
                   x3='off';
                   databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('off');
                  }
                } else {
                  if (time <= 1293.06) {
                    //Switch ON
                    x3='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('on');
                  } else {
                    //switch OFF
                    x3='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid2).set('off');
                  }
                }
              }
            }
          }
        }
        print('CHANGED LIGHT');
        //databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set(x3);
      });
    } catch (e) {
      print(e);
    }
  }

  void condFan(double temp, double visibility) {
    print('CALLED condFan');
    var time = ((DateTime.now().hour) * 60) + (DateTime.now().minute);
    try {
      setState(() {
        if (temp <= 21.50) {
          //switch OFF
          x4='off';
          databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid3).set('off');
        } else {
          if (time <= 254.52) {
            //switch OFF
            x4='off';
            databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid3).set('off');
          } else {
            if (time <= 433.95) {
              if (time <= 259.73) {
                //switch OFF
                x4='off';
                databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid3).set('off');
              } else {
                //Switch ON
                x4='on';
                databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid3).set('on');
              }
            } else {
              if (time <= 734.91) {
                if (time <= 462.11) {
                  //Switch ON
                  x4='on'; databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid3).set('on');
                } else {
                  //switch OFF
                  x4='off';
                  databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid3).set('off');
                }
              } else {
                if (time <= 820.87) {
                  if (time <= 745.93) {
                    //switch OFF
                    x4='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid3).set('off');
                  } else {
                    //Switch ON
                    x4='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid3).set('on');
                  }
                } else {
                  if (time <= 1037.24) {
                    //switch OFF
                    x4='off';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid3).set('off');
                  } else {
                    //Switch ON
                    x4='on';
                    databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid3).set('on');
                  }
                }
              }
            }
          }
          print('CHANGED FAN');
          //databasereference2.child('users').child(widget.uid).child('Live Status').child(widget.name).child(widget.swid).set(x4);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      decTree();
      myTimer = Timer.periodic(durr, (Timer t) => decTree());
    });

  }

  @override
  void dispose() {
    myTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

  }
}

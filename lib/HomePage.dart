import 'dart:ui';
import 'package:expenses_app/MyChart.dart';
import 'package:expenses_app/MyList.dart';
import 'package:expenses_app/purchaseInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

var Mn = 0.0, Te = 0.0, Wd = 0.0, Tu = 0.0, Fr = 0.0, St = 0.0, Sn = 0.0;
int index = -1;

class _HomePageState extends State<HomePage> {
  List<PurchaseInfo> list =
      []; // to be able to work with app, add new expenses only by UI buttons!
  final textEditingControllerTitle = TextEditingController();
  final textEditingControllerPrice = TextEditingController();
  DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    print(index);
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 39, 67, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(41, 39, 67, 1),
        title: Text("Personal Expenses"),
        actions: <Widget>[
          IconButton(
            highlightColor: Color.fromRGBO(19, 24, 43, 1),
            icon: Icon(Icons.add),
            onPressed: () {
              _modalBottomPage();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: <Widget>[
            BarChartSample3(list: list),
            SizedBox(
              height: 15,
            ),
            MyList(list),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 7,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _modalBottomPage(),
        backgroundColor: Color.fromRGBO(103, 89, 210, 1),
      ),
    );
  }

  void _modalBottomPage() {
    showModalBottomSheet(
        context: context,
        builder: (
          context,
        ) {
          return Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Color.fromRGBO(41, 39, 67, 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      hintText: "Product Name",
                      fillColor: Color.fromRGBO(41, 39, 67, 1),
                      filled: true),
                  cursorColor: Colors.white,
                  controller: textEditingControllerTitle,
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelStyle: new TextStyle(color: Colors.white),
                        hintText: "Price",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        fillColor: Color.fromRGBO(41, 39, 67, 1),
                        filled: true),
                    cursorColor: Colors.white,
                    controller: textEditingControllerPrice),
                SizedBox(
                  height: 37,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((selectedData) {
                          setState(() {
                            dateTime = selectedData;
                          });
                        });
                      },
                      child: Text(
                        "Choose date",
                        style: TextStyle(
                            color: Color.fromRGBO(92, 69, 230, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    RaisedButton(
                      color: Color.fromRGBO(92, 69, 230, 1),
                      onPressed: () {
                        _addTransmission();
                        setState(() {
                          index = index + 1;
                        });
                        _cases(index);
                      },
                      child: Text(
                        "Add Transaction",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  void _addTransmission() {
    if (double.parse(textEditingControllerPrice.text) > 0 &&
        textEditingControllerTitle != null &&
        textEditingControllerTitle.text != "" &&
        dateTime != null) {
      try {
        setState(() {
          list.add(PurchaseInfo(
              title: textEditingControllerTitle.text,
              price: double.parse(textEditingControllerPrice.text),
              date: dateTime));
        });
      } catch (e) {
        print(e);
      }
      textEditingControllerTitle.text = "";
      textEditingControllerPrice.text = "";
      dateTime = null;
    } else {}
  }

  void _cases(i) {
    setState(() {
      switch (DateFormat('EEEE').format(list[i].date).toString()) {
        case 'Monday':
          Mn = Mn + list[i].price;
          break;
        case 'Tuesday':
          Te = Te + list[i].price;
          break;
        case 'Wednesday':
          Wd = Wd + list[i].price;
          break;
        case 'Thursday':
          Tu = Tu + list[i].price;
          break;
        case 'Friday':
          Fr = Fr + list[i].price;
          break;
        case 'Saturday':
          St = St + list[i].price;
          break;
        case 'Sunday':
          Sn = Sn + list[i].price;
          break;
        default:
          break;
      }
    });
  }
}

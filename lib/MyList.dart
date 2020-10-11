import 'package:expenses_app/purchaseInfo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenses_app/HomePage.dart';

class MyList extends StatefulWidget {
  final List<PurchaseInfo> list;
  MyList(this.list);
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: ScrollController(),
      shrinkWrap: true,
      itemCount: widget.list.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, i) {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 7),
          height: 75,
          child: Card(
            color: Color.fromRGBO(67, 63, 104, 1),
            elevation: 5,
            child: ListTile(
              title: Text(
                widget.list[i].title,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                DateFormat('yMd').format(widget.list[i].date).toString(),
                style: TextStyle(color: Colors.white),
              ),
              leading: CircleAvatar(
                backgroundColor: Color.fromRGBO(103, 89, 210, 1),
                child: FittedBox(
                  child: Text("\$" + widget.list[i].price.toString(),
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red[400],
                onPressed: () => _deleteElement(i),
              ),
            ),
          ),
        );
      },
    );
  }

  void _deleteElement(i) {
    setState(() {
      switch (DateFormat('EEEE').format(widget.list[i].date).toString()) {
        case 'Monday':
          Mn = Mn - widget.list[i].price;
          break;
        case 'Tuesday':
          Te = Te - widget.list[i].price;
          break;
        case 'Wednesday':
          Wd = Wd - widget.list[i].price;
          break;
        case 'Thursday':
          Tu = Tu - widget.list[i].price;
          break;
        case 'Friday':
          Fr = Fr - widget.list[i].price;
          break;
        case 'Saturday':
          St = St - widget.list[i].price;
          break;
        case 'Sunday':
          Sn = Sn - widget.list[i].price;
          break;
        default:
          break;
      }
      widget.list.removeAt(i);
      index = index - 1;
    });
  }
}

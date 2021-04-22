import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportList extends StatelessWidget {
  final List<Report> report;

  ReportList(this.report);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0,10,0,10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.pink,
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text(
                      '\$${report[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              trailing: Text(
                DateFormat.yMMMd().format(report[index].date),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: report.length,
    );
  }
}

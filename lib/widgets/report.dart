import 'package:expenses/models/dbHelper.dart';
import 'package:expenses/models/service.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/report_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<Report> _reportList = [];

  DateTime _selectFromDate;
  DateTime _selectToDate;
  double totalAmount = 0;

  // --- function --- //
  void _pressDatePickerFromDate(String typeDate) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        typeDate == 'FROM' ? _selectFromDate = value : _selectToDate = value;
      });
    });
  }

  Future<void> _pressFilter() async {
    if (_selectFromDate == null || _selectToDate == null) return;

    String fromDate =
        Service.getDateStringFormat(_selectFromDate, 'yyyy-MM-dd HH:mm:ss');
    String toDate =
        Service.getDateStringFormat(_selectToDate, 'yyyy-MM-dd HH:mm:ss');

    String query =
        "SELECT sum(amount) as 'Amount',date from expense WHERE date >=" +
            "'$fromDate'";
    query += " AND date <= " + "'$toDate'";
    query += " GROUP BY date";

    final dataList = await DBHelper.db_get(query);

    setState(() {
      _reportList = dataList
          .map(
            (item) => Report(
              amount: item['Amount'],
              date: Service.convertDateTime(item['date']),
            ),
          )
          .toList();

      totalAmount = 0;
      for (int i = 0; i < _reportList.length; i++)
        totalAmount += _reportList[i].amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final txListReportWidget = Container(
      height: Service.getContextHeight(context, 0.7),
      child: ReportList(_reportList),
    );
    return Center(
        child: Container(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          Container(
            height: 30,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectFromDate == null
                        ? 'From Date Chosen!'
                        : 'From : ${DateFormat.yMd().format(_selectFromDate)}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    _pressDatePickerFromDate('FROM');
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectToDate == null
                        ? 'To Date Chosen!'
                        : 'To      : ${DateFormat.yMd().format(_selectToDate)}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    _pressDatePickerFromDate('TO');
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            child: Text(
              'Filter',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            onPressed: () {
              _pressFilter();
            },
          ),
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Total Amount : ',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Text(
                  '\$ $totalAmount',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              txListReportWidget,
            ],
          ),
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'models/dbHelper.dart';
import 'models/service.dart';
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'models/transaction.dart';



class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _userTransactions = [];

 @override
  void initState() {   
    super.initState();   
    getDateExpense();
  }

  Future<void> getDateExpense() async {
    
    // final dataList = await DBHelper.getData('expense');
    final dataList = await DBHelper.db_get('SELECT * FROM expense ORDER BY id DESC LIMIT 30');
    
    setState(() {
      _userTransactions = dataList
        .map(
          (item) => Transaction(
                id: item['id'],
                title: item['title'],
                amount: item['amount'],
                date: Service.convertDateTime(item['date']),
              ),
        )
        .toList();  
    });
  }


  List<Transaction> get _recentTransactions {

    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days:7),)
        );
    }).toList();   
  }

  bool _showChart = false;

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      // add new Object 
     // _userTransactions.add(newTx);
      _userTransactions.insert(0, newTx);
    });
   
   // -------- Insert to database ---------- //
    String id = DateTime.now().toString();
    String date = Service.getDateStringFormat(chosenDate, 'yyyy-MM-dd HH:mm:ss');
    String sql = "insert into expense VALUES('$id','$txTitle',$txAmount,'$date');";
    DBHelper.db_execute(sql);
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id){
    setState(() {
        _userTransactions.removeWhere((tx) => tx.id == id );
        String sql = "DELETE FROM expense where id = '$id'";
        DBHelper.db_delete(sql);
        print(sql);
    });
  }


  @override
  Widget build(BuildContext context) {

    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final txListWidget =  Container(
             height: Service.getContextHeight(context, 0.7),
             child:  TransactionList(_userTransactions,_deleteTransaction),
           ) ;
    return Scaffold(   
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[    
           if(isLandscape)
              Row(
                mainAxisAlignment : MainAxisAlignment.center,
                children: <Widget>[            
                Text('Show Chart'),
                  Switch(value: _showChart, 
                          onChanged: (value) {
                            setState(() {
                              _showChart = value;
                            });
                          }
                        ),
              ],
              ),
          if(!isLandscape)
          Container(
             height: Service.getContextHeight(context,0.3),
             child:  Chart(_recentTransactions),
           ) , 
           
          if(!isLandscape) txListWidget,

          if(isLandscape)
          _showChart ?
            Container(
             height: Service.getContextHeight(context,0.8),
             child:  Chart(_recentTransactions),
           ) : txListWidget ,                                         
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}

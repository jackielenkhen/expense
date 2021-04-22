import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(  
            elevation: 5,          
            margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 6),
            child:  ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.pink,
              radius: 30,              
              child: Padding(
                padding: EdgeInsets.all(6),
                child:  FittedBox(
                  child:  Text('\$${transactions[index].amount.toStringAsFixed(2)}',style: TextStyle(
                     fontWeight: FontWeight.bold,                  
                     color: Colors.white,
                    ),
                    ) ,
              ),
              ),
              ),
              title: Text(
                transactions[index].title,
                style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date),
                style: TextStyle(
                color: Colors.grey,
                ),
                ),
                trailing: MediaQuery.of(context).size.width > 460 ?
                 FlatButton.icon( onPressed : () =>  deleteTx(transactions[index].id),
                  icon: Icon(Icons.delete), 
                  label: Text('Delete'),
                  textColor: Colors.red,
                  )
                :IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  onPressed : () =>  deleteTx(transactions[index].id),
                        
                  ),

          ) ,
          );
        },
        itemCount: transactions.length,     
    );   
  }
}

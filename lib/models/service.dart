import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

 class Service {
  
  static double paddingTop =0;
  static double appBarHeight = 0;
  static double bottomNavigationBarHeight = 0;


  static  double getContextHeight(BuildContext context, double percentage){  
      return (MediaQuery.of(context).size.height -
       paddingTop - appBarHeight - bottomNavigationBarHeight ) * percentage;
    }

  static String getDateString(DateTime dateTime){
      try{
          return DateFormat.yMd().format(dateTime);
      }
      catch(Exception){
        return '';
      }
  }

  static String getDateStringFormat(DateTime dateTime,String format){
      try{
          return DateFormat(format).format(dateTime);
      }
      catch(Exception){
        return '';
      }
  }

  static DateTime convertDateTime(String dateTime){
      try{
          return DateTime.parse(dateTime);
      }
      catch(Exception){
        return null;
      }
  }
 
}

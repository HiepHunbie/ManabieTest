import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'dart:math';

class Utils {
  static final List<String> tensNames = [
    '',
    ' Mười',
    ' Hai mươi',
    ' Ba mươi',
    ' Bốn mươi',
    ' Năm mươi',
    ' Sáu mươi',
    ' Bảy mươi',
    ' Tám mươi',
    ' Chín mươi'
  ];
  static final List<String> numNames = [
    '',
    ' Một',
    ' Hai',
    ' Ba',
    ' Bốn',
    ' Năm',
    ' Sáu',
    ' Bảy',
    ' Tám',
    ' Chín',
    ' Mười',
    ' Mười một',
    ' Mười hai',
    ' Mười ba',
    ' Mười bốn',
    ' Mười năm',
    ' Mười sáu',
    ' Mười bảy',
    ' Mười tám',
    ' Mười chín'
  ];

  static Size getTextSize(BuildContext context, TextStyle style, String text) {
    return (TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: ui.TextDirection.ltr,
    )..layout()).size;
  }

  static String convertLessThanOneThousand(int number) {
    String soFar;
    if ((number % 100) < 20) {
      soFar = numNames[number % 100];
      number ~/= 100;
    } else {
      soFar = numNames[number % 10];
      number ~/= 10;
      soFar = tensNames[number % 10] + soFar;
      number ~/= 10;
    }
    if (number == 0) {
      return soFar;
    }
    return ('${numNames[number]} Trăm') + soFar;
  }

  static String convert(int number) {
    if (number == 0) {
      return 'Không';
    }
    String snumber = number.toString();
    final String mask = '000000000000';
    final NumberFormat df = NumberFormat(mask);
    snumber = df.format(number);
    final int billions = int.parse(snumber.substring(0, 3));
    final int millions = int.parse(snumber.substring(3, 6));
    final int hundredThousands = int.parse(snumber.substring(6, 9));
    final int thousands = int.parse(snumber.substring(9, 12));
    String tradBillions;
    switch (billions) {
      case 0:
        tradBillions = '';
        break;
      case 1:
        tradBillions = '${convertLessThanOneThousand(billions)} Tỉ';
        break;
      default:
        tradBillions = '${convertLessThanOneThousand(billions)} Tỉ';
    }
    String result = tradBillions;
    String tradMillions;
    switch (millions) {
      case 0:
        tradMillions = '';
        break;
      case 1:
        tradMillions = '${convertLessThanOneThousand(millions)} Triệu';
        break;
      default:
        tradMillions = '${convertLessThanOneThousand(millions)} Triệu';
    }
    result = result + tradMillions;
    String tradHundredThousands;
    switch (hundredThousands) {
      case 0:
        tradHundredThousands = '';
        break;
      case 1:
        tradHundredThousands = 'Một nghìn ';
        break;
      default:
        tradHundredThousands =
            '${convertLessThanOneThousand(hundredThousands)} Nghìn';
    }
    result = result + tradHundredThousands;
    String tradThousand;
    tradThousand = convertLessThanOneThousand(thousands);
    result = result + tradThousand;
    print(
        's1 ${result.replaceAll(r'^\s+', '').replaceAll(r'\b\s{2,}\b', ' ')}');
    return '${result.replaceAll(r'^\s+', '').replaceAll(r'\b\s{2,}\b', ' ')} ${'vnd_word'.tr}';
  }

  static String newsDateTime(DateTime? date){
    if (date == null) return '';
    final now = DateTime.now();
    final Duration difference = now.difference(date);
    if (difference.inMinutes < 60) {
      return '${max(1, difference.inMinutes)} phút trước';
    } else if (difference.inHours<24) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays<30) {
      return '${difference.inDays} ngày trước';
    } else {
      return '${difference.inDays/30} tháng trước';
    }
  }
}

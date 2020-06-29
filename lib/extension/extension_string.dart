import 'dart:convert';
import 'dart:ui';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:zdl_tool/utils/color_util.dart';

/// @author zdl
/// date 2020/3/31 18:19
/// email zdl328465042@163.com
/// description 扩展String

extension ExtensionString on String {

  bool get isNull => null == this || 'null' == this || '' == this.trim();

  String get dealNull => this.isNull ? '' : this;

  ///String转int
  int get parseInt => int.tryParse(this.dealNull);

  ///String转double
  double get parseDouble => double.tryParse(this.dealNull);

  ///对字符串进行md5加密
  String get generateMd5 =>
      hex.encode((md5.convert(Utf8Encoder().convert(this.dealNull))).bytes);

  bool _regExp(String source) => RegExp(source).hasMatch(this.dealNull);

  ///验证是否是电话号码
  bool get isPhoneNumber => _regExp(r'^1[3-9][0-9]\d{8}$');

  ///验证是否是邮箱
  bool get isEmail => _regExp(r'^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$');

  ///是否是url
  bool get isUrl => _regExp(r'^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+$');

  ///是否是身份证
  bool get isIdCard => _regExp(r'^\d{17}[\d|x]|\d{15}$');

  ///是否是中文
  bool get isChinese => _regExp(r'[\u4e00-\u9fa5]');

  ///是否是车牌
  bool get isCarNumber =>
      _regExp(
          r'(^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Za-z]{1}[A-Za-z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Za-z0-9]{4}[A-Za-z0-9挂学警港澳]{1}$)|(^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Za-z]{1}[A-Za-z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Za-z0-9]{4}[A-Za-z0-9挂学警港澳]{2}$)');

  ///获取字符串中第几个字符
  ///num 字符串中第几个字符，非下标
  String findChar(int num) => num > this.dealNull.length ? '' : this.dealNull.substring(num-1, num);

  ///字符串转颜色
  Color toColor({double alpha, Color defaultColor = ColorUtil.text_color_333}) {
    try{
      switch(this.dealNull.length){
        case 0:
          return defaultColor;
          break;
        case 3:
          return Color(int.parse('${this.findChar(1)*2}${this.findChar(2)*2}${this.findChar(3)*2}', radix: 16) + 0xFF000000);
          break;
        case 4:
          return Color(int.parse('${this.findChar(2)*2}${this.findChar(3)*2}${this.findChar(4)*2}', radix: 16) + 0xFF000000);
          break;
        case 6:
          return Color(int.parse(this, radix: 16) + 0xFF000000);
          break;
        case 7:
          return Color(int.parse(this.substring(1, 7), radix: 16) + 0xFF000000);
          break;
        case 8:
          return Color(int.parse(this.substring(0, 8), radix: 16));
          break;
        case 9:
          return Color(int.parse(this.substring(1, 9), radix: 16));
          break;
        default:
          return defaultColor;
          break;
      }
    }catch(e){
      print(e);
      return defaultColor;
    }
  }

  ///处理后台返回数据有可能为空的情况
  ///def 默认值
  String dealData({String def = ''}) => this.isNull ? def : this;
}
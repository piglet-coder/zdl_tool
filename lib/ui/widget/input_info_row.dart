import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// @author zdl
/// date 2020/7/21 11:05
/// email zdl328465042@163.com
/// description 通用的左右布局信息输入、选择
class InputInfoRow extends StatelessWidget {
  final String left;
  final String right;
  final String hintText;
  final String unit;
  final TextInputType inputType;
  final TextEditingController controller;
  final int leftFlex;
  final int rightFlex;
  final Color bgColor;
  final EdgeInsetsGeometry margin;
  final Color leftColor;
  final Color rightColor;
  final Color hintColor;
  final double fontSize;
  final FontWeight leftFontWeight;
  final bool showArrowRight;
  final GestureTapCallback onTap;
  final EdgeInsetsGeometry contentPadding;

  InputInfoRow({
    this.left,
    this.right,
    this.hintText,
    this.unit,
    this.inputType,
    this.controller,
    this.leftFlex = 1,
    this.rightFlex = 2,
    this.bgColor = Colors.transparent,
    this.margin,
    this.leftColor = const Color(0xff333333),
    this.rightColor = const Color(0xff666666),
    this.hintColor = const Color(0xff999999),
    this.fontSize = 14,
    this.leftFontWeight = FontWeight.w600,
    this.showArrowRight = false,
    this.onTap,
    this.contentPadding = const EdgeInsets.only(left: 10, top: 20, bottom: 20),
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController =
        controller ?? TextEditingController();
    if (null != right) {
      editingController.value = editingController.value.copyWith(
        text: right,
        selection: TextSelection.fromPosition(
          TextPosition(
            affinity: TextAffinity.downstream,
            offset: right.length,
          ),
        ),
      );
    }
    bool readOnly = null != onTap;
    Pattern reg;
    if (inputType == TextInputType.number || inputType == TextInputType.phone) {
      reg = RegExp('[0-9.]');
    }
    TextField textField = TextField(
      controller: editingController,
      textAlign: TextAlign.end,
      keyboardType: inputType,
      maxLines: 1,
      readOnly: readOnly,
      inputFormatters: [
        if (null != reg) WhitelistingTextInputFormatter(reg),
      ],
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor,
          fontSize: fontSize,
        ),
        contentPadding: contentPadding,
        border: InputBorder.none,
        suffixText: unit,
        suffixStyle: TextStyle(
          color: rightColor,
          fontSize: fontSize,
        ),
      ),
      style: TextStyle(
        color: rightColor,
        fontSize: fontSize,
      ),
    );
    return InkWell(
      onTap: onTap,
      child: Container(
        color: bgColor,
        margin: margin,
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: leftFlex,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  left,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: leftColor,
                    fontSize: fontSize,
                    fontWeight: leftFontWeight,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: rightFlex,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    //IgnorePointer
                    child:
                        readOnly ? IgnorePointer(child: textField) : textField,
                  ),
                  SizedBox(width: 10),
                  Visibility(
                    visible: showArrowRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
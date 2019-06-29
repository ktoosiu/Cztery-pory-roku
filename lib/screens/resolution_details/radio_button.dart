import 'package:cztery_pory_roku/models/signatures.dart';
import 'package:flutter/material.dart';

class RadioButtonWidget extends StatelessWidget {
  const RadioButtonWidget({
    Key key,
    @required this.selectedValue,
    @required this.onChangeCallback,
    this.description,
    this.radioValue,
  }) : super(key: key);

  final TypeOfSign selectedValue;
  final Function onChangeCallback;
  final description;
  final TypeOfSign radioValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: radioValue,
          onChanged: (TypeOfSign value) {
            onChangeCallback(value);
          },
          groupValue: selectedValue,
        ),
        Text(description)
      ],
    );
  }
}

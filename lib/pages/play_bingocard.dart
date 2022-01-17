import 'package:bingochart_app/pages/change_bingocards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayBingocard extends StatefulWidget {
  EditBingocardArguments arguments;

  PlayBingocard(this.arguments, {Key? key}) : super(key: key);

  @override
  _PlayBingocard createState() => _PlayBingocard(this.arguments);
}

class _PlayBingocard extends State<PlayBingocard> {
  final EditBingocardArguments arguments;

  _PlayBingocard(this.arguments);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(arguments.name),
        ),
        body: const CheckboxList());
  }
}

class CheckboxList extends StatefulWidget {
  const CheckboxList({Key? key}) : super(key: key);

  @override
  _CheckboxList createState() => _CheckboxList();
}

class _CheckboxList extends State<CheckboxList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(
            crossAxisCount: 5,
            childAspectRatio: 3,
            shrinkWrap: true,
            children: List.generate(25, (index) {
              return const CustomCheckBox();
            })),
      ],
    );
  }
}

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({Key? key}) : super(key: key);

  @override
  _CustomCheckBox createState() => _CustomCheckBox();
}

class _CustomCheckBox extends State<CustomCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Column(
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        const Text("e1qwe")
      ],
    );
  }
}

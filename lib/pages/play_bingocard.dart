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
      body:
    );
  }
}

class CheckboxList extends StatefulWidget{
  const CheckboxList({Key? key}) : super(key: key);

  @override
  _CheckboxList createState() => _CheckboxList();
}

class _CheckboxList extends State<CheckboxList>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 6,
          children: List.generate(
            25, (index) {
              return Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              );
          }
          ),
        ),
      ],
    ),
  }

}


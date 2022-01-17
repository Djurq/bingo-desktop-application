import 'package:bingochart_app/pages/change_bingocards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../db/bingocard_repository.dart';
import '../model/bingocard_items.dart';

class PlayBingocard extends StatefulWidget {
  EditBingocardArguments arguments;

  PlayBingocard(this.arguments, {Key? key}) : super(key: key);

  @override
  _PlayBingocard createState() => _PlayBingocard(this.arguments);
}

class _PlayBingocard extends State<PlayBingocard> {
  final EditBingocardArguments arguments;

  _PlayBingocard(this.arguments);

  late List<BingocardItems> items;
  bool isLoading = false;

  Future getListItems() async {
    setState(() => isLoading = true);
    items = await BingocardRepository.instance.getItems(arguments.id);
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    getListItems();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(arguments.name),
        ),
        body: isLoading
            ? const CircularProgressIndicator()
            : items.isEmpty
                ? const Text("No items")
                : Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(
                      child: CheckboxList(items),
                    ),
                  ));
  }
}

class CheckboxList extends StatefulWidget {
  final List<BingocardItems> items;

  const CheckboxList(this.items, {Key? key}) : super(key: key);

  @override
  _CheckboxList createState() => _CheckboxList(this.items);
}

class _CheckboxList extends State<CheckboxList> {
  late List<BingocardItems> items;
  _CheckboxList(this.items);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return GridView.count(
        crossAxisCount: 5,
        childAspectRatio: (itemWidth / itemHeight),
        children: List.generate(25, (index) {
          return SizedBox(child: CustomCheckBox(items[index]));
        }));
  }
}

class CustomCheckBox extends StatefulWidget {
  late BingocardItems item;
  CustomCheckBox(this.item, {Key? key}) : super(key: key);

  @override
  _CustomCheckBox createState() => _CustomCheckBox(item);
}

class _CustomCheckBox extends State<CustomCheckBox> {
  bool _selected = false;
  late BingocardItems item;

  _CustomCheckBox(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: _selected ? Colors.blue : null,
        // If current item is selected show blue color
        title: Text(item.name.toString()),
        onTap: () => setState(() => _selected = !_selected),
        dense: true,
      ),
    );
  }
}

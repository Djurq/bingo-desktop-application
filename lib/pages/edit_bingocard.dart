import 'package:bingochart_app/db/bingocard_repository.dart';
import 'package:bingochart_app/model/bingocard.dart';
import 'package:bingochart_app/pages/change_bingocards.dart';
import 'package:flutter/material.dart';

import '../model/bingocard_items.dart';

class EditBingocard extends StatefulWidget {
  EditBingocardArguments arguments;

  EditBingocard(this.arguments, {Key? key}) : super(key: key);

  @override
  _EditBingocard createState() => _EditBingocard(arguments);
}

class _EditBingocard extends State<EditBingocard> {
  late List<BingocardItems> items;
  bool isLoading = false;
  final EditBingocardArguments arguments;

  _EditBingocard(this.arguments);

  Future getListItems() async {
    print(arguments.id);
    setState(() => isLoading = true);
    items = await BingocardRepository.instance.getItems(arguments.id);
    print(items);
    setState(() => isLoading = false);
  }

  void addItemToBingocard(BingocardItems item, String newName) async{
    item.name = newName;
    await BingocardRepository.instance.updateItem(item);
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
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.name),
      ),
      body: Container(
          child: isLoading
              ? const CircularProgressIndicator()
              : items.isEmpty
                  ? const Text("No items")
                  : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                          child: GridView.count(
                            crossAxisCount: 5,
                            childAspectRatio: (itemWidth / itemHeight),
                            children: List.generate(
                              items.length,
                              (index) {
                                return SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: TextField(
                                          expands: true,
                                          maxLines: null,
                                          minLines: null,
                                          controller: TextEditingController(
                                              text: items[index].name),
                                          textInputAction: TextInputAction.go,
                                          onSubmitted: (value) {
                                            addItemToBingocard(items[index], value);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    ),
                  )),
    );
  }
}

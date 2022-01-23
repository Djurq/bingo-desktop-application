import 'package:bingochart_app/pages/play_bingocard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../db/bingocard_repository.dart';
import '../model/bingocard.dart';
import 'change_bingocards.dart';
class SelectBingocard extends StatefulWidget {
  const SelectBingocard({Key? key}) : super(key: key);

  @override
  _SelectBingocard createState() => _SelectBingocard();
}

class _SelectBingocard extends State<SelectBingocard> {
  late List<Bingocard> cards;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshCards();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshCards() async {
    setState(() => isLoading = true);
    cards = await BingocardRepository.instance.readAllBingocards();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select bingocard"),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : cards.isEmpty
                        ? const Text("No cards")
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: cards.length,
                            itemBuilder: (context, index) {
                              return BingocardCard2(
                                  //fix this dumbass
                                  name: cards[index].name,
                                  index: index + 1,
                                  id: cards[index].id!);
                            },
                          )),
          ],
        ),
      ),
    );
  }
}

class BingocardCard2 extends StatelessWidget {
  const BingocardCard2(
      {Key? key, required this.name, required this.index, required this.id})
      : super(key: key);
  final String name;
  final int index;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
              PlayBingocard(EditBingocardArguments(name, id))));
        },
        title: Text(index.toString() + " " + name)
        ),
      );
  }
}
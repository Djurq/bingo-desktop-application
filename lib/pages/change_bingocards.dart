import 'package:bingochart_app/db/bingocard_repository.dart';
import 'package:bingochart_app/model/bingocard.dart';
import 'package:bingochart_app/pages/edit_bingocard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeBingocards extends StatefulWidget {

  const ChangeBingocards({Key? key}) : super(key: key);

  @override
  _ChangeBingoCards createState() => _ChangeBingoCards();
}

class _ChangeBingoCards extends State<ChangeBingocards> {
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

  Future createAddDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Name bingocard"),
            content: TextField(
              controller: controller,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: const Text("Add"),
                onPressed: () {
                  Navigator.of(context).pop(controller.text.toString());
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChangeBingocards"),
      ),
      body: Column(
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
                            return BingocardCard(
                                //fix this dumbass
                                name: cards[index].name,
                                index: index + 1,
                                id: cards[index].id!);
                          },
                        )),
          ElevatedButton(
              onPressed: () async {
                createAddDialog(context).then((value) async {
                  await BingocardRepository.instance
                      .create(Bingocard(name: value));
                  await refreshCards();
                });
              },
              child: const Text("Add new bingocard")),
        ],
      ),
    );
  }
}

class BingocardCard extends StatelessWidget {
  const BingocardCard(
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
                  EditBingocard(EditBingocardArguments(name, id))));
        },
        title: Text(index.toString() + " " + name),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}

class EditBingocardArguments {
  final String name;
  final int id;

  EditBingocardArguments(this.name, this.id);
}

import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Bingochart maker"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonBarTheme(
              data: const ButtonBarThemeData(
                buttonPadding: EdgeInsets.symmetric(horizontal: 24.0),
              ),
              child: ButtonBar(
                children: [
                  SizedBox(
                    width: 200,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/change');
                      },
                      child: const Text('Change bingo cards'),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/select');
                      },
                      child: const Text('Select bingo card'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
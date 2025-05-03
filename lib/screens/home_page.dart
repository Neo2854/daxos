import 'package:daxos/constants/queries.dart';
import 'package:daxos/db/remainders_db.dart';
import 'package:daxos/entities/remainder.dart';
import 'package:daxos/widgets/circular_icon_btn.dart';
import 'package:daxos/widgets/expanding_text_field.dart';
import 'package:daxos/widgets/message_box.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MessageBox> messages = [];

  TextEditingController controller = TextEditingController();

  bool isLocked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Daxos"
        ),
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 30
        )
      ),

      // Body
      body: Column(
        children: [

          // Chat
          Expanded(
            child: ListView.builder(
              reverse: true,
              scrollDirection: Axis.vertical,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return messages[messages.length - index - 1];
              },
            )
          ),

          SizedBox(height: 10,),

          // Actions Bar
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularIconBtn(
                icon: Icons.menu,
                onTap: () async {
                  List<Remainder> remainders = await RemaindersDB.instance.read();

                  if(remainders == null) return;

                  for(int i=0;i<remainders.length;i++){
                    print(remainders[i].name);
                  }
                },
              ),
              Expanded(
                child: ExpandingTextField(
                  controller: controller
                ),
              ),
              CircularIconBtn(
                icon: Icons.send_rounded,
                onTap: () async {
                  if(controller.text.trim().isEmpty) return;

                  setState(() {
                    messages.add(MessageBox(controller.text));
                    controller.clear();
                  });

                  RemaindersDB.instance.clear();
                },
              )
            ],
          ),
        ],
      )
    );
  }
}
import 'package:daxos/widgets/expanding_text_field.dart';
import 'package:daxos/widgets/message_box.dart';
import 'package:flutter/material.dart';

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
                return messages[index];
              },
            )
          ),

          SizedBox(height: 10,),

          // Actions Bar
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    top: 10,
                    bottom: 10,
                    right: 5
                  ),
                  child: ExpandingTextField(
                    controller: controller
                  ),
                ),
              ),
              Center(
                child: IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 32,
                  onPressed: isLocked ? null : () {
                    setState(() {
                      messages.insert(0, MessageBox(controller.text));
                      controller.clear();
                    });
                  }
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}
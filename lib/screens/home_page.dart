import 'package:daxos/constants/queries.dart';
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

  Future<Database>? remainderDb;

  void startRemaindersDb() async {
    print("Hello");
    WidgetsFlutterBinding.ensureInitialized();

    this.remainderDb = openDatabase(
      join(await getDatabasesPath(), "remainders.db"),

      onCreate: (db, version) {
        return db.execute(
          CREATE_REMAINDERS_DB
        );
      },

      version: 1
    );

    print(this.remainderDb);
  }

  Future<void> insertRemainder(Remainder remainder) async {
    final db = await remainderDb;

    if(db == null) return;

    await db.insert(
      'Remainders',
      remainder.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace 
    );
  }

  Future<List<Remainder>> getRemaindersFromDb() async {
    // Get a reference to the database.
    final db = await remainderDb;

    if(db == null) return [];

    // Query the table for all the dogs.
    final List<Map<String, Object?>> dogMaps = await db.query('dogs');

    // Convert the list of each dog's fields into a list of `Dog` objects.
    return [
      for (final {'name': name as String, 'description': description as String}
          in dogMaps)
        Remainder(name: name, description: description),
    ];
  }

  @override
  void initState() {
    super.initState();
    startRemaindersDb();
  }

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
                onTap: () {

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

                  var fido = Remainder(name: "Test", description: "Hello World");

                  await insertRemainder(fido);

                  print(await getRemaindersFromDb());
                },
              )
            ],
          ),
        ],
      )
    );
  }
}
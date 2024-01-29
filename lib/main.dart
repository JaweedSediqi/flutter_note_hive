
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_hive/add_screen.dart';
import 'package:note_hive/boxes.dart';
import 'package:note_hive/models/note.dart';
void main() async {

   await Hive.initFlutter();
   Hive.registerAdapter(NoteAdapter());
   // 3- باکس خود را در نام باکسی ساختیم باز می کنیم یعنی ذخیره می کنیم
  noteBox = await Hive.openBox<Note>('noteBox');


  runApp(MaterialApp(


    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: Main(),
  ));
}
class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}
class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: const Text("Note Hive"),
            ),
            body: ValueListenableBuilder(
              valueListenable: noteBox.listenable(),
              builder: (context, box, widget){
                return ListView.separated(
                    itemBuilder: (context, index){

                      Note note = box.getAt(index)!;

                      String tit = note.title;
                      String con = note.content;

                      return ListTile(
                        onTap: (){
                          setState(() {
                           Navigator.push(context, MaterialPageRoute(builder: (c) => AddNote(title: tit, content: con,index: index,)));
                          });
                        },
                        trailing: IconButton(onPressed: (){

                          showDialog(context: context, builder: (context){

                            return AlertDialog(
                              title: Text('Delete'),
                              content: Text("Do you want to delete the Note"),
                              actions: [
                                MaterialButton(onPressed: (){
                                  setState(() {
                                    box.deleteAt(index);
                                  });
                                  Navigator.pop(context);
                                }, child: Text('Yes'),),
                                MaterialButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text('No'),),

                              ],
                            );

                          });



                        }, icon: Icon(Icons.delete)),
                        title: Text(note.title),
                        subtitle: Text(note.content),
                      );
                    },
                    separatorBuilder:(context, index) {
                      return SizedBox( height: 10,);
                    },
                    itemCount: noteBox.length);
              },
            ),
    floatingActionButton: FloatingActionButton(
        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (c) => AddNote()));

        },
      child: Icon(Icons.add, size: 25,),
    ),
    );
  }
}

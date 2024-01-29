

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_hive/boxes.dart';
import 'package:note_hive/models/note.dart';

class AddNote extends StatefulWidget {

  const AddNote({Key? key, this.title, this.content, this.index}) : super (key: key);
  final String? title;
  final String? content;
  final int? index;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  final title = TextEditingController();
  final content = TextEditingController();


  @override
  Widget build(BuildContext context) {

    if(widget.title != null || widget.content != null){
     title.text = widget.title!;
     content.text = widget.content!;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: title,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Title'
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: content,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Content'
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(onPressed: () async {

                  final newNote = Note(title: title.text, content: content.text);

               // final box =  await Hive.openBox<Note>('noteBox');

                  // 4 - برای اد کردن داده های خود از میتود اد که در هایو است استفاده کردیم
                  if(widget.title != null || widget.content != null){
                    noteBox.putAt(widget.index!, newNote);
                  }else{
                    noteBox.add(newNote);
                  }
                  Navigator.pop(context);


                }, child: Text('Save', style: TextStyle(fontSize: 25),),),
                MaterialButton(onPressed: (){

                  Navigator.pop(context);

                }, child: Text('Cancel', style: TextStyle(fontSize: 25),)),
              ]
            )
          ],
        ),
      ),
    );
  }
}

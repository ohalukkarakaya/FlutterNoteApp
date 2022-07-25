import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:note_app/models/postNoteModel.dart';

import '../models/detailModel.dart';
import '../models/updateNoteModel.dart';
import '../servicers/service.dart';

class AddNote extends StatefulWidget {
  final String? noteID;
  const AddNote({super.key, this.noteID});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  bool get isEditing => widget.noteID != null;

  Service get service => GetIt.I<Service>();

  late String errorMessage;
  late Detail detail;

  bool isLoading = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    
    //satates for editin
    if (isEditing) {
      setState(() {
      isLoading = true;
      });
      service.getDetail(widget.noteID!).then((response) {
        setState(() {
          isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? 'An Error Occured';
        }
        detail = response.data!;
        _titleController.text = detail.noteTitle;
        _contentController.text = detail.note;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Note' : 'Add Note')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      hintText: 'Your Note',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        if(isEditing){

                          setState(() {
                            isLoading = true;
                          });

                          final note = UpdateNote(
                            noteTitle: _titleController.text,
                            noteContent: _contentController.text,
                            );
                            final result = await service.updateNote(widget.noteID!, note);

                            setState(() {
                            isLoading = false;
                          });

                            const title = 'Done';
                            final text = result.error ? (result.errorMessage ?? 'An error occured') : "Your Note Updated";

                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(title),
                                content: Text(text),
                                actions: [
                                  FlatButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Ok")
                                  )
                                ],
                              )
                              )
                              .then((data){
                                if(result.data!){
                                  Navigator.of(context).pop();
                                }
                               });


                        }else{

                          setState(() {
                            isLoading = true;
                          });

                          final note = PostNote(
                            noteTitle: _titleController.text,
                            noteContent: _contentController.text,
                            );
                            final result = await service.postNote(note);

                            setState(() {
                            isLoading = false;
                          });

                            const title = 'Done';
                            final text = result.error ? (result.errorMessage ?? 'An error occured') : "Your Note Posted";

                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(title),
                                content: Text(text),
                                actions: [
                                  FlatButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Ok")
                                  )
                                ],
                              )
                              )
                              .then((data){
                                if(result.data!){
                                  Navigator.of(context).pop();
                                }
                               });

                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

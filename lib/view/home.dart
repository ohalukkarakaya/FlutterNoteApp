import 'package:flutter/material.dart';
import 'package:note_app/models/apiResponse.dart';
import 'package:note_app/models/notesModel.dart';
import 'package:note_app/view/addNote.dart';
import 'package:get_it/get_it.dart';

import '../servicers/service.dart';
import 'deleteNote.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Service get service => GetIt.instance<Service>();

late APIResponse<List<NotesForList>> _apiResponse;
bool isLoading = false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
  
  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      isLoading = true;
    });
    
    _apiResponse = await service.getNoteList();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddNote()))
          .then((_){
            _fetchNotes();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Builder(
        builder: (_){
        if(isLoading){
          return const Center(child: CircularProgressIndicator());
        }

        if(_apiResponse.error){
          return Center(child: Text(_apiResponse.errorMessage!),);
        }

        return ListView.separated(
        separatorBuilder: (_, __) => const Divider(height: 1.0, color: Colors.blue,),
        itemBuilder: (_, index){
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction){

            },
            confirmDismiss: (direction)async{
             final result = await showDialog(
                context: context,
                builder: (_) => const DeleteNote(),
              );

            if(result){
              final deleteResult = await service.deleteNote(_apiResponse.data![index].noteID);

              var message;

              if(deleteResult != null && deleteResult.data == true){
                message = "The note deleted";
              } else {
                message = deleteResult.errorMessage ?? "Error occured when trying to delete";
              }

              Scaffold.of(_).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(message, textAlign: TextAlign.center,), duration: const Duration(milliseconds: 1000),));

              return deleteResult.data ?? false;
            }
            print(result);
            return result;
            },
            background: Container(
              color: Colors.red,
              padding: const EdgeInsets.only(left: 15.0),
              child: const Align(
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              alignment: Alignment.centerLeft,
              ),
            ),
            child: ListTile(
              title: Text(
                _apiResponse.data![index].noteTitle,
                style: TextStyle(
                  color: Theme.of(context).primaryColor
                ),
                ),
              subtitle: Text('Last edited on ${formatDateTime(_apiResponse.data![index].latestEditDateTime!)}'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddNote(noteID: _apiResponse.data![index].noteID,)))
                .then((value) {
                  _fetchNotes();
                },);
              },
            ),
          );
        },
        itemCount: _apiResponse.data!.length,
      );
        },
      ),
    );
  }
}
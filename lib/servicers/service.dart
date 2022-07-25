import 'dart:convert';

import 'package:note_app/models/detailModel.dart';
import 'package:note_app/models/notesModel.dart';
import 'package:http/http.dart' as http;

import '../models/apiResponse.dart';
import '../models/postNoteModel.dart';
import '../models/updateNoteModel.dart';

class Service {
  static const API = "https://tq-notes-api-jkrgrdggbq-el.a.run.app";
  static const headers = {
    'apiKey' : '8a2a2012-7a15-4de2-8ca1-2b5a28dffccf',
    'Content-Type' : 'application/json'
  };

  Future<APIResponse<List<NotesForList>>> getNoteList(){
    return http.get(Uri.parse('$API/notes'), headers: headers)
    .then((data){
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        final notes = <NotesForList>[];

        for(var item in jsonData){
          notes.add(NotesForList.fromJson(item));
        }

      return APIResponse<List<NotesForList>>(data: notes,);
      }
      return APIResponse<List<NotesForList>>(error: true, errorMessage: 'An error occured');
    })
    .catchError((e) =>  APIResponse<List<NotesForList>>(error: true, errorMessage: e.toString()));
  }

  Future<APIResponse<Detail>> getDetail(String noteID){
    return http.get(Uri.parse('$API/notes/$noteID'), headers: headers).then((data){
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);

          return APIResponse<Detail>(data: Detail.fromJson(jsonData));

      }
      return APIResponse<Detail>(error: true, errorMessage: 'An error occured');
    })
    .catchError((e) =>  APIResponse<Detail>(error: true, errorMessage: e.toString()));
  }

  Future<APIResponse<bool>> postNote(PostNote item){
    return http.post(Uri.parse('$API/notes'), headers: headers, body: json.encode(item.toJson())).then((data){
      if(data.statusCode == 201){

          return APIResponse<bool>(data: true);

      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
    .catchError((e) =>  APIResponse<bool>(error: true, errorMessage: e.toString()));
  }

  Future<APIResponse<bool>> updateNote(String NoteID, UpdateNote item){
    return http.put(Uri.parse('$API/notes/$NoteID'), headers: headers, body: json.encode(item.toJson())).then((data){
      if(data.statusCode == 204){

          return APIResponse<bool>(data: true);

      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
    .catchError((e) =>  APIResponse<bool>(error: true, errorMessage: e.toString()));
  }

  Future<APIResponse<bool>> deleteNote(String NoteID){
    return http.delete(Uri.parse('$API/notes/$NoteID'), headers: headers).then((data){
      if(data.statusCode == 204){

          return APIResponse<bool>(data: true);

      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
    .catchError((e) =>  APIResponse<bool>(error: true, errorMessage: e.toString()));
  }
}
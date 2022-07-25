

import 'package:flutter/material.dart';

class DeleteNote extends StatelessWidget {
  const DeleteNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text('Do you really want to delete this note?'),
      actions: [
        FlatButton(
          child: Text('Yes'),
          onPressed: (){
            Navigator.of(context).pop(true);
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: (){
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
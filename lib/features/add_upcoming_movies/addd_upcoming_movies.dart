import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddUpcomingMovie extends StatefulWidget {
  AddUpcomingMovie({super.key});

  @override
  State<AddUpcomingMovie> createState() => _AddUpcomingMovieState();
}

class _AddUpcomingMovieState extends State<AddUpcomingMovie> {
  String? _title;
  String? _url;
  DateTime? _date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add upcoming movie'),
        actions: [
          IconButton(
            onPressed: _title == null || _url == null || _date == null
                ? null
                : () {
                    FirebaseFirestore.instance.collection('upcoming').add({
                      'title': _title!,
                      'url': _url!,
                      'date': _date!,
                    });
                  },
            icon: Icon(
              Icons.check,
            ),
          )
        ],
      ),
      body: AddBody(
        onTitleChanged: (newValue) {
          setState(
            () {
              _title = newValue;
            },
          );
        },
        onUrlChanged: (newValue) {
          setState(
            () {
              _url = newValue;
            },
          );
        },
        onDateChanged: (newValue) {
          setState(
            () {
              _date = newValue;
            },
          );
        },
        dateFormatted: _date?.toIso8601String(),
      ),
    );
  }
}

class AddBody extends StatelessWidget {
  const AddBody({
    Key? key,
    required this.onDateChanged,
    required this.onTitleChanged,
    required this.onUrlChanged,
    this.dateFormatted,
  }) : super(key: key);

  final Function(String) onTitleChanged;
  final Function(String) onUrlChanged;
  final Function(DateTime) onDateChanged;
  final String? dateFormatted;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Titanic',
          ),
          onChanged: onTitleChanged,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'data:image/basBAQA.jpeg',
          ),
          onChanged: onUrlChanged,
        ),
        ElevatedButton(
          onPressed: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(
                const Duration(days: 365 * 10),
              ),
            );
            onDateChanged(selectedDate!);
          },
          child: Text(dateFormatted ?? 'Choose release date'),
        ),
      ],
    ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curlzzz_new/features/add_upcoming_movies/cubit/add_upcoming_movies_cubit.dart';
import 'package:curlzzz_new/features/upcoming/cubit/upcoming_movies_cubit.dart';
import 'package:curlzzz_new/repositories/upcoming_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: const Text('Add upcoming movie'),
        actions: [
          BlocProvider(
            create: (context) => AddUpcomingMoviesCubit(UpcomingReposiroty()),
            child: BlocListener<AddUpcomingMoviesCubit, AddUpcomingMoviesState>(
              listener: (context, state) {
                if (state.saved == true) {
                  Navigator.of(context).pop();
                }
                if (state.errorMessage.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child:
                  BlocBuilder<AddUpcomingMoviesCubit, AddUpcomingMoviesState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: _title == null || _url == null || _date == null
                        ? null
                        : () {
                            context
                                .read<AddUpcomingMoviesCubit>()
                                .upcoming(_title!, _url!, _date!);
                          },
                    icon: const Icon(
                      Icons.check,
                    ),
                  );
                },
              ),
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
          decoration: const InputDecoration(
            hintText: 'Titanic',
          ),
          onChanged: onTitleChanged,
        ),
        TextField(
          decoration: const InputDecoration(
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

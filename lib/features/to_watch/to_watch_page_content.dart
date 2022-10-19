import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curlzzz_new/features/to_watch/cubit/to_watch_cubit.dart';
import 'package:curlzzz_new/models/watch_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToWatchPage extends StatelessWidget {
  ToWatchPage({super.key});
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('movies')
              .add({'title': controller.text});
          controller.clear();
        },
      ),
      body: BlocProvider(
        create: (context) => ToWatchCubit()..start(),
        child: BlocBuilder<ToWatchCubit, ToWatchState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return Text('Something went wrong : ${state.errorMessage}');
            }
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final watchModels = state.documents;
            return ListView(
              children: [
                for (final watchModel in watchModels) ...[
                  Dismissible(
                      key: ValueKey(
                        watchModel.id,
                      ),
                      onDismissed: (_) {
                        FirebaseFirestore.instance
                            .collection('movies')
                            .doc(watchModel.id)
                            .delete();
                      },
                      child: MovieWidget(watchModel.title)),
                ],
                TextField(
                  controller: controller,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MovieWidget extends StatelessWidget {
  const MovieWidget(
    this.title, {
    Key? key,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      color: const Color.fromARGB(255, 243, 177, 198),
      child: Text(title),
    );
  }
}

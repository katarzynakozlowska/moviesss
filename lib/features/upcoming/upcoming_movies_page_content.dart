import 'package:curlzzz_new/features/add_upcoming_movies/addd_upcoming_movies.dart';
import 'package:curlzzz_new/features/upcoming/cubit/upcoming_movies_cubit.dart';
import 'package:curlzzz_new/models/upcoming_model.dart';
import 'package:curlzzz_new/repositories/upcoming_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingMoviesPage extends StatelessWidget {
  const UpcomingMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AddUpcomingMovie(),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
        create: (context) => UpcomingMoviesCubit(UpcomingReposiroty())..start(),
        child: BlocBuilder<UpcomingMoviesCubit, UpcomingMoviesState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return Text('Something went wrog: ${state.errorMessage}');
            }
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final upcomingModels = state.documents;
            return ListView(
              children: [
                for (final upcomingModel in upcomingModels) ...[
                  Dismissible(
                    key: ValueKey(upcomingModel.id),
                    onDismissed: (_) {
                      context
                          .read<UpcomingMoviesCubit>()
                          .dismiss(id: upcomingModel.id);
                    },
                    child: UpcomingMovieWidget(
                      upcomingModel: upcomingModel,
                    ),
                  ),
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}

class UpcomingMovieWidget extends StatelessWidget {
  const UpcomingMovieWidget({
    Key? key,
    required this.upcomingModel,
  }) : super(key: key);

  final UpcomingModel upcomingModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(20.0),
      color: const Color.fromARGB(255, 243, 177, 198),
      height: 200,
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.black12,
              image: DecorationImage(
                image: NetworkImage(
                  upcomingModel.url,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: 20,
            width: 300,
            child: Center(
              child: Text(upcomingModel.title),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.white,
                child: Text(
                  upcomingModel.date.toString(),
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Text(
                      upcomingModel.daysLeft(),
                    ),
                    const Text('days left')
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

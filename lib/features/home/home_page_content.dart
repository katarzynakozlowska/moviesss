// ignore_for_file: prefer_const_constructors

import 'package:curlzzz_new/features/authentication/pages/user_profile.dart';
import 'package:curlzzz_new/features/reviews/reviews_page_content.dart';
import 'package:curlzzz_new/features/to_watch/to_watch_page_content.dart';
import 'package:curlzzz_new/features/upcoming/upcoming_movies_page_content.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserProfile(),
                ),
              );
            },
            icon: Icon(
              Icons.person,
            ),
          )
        ],
        title: const Text('Moviesss'),
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 1) {
          return ToWatchPage();
        }
        if (currentIndex == 2) {
          return const UpcomingMoviesPage();
        }
        if (currentIndex == 3) {
          return ReviewsPage();
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Create your own base of movies',
              )
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            label: 'To watch',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.reviews,
            ),
            label: 'Reviews',
          ),
        ],
      ),
    );
  }
}

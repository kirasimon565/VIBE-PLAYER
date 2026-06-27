import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Library'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Playlists'),
              Tab(text: 'Artists'),
              Tab(text: 'Albums'),
              Tab(text: 'Genres'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Playlists View - Smart Folders')),
            Center(child: Text('Artists View - Holographic Cards')),
            Center(child: Text('Albums View - 3D Carousel')),
            Center(child: Text('Genres View - Liquid Gradient Bubbles')),
          ],
        ),
      ),
    );
  }
}

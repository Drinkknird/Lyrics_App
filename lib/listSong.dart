import 'package:flutter/material.dart';
import 'song.dart';
class SongListPage extends StatelessWidget {
  final List<Song> songs;
  SongListPage({required this.songs});

  void deleteSong(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Song'),
          content: Text('Are you sure you want to delete this song?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Delete the song from the list
                songs.removeAt(index);
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Close the song details page
              },
              child: Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Song List',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(songs[index].name),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(songs[index].name),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < songs[index].chords.length; i++)
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Chord: ${songs[index].chords[i]}'),
                                SizedBox(height: 10),
                                Text('Lyrics: ${songs[index].lyrics[i]}'),
                              ],
                            ),
                          ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text('Close'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          deleteSong(context, index);
                        },
                        child: Text('Delete Song'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
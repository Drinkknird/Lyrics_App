import 'package:flutter/material.dart';
import 'song.dart';

class SongListPage extends StatefulWidget {
  final List<Song> songs;
  final Key? key;

  const SongListPage({
    required this.songs,
    this.key,
  }) : super(key: key);

  @override
  SongListPageState createState() => SongListPageState();
}

class SongListPageState extends State<SongListPage> {
  void editSong(BuildContext context, int index) {
    TextEditingController nameController = TextEditingController();
    List<TextEditingController> chordControllers = [];
    List<TextEditingController> lyricControllers = [];

    // Initialize the text editing controllers with the current song data
    nameController.text = widget.songs[index].name;

    for (int i = 0; i < widget.songs[index].chords.length; i++) {
      chordControllers
          .add(TextEditingController(text: widget.songs[index].chords[i]));
      lyricControllers
          .add(TextEditingController(text: widget.songs[index].lyrics[i]));
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // Wrap with StatefulBuilder
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Edit Song'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Song Name',
                      ),
                    ),
                    const SizedBox(height: 20),
                    for (int i = 0; i < chordControllers.length; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: chordControllers[i],
                                  decoration: InputDecoration(
                                    labelText: 'Chord ${i + 1}',
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    chordControllers.removeAt(i);
                                    lyricControllers.removeAt(i);
                                  });
                                },
                                icon: const Icon(Icons.delete),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    chordControllers.insert(
                                        i + 1, TextEditingController());
                                    lyricControllers.insert(
                                        i + 1, TextEditingController());
                                  });
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: lyricControllers[i],
                            decoration: InputDecoration(
                              labelText: 'Lyric ${i + 1}',
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 252, 255,
                        255), // Set the background color to green
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 187, 255,
                        243), // Set the background color to green
                  ),
                  onPressed: () {
                    widget.songs[index].name = nameController.text;
                    widget.songs[index].chords.clear();
                    widget.songs[index].lyrics.clear();

                    for (int i = 0; i < chordControllers.length; i++) {
                      widget.songs[index].chords.add(chordControllers[i].text);
                      widget.songs[index].lyrics.add(lyricControllers[i].text);
                    }

                    Navigator.pop(context); // Close the dialog
                    setState(() {}); // Rebuild the ListView.builder
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void deleteSong(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Song'),
          content: const Text('Are you sure you want to delete this song?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (index >= 0 && index < widget.songs.length) {
                  widget.songs.removeAt(index);
                  Navigator.pop(context); // Close the dialog
                  setState(() {}); // Rebuild the ListView.builder
                  Navigator.pop(context); // Close the song details page
                }
              },
              child: const Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
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
        title: const Text(
          'Song List',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.songs[index].name),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          10), // Set the border radius to create rounded corners
                      child: Container(
                        color: const Color.fromARGB(255, 194, 221,
                            243), // Set the background color to blue
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.songs[index].name,
                              style: const TextStyle(
                                color:
                                    Colors.black, // Set the text color to white
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(
                        24, 20, 24, 0), // เพิ่มบริเวณ padding ด้านบน
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0;
                              i < widget.songs[index].chords.length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Chord: ${widget.songs[index].chords[i]}'),
                                  const SizedBox(height: 10),
                                  Text(
                                      'Lyrics: ${widget.songs[index].lyrics[i]}'),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    actionsPadding: const EdgeInsets.fromLTRB(
                        8, 8, 8, 16), // เพิ่มบริเวณ padding ด้านล่าง
                    actions: [
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 211,
                                    251, 243), // กำหนดสีพื้นหลังเป็นสีเหลือง
                                textStyle: const TextStyle(
                                    color: Colors.black), // เพิ่มสีของตัวอักษร
                              ),
                              child: const Text('Close'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                                editSong(context, index);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .yellow, // กำหนดสีพื้นหลังเป็นสีเหลือง
                              ),
                              child: const Text('Edit'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                deleteSong(context, index);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.red, // กำหนดสีพื้นหลังเป็นสีแดง
                              ),
                              child: const Text('Delete'),
                            ),
                          ),
                        ],
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

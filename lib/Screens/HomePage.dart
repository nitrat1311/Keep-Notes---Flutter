import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:keep_notes/Bloc/Notes/notes_bloc.dart';

import 'package:keep_notes/Models/NoteModels.dart';
import 'package:keep_notes/Screens/AddNotePage.dart';
import 'package:keep_notes/Screens/ShowNotePage.dart';
import 'package:keep_notes/Widgets/TextFrave.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NotesBloc>(context);
    final box = Hive.box<NoteModels>('keepNote');

    return Scaffold(
      backgroundColor: Color(0xffF2F3F7),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: BlocBuilder<NotesBloc, NotesState>(
                builder: (context, state) => TextFrave(
                  isTitle: true,
                  text: 'Total notes ${state.noteLength}',
                ),
              ),
              expandedHeight: MediaQuery.of(context).size.height * .1,
              pinned: true,
              elevation: 0,
              backgroundColor: Color(0xffF2F3F7),
              actions: [],
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (_, Box box, __) {
                  noteBloc.add(LengthAllNotesEvent(box.length));

                  if (box.values.isEmpty) {
                    return Center(
                      child: TextFrave(text: 'No notes', color: Colors.grey),
                    );
                  }

                  return BlocBuilder<NotesBloc, NotesState>(
                      builder: (_, state) {
                    return Column(
                      children: [
                        _ListNotes(),
                        state.noteLength == 5
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height * .1,
                              )
                            : const SizedBox()
                      ],
                    );
                  });
                },
              ),
            ]))
          ],
        ),
      ),
      floatingActionButton: InkWell(
        borderRadius: BorderRadius.circular(50.0),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddNotePage())),
        child: CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xff1977F3),
          child: const Icon(Icons.mode_edit_outline, color: Colors.white),
        ),
      ),
    );
  }
}

class _ListNotes extends StatelessWidget {
  const _ListNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NotesBloc>(context);
    final box = Hive.box<NoteModels>('keepNote');

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: box.values.length,
      itemBuilder: (_, i) {
        NoteModels note = box.getAt(i)!;

        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ShowNotePage(note: note, index: i))),
          child: Dismissible(
            key: Key(note.title!),
            background: Container(),
            direction: DismissDirection.endToStart,
            secondaryBackground: Container(
              padding: EdgeInsets.only(right: 35.0),
              margin: EdgeInsets.only(bottom: 15.0),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0))),
              child: Icon(Icons.delete_sweep_rounded,
                  color: Colors.white, size: 40),
            ),
            onDismissed: (direction) => noteBloc.add(DeleteNoteEvent(i)),
            child: Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(bottom: 15.0),
              height: 110,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFrave(
                          text: note.title.toString(),
                          fontWeight: FontWeight.w600),
                      TextFrave(
                          text: note.category!,
                          fontSize: 16,
                          color: Colors.blueGrey),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Wrap(
                    children: [
                      TextFrave(
                        text: note.body.toString(),
                        fontSize: 16,
                        color: Colors.grey,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFrave(
                          text: DateFormat.yMMMEd().format(note.created!),
                          fontSize: 16,
                          color: Colors.grey),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.circle,
                              color: Color(note.color!), size: 15)),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

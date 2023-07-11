part of 'notes_bloc.dart';

@immutable
class NotesState {
  final int color;
  final String category;
  final Color colorCategory;
  final int noteLength;

  const NotesState({
    this.color = 0xff1977F3,
    this.category = 'No list',
    this.colorCategory = Colors.grey,
    this.noteLength = 0,
  });

  NotesState copyWith({
    int? color,
    String? category,
    Color? colorCategory,
    int? noteLength,
  }) =>
      NotesState(
        color: color ?? this.color,
        category: category ?? this.category,
        colorCategory: colorCategory ?? this.colorCategory,
        noteLength: noteLength ?? this.noteLength,
      );
}

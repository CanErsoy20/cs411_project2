part of 'bookmarks_cubit.dart';

sealed class BookmarksState {}

final class BookmarksInitial extends BookmarksState {}

final class BookmarksLoading extends BookmarksState {}

final class BookmarksDisplay extends BookmarksState {}

final class BookmarksFilter extends BookmarksState {}

final class BookmarksError extends BookmarksState {
  final String title;
  final String description;

  BookmarksError({required this.title, required this.description});
}

final class BookmarksSuccess extends BookmarksState {
  final String title;
  final String description;

  BookmarksSuccess({required this.title, required this.description});
}

final class BookmarksChecking extends BookmarksState {}

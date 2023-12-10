part of 'bookmarks_cubit.dart';

sealed class BookmarksState {}

final class BookmarksInitial extends BookmarksState {}

final class BookmarksLoading extends BookmarksState {}

final class BookmarksDisplay extends BookmarksState {}

final class BookmarksFilter extends BookmarksState {}

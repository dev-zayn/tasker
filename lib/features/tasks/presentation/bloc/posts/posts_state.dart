part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class LoadingPostsState extends PostsState {}

class LoadedPostsState extends PostsState {
  final List<TaskEntity> posts;

  const LoadedPostsState({required this.posts});
}

class ErrorPostsState extends PostsState {
  final String message;
  const ErrorPostsState({required this.message});
}

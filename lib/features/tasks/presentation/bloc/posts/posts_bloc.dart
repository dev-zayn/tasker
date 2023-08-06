import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/tasks/domain/usecases/get_all_tasks.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/task.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllTasksUseCase getAllTasks;
  PostsBloc({required this.getAllTasks}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final posts = await getAllTasks();
        emit(postsToState(posts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final posts = await getAllTasks();
        emit(postsToState(posts));
      } else {
        emit(const ErrorPostsState(message: 'Unknown event'));
      }
    });
  }
  String failureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return UNKNOWN_FAILURE_MESSAGE;
    }
  }

  PostsState postsToState(Either<Failure, List<TaskEntity>> either) {
    return either.fold(
        (failure) => ErrorPostsState(message: failureMessage(failure)),
        (posts) => LoadedPostsState(posts: posts));
  }
}

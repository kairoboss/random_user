import 'package:api_practice/data/api_repo/user_api.dart';
import 'package:api_practice/data/api_repo/user_repo.dart';
import 'package:api_practice/data/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final UserRepository _userRepository = UserRepository();
    on<GetUserList>((event, emit) async {
      try {
        emit(UserLoading());
        final userList = await _userRepository.fetchUserList();
        emit(UserLoaded(userList));
      } catch (e) {
        throw UserError(e.toString());
      }
    });
  }
}

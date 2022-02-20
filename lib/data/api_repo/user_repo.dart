import 'package:api_practice/data/api_repo/user_api.dart';
import 'package:api_practice/data/model/user_model.dart';

class UserRepository {
  final UserApi _userApi = UserApi();

  Future<UserModel> fetchUserList() {
    return _userApi.fetchUserList();
  }
}

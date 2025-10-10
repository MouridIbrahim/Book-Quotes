
import 'package:bookquotes/features/user/Data/dataSources/userRemote.dart';

import 'package:bookquotes/features/user/Data/repositories/repository_imp.dart';
import 'package:bookquotes/features/user/domain/entities/User.dart';

import 'package:http/http.dart' as http;

void main() async {
  final client = http.Client();
  final remote = UserRemoteDataSourceImpl(client: client);
  final repo = UserRepositoryImpl(remoteDataSource: remote);

  final user = User(username: 'yahya', email: 'yahya@gmail.com');
  final result = await repo.addUser(user);

  result.fold(
    (failure) => print('❌ Failed: ${failure.message}'),
    (user) => print('✅ User added: ${user.username}'),
  );
}

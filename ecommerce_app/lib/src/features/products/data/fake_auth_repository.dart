import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeAuthRepo {
  final _authState = InMemoryStore<AppUser?>(null);

  Stream<AppUser?> authStateChanges() => _authState.stream;
  AppUser? get currentUser => _authState.value;

  // Stream<AppUser?> authStateChanges() => Stream.value(null);
  // AppUser? get currentUser => null;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    // required String email,
    // required String password,
    // }) async {
    // await Future.delayed(const Duration(seconds: 3));
    // throw Exception('Connection failed');
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  Future<void> signOut() async {
    // await Future.delayed(const Duration(seconds: 3));
    // throw Exception('Connection failed');
    _authState.value = null;
  }

  void _createNewUser(String email) {
    // note: the uid could be any unique string. Here we simply reverse the email.
    _authState.value =
        AppUser(uid: email.split('').reversed.join(), email: email);
  }

  void dispose() => _authState.close();
}

final authRepoProvider = Provider<FakeAuthRepo>((ref) {
  final auth = FakeAuthRepo();
  ref.onDispose(() => auth.dispose());
  return auth;
});

final authStateChangeProvider = StreamProvider<AppUser?>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return authRepo.authStateChanges();
});

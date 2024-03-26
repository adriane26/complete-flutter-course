import 'package:ecommerce_app/src/features/products/data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));
  final FakeAuthRepo authRepository;

  Future<void> signOut() async {
    // set state to loading
    // sign out (using auth repository)
    // if success, set state to data
    // if error, set state to error
    try {
      state = const AsyncValue<void>.loading();
      await authRepository.signOut();
      state = const AsyncValue<void>.data(null);
    } catch (e, st) {
      state = AsyncValue<void>.error(e, st);
    }
  }
}

final accountScreenControllerProvider = StateNotifierProvider.autoDispose<
    AccountScreenController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepoProvider);
  return AccountScreenController(
    authRepository: authRepository,
  );
});

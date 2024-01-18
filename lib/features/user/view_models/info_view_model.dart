import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/user/view_models/users_view_model.dart';

class InfoViewModel extends AsyncNotifier {
  @override
  FutureOr build() {}

  Future<void> uploadBio(String bio) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await ref.read(userProvier.notifier).onUserBioUpdate(bio);
      },
    );
  }

  Future<void> uploadLink(String link) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await ref.read(userProvier.notifier).onUserLinkUpdate(link);
      },
    );
  }
}

final userInfoProvider = AsyncNotifierProvider<InfoViewModel, void>(
  () => InfoViewModel(),
);

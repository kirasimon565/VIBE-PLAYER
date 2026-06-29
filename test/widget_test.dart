import 'package:flutter_test/flutter_test.dart';

import 'package:vibe_player/main.dart';
import 'package:provider/provider.dart';
import 'package:vibe_player/providers/theme_provider.dart';
import 'package:vibe_player/providers/media_provider.dart';
import 'package:vibe_player/providers/playlist_provider.dart';
import 'package:vibe_player/providers/user_provider.dart';
import 'package:vibe_player/services/playback_service.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => MediaProvider()),
          ChangeNotifierProvider(create: (_) => PlaylistProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => PlaybackService()),
        ],
        child: const VibeApp(),
      ),
    );

    // Initial splash
    expect(find.text('VIBE'), findsOneWidget);
  });
}

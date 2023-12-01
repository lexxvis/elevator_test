import 'package:elevator_test/config/routers/transition_animation.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/views/floors_page.dart';
import '../../presentation/views/house_page.dart';
import '../../presentation/views/logo_page.dart';

///
/// routing configuration
///
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    /// logo screen, default
    GoRoute(
      name: 'logo',
      path: "/",
      builder: (context, state) => const LogoPage(),
    ),
    GoRoute(
      /// house list screen
        name: 'house',
        path: "/house",
        pageBuilder: (context, state) =>
            TransitionAnimation(key: state.pageKey, child: const HousePage())),
    GoRoute(
      /// floor  screen, pass the data [name], [floor counter]
        name: 'floors',
        path: "/floors/:name/:floorsCounter",
        pageBuilder: (context, state) => TransitionAnimation(
            key: state.pageKey,
            child: FloorsPage(
              name: state.pathParameters['name'],
              floorsCounter: int.parse(state.pathParameters['floorsCounter']!),
            ))),
  ],
);

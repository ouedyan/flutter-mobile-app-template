import 'package:auto_route/auto_route.dart';
import '../ui/screens/home/home.dart';


// @CupertinoAutoRouter
// @MaterialAutoRouter
// @CustomAutoRouter
@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route,Screen',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(path: '/', page: HomeScreen, initial: true),
    RedirectRoute(path: '*', redirectTo: '/main')
  ],
)
class $AppRouter {}

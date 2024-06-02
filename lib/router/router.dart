import 'package:go_router/go_router.dart';
import 'package:meditation/models/functions_model.dart';
import 'package:meditation/pages/functions_page.dart';
import 'package:meditation/pages/main_pages/home_page.dart';
import 'package:meditation/router/route_names.dart';

class RouterClass {
  final router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        name: RouteNames.home,
        path: "/",
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        name: RouteNames.functions,
        path: "/functions",
        builder: (context, state) {
          final FunctionsData functionsData = state.extra as FunctionsData;

          return Functionspage(
            functionsData: functionsData,
          );
        },
      ),
    ],
  );
}

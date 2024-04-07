import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app_admin/src/blocs/authentication_bloc/authentication_bloc.dart';

import '../modules/auth/Views/login_screen.dart';
import '../modules/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import '../modules/base/Views/base_screen.dart';
import '../modules/home/Views/home_screen.dart';
import '../modules/splash/Views/splash_screen.dart';

final _navKey = GlobalKey<NavigatorState>();
final _shellNAvigationKey = GlobalKey<NavigatorState>();

GoRouter router(AuthenticationBloc authBloc) {
  return GoRouter(
      navigatorKey: _navKey,
      initialLocation: '/',
      redirect: (context, state) {
        if (authBloc.state.status == AuthenticationStatus.unknown) {
          return '/';
        }
      },
      routes: [
        ShellRoute(
            navigatorKey: _shellNAvigationKey,
            builder: (context, state, child) {
              if (state.fullPath == '/login' || state.fullPath == '/') {
                return child;
              } else {
                return BaseScreen(child);
              }
            },
            routes: [
              GoRoute(
                  path: '/',
                  builder: (context, state) =>
                      BlocProvider<AuthenticationBloc>.value(
                        value: BlocProvider.of<AuthenticationBloc>(context),
                        child: SplashScreen(),
                      )),
              GoRoute(
                  path: '/login',
                  builder: (context, state) =>
                      BlocProvider<AuthenticationBloc>.value(
                        value: BlocProvider.of<AuthenticationBloc>(context),
                        child: BlocProvider<SignInBloc>(
                          create: (context) => SignInBloc(context
                              .read<AuthenticationBloc>()
                              .userRepository),
                          child: const SignInScreen(),
                        ),
                      )),
              GoRoute(
                  path: '/home',
                  builder: (context, state) =>
                      BlocProvider<AuthenticationBloc>.value(
                        value: BlocProvider.of<AuthenticationBloc>(context),
                        child: HomeScreen(),
                      ))
            ])
      ]);
}

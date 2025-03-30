enum AppRoute {
  home(path: '/home'),
  inventary(path: '/inventary');

  final String path;
  const AppRoute({required this.path});
}

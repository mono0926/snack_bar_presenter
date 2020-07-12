import 'package:example/home_page.dart';
import 'package:example/pages/basic_page.dart';
import 'package:example/pages/list_detail_page/grid_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recase/recase.dart';

final routerProvider = Provider((_) => _Router());

class _Router {
  final Map<String, WidgetBuilder> pushRoutes = {
    HomePage.routeName: (_) => const HomePage(),
    BasicPage.routeName: (_) => const BasicPage(),
    GridPage.routeName: (_) => const GridPage(),
  };

  Route onGenerateRoute(RouteSettings settings) {
    final pushPage = pushRoutes[settings.name];
    return MaterialPageRoute<void>(
      settings: settings,
      builder: pushPage,
    );
  }
}

String pascalCaseFromRouteName(String name) => name.substring(1).pascalCase;

@immutable
class PageInfo {
  PageInfo({
    @required this.routeName,
    String pageName,
    this.subTitle,
  }) : pageName = pageName ?? pascalCaseFromRouteName(routeName);

  final String routeName;
  final String pageName;
  final String subTitle;

  static List<PageInfo> get all => [
        BasicPage.routeName,
        GridPage.routeName,
      ].map((rn) => PageInfo(routeName: rn)).toList();
}

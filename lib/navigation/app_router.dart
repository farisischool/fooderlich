
import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/screens.dart';

class AppRouter extends RouterDelegate with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  final AppStateManager appStateManager;
  final GroceryManager groceryManager;
  final ProfileManager profileManager;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouter({required this.appStateManager, required this.groceryManager, required this.profileManager}) : navigatorKey = GlobalKey<NavigatorState>(){
    //todo: add listener
    appStateManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context)
  {
    return Navigator(
      key:navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        //todo: add splash screen
        if(!appStateManager.isInitialized) SplashScreen.page(),
        //todo: add loginScreen
        if(appStateManager.isInitialized && !appStateManager.isLoggedIn) LoginScreen.page(),
        //todo: add OnboardingScreen
        if(appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete) OnboardingScreen.page(),
        //todo: add Home,
        if(appStateManager.isOnboardingComplete) Home.page(appStateManager.isSelectedTab),
        //todo: Create new item
        if(groceryManager.isCreatingNewItem)
          GroceryItemScreen.page(
              onCreate: (item){
                groceryManager.addItem(item);
              },
              onUpdate: (item,index){

              }
          ),

        //todo: Select GroceryItemScreen
        if(groceryManager.selectedIndex !=-1)
          GroceryItemScreen.page(
              item: groceryManager.selectedGroceryItem,
              index: groceryManager.selectedIndex,
              onCreate: (_) {

              }, onUpdate: (item, index) {
            groceryManager.updateItem(item, index);
          }),
        //todo: Add profile Screen
        if(profileManager.didSelectUser)
          ProfileScreen.page(profileManager.getUser),
        //todo: add webview screen
        if(profileManager.didTapOnRaywenderlich)
          WebViewScreen.page(),
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result)
  {
    if(!route.didPop(result)){
      return false;
    }

    //todo: Handle Onboarding and splash
    if(route.settings.name== FooderlichPages.onboardingPath) {
      appStateManager.logout();
    }

    //todo: Handle state when user closes grocery item screen
    if(route.settings.name==FooderlichPages.groceryItemDetails){
      groceryManager.groceryItemTapped(-1);
    }

    //todo: handle state when user closes profile screen
    if(route.settings.name==FooderlichPages.profilePath){
      profileManager.tapOnProfile(false);
    }
    //todo: handle state when user close webview screen
    if(route.settings.name==FooderlichPages.raywenderlich){
      profileManager.tapOnRaywenderlich(false);
    }

    return true;
  }

  // @override
  // Future<void> setNewRouterPath(configuration) async => null;

  @override
  void dispose()
  {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }



}
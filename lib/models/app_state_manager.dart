import 'dart:async';

import 'package:flutter/material.dart';

class FooderlichTab {
  static const int explorer=0;
  static const int recipes=1;
  static const int toBuy=2;
}

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  bool _loggedIn = false;
  bool _onboardingComplete = false;
  int _selectedTab = FooderlichTab.explorer;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get isSelectedTab => _selectedTab;

  //todo: Add initializedApp
  void initialedApp()
  {
    Timer(const Duration(milliseconds: 2000),(){
      _initialized=true;
      notifyListeners();
    });
  }
  //todo: add login
 void login(String username, String password){
    _loggedIn=true;
    notifyListeners();
 }
  //todo: add complete onboarding
 void completeOnBoarding()
 {
   _onboardingComplete=true;
   notifyListeners();
 }
//todo: add goToTab
 void goToTab(index)
 {
   _selectedTab=index;
   notifyListeners();
 }
//todo: add goToRecipes
 void goToRecipes()
 {
   _selectedTab=FooderlichTab.recipes;
   notifyListeners();
 }

  //todo: add logout
  void logout()
  {
    _loggedIn=false;
    _onboardingComplete=false;
    _initialized=false;
    _selectedTab=0;

    initialedApp();
    notifyListeners();
  }
}
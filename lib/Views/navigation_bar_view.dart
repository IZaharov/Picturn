import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturn/ViewModels/post_list_view_model.dart';
import 'package:picturn/ViewModels/post_view_model.dart';
import 'package:picturn/ViewModels/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../runtime_data.dart';
import 'AddingPost/adding_post_view.dart';
import 'Post/post_list_view.dart';
import 'Profile/profile_view.dart';

class NavigationBarView extends StatefulWidget {
  //List<Widget> listTab;

  //NavigationBarView(this.listTab);

  State<StatefulWidget> createState() {
    //return _NavigationBarView(this.listTab);
    return _NavigationBarView();
  }
}

class _NavigationBarView extends State<NavigationBarView> {
  List<Widget> listTab = [
    ChangeNotifierProvider(
      create: (context) => PostListViewModel(PostListType.all),
      child: PostListView(),
    ),
    AddingPostView(),
    ProfileView(
      ProfileViewModel(RuntimeData.currentUserProfileViewModel.profile),
    ),
  ];
  var navigationBarViewModel = NavigationBarViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => navigationBarViewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<NavigationBarViewModel>(
          builder: (context, navigationBarVM, _) {
            return IndexedStack(
              children: listTab,
              index: navigationBarVM.currentIndex,
            );
          },
        ),
        bottomNavigationBar: SizedBox(
          height: 54,
          child: Consumer<NavigationBarViewModel>(
              builder: (context, navigationBarVM, _) {
            return BottomNavigationBar(
              currentIndex: navigationBarViewModel.currentIndex,
              showUnselectedLabels: false,
              onTap: (newIndex) => setState(
                  () => navigationBarViewModel.currentIndex = newIndex),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_filled,
                      size: 20,
                    ),
                    label: 'Лента'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add_box_outlined,
                      size: 20,
                    ),
                    label: 'Добавить'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_box,
                      size: 20,
                    ),
                    label: 'Профиль')
              ],
            );
          }),
        ),
      ),
    );
  }
}

class NavigationBarViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  set currentIndex(int value) {
    this._currentIndex = value;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;
}

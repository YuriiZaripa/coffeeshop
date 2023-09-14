import 'dart:core';

import 'package:flutter/material.dart';

import '../repository/drinks/models/item.dart';
import '../widgets/home_bottom_bar.dart';
import '../widgets/items_widget.dart';

class DrinksCatalogScreen extends StatefulWidget {
  final List<Item> _drinks;
  DrinksCatalogScreen(this._drinks);

  @override
  State<DrinksCatalogScreen> createState() => _DrinksCatalogScreenState(_drinks);
}

class _DrinksCatalogScreenState extends State<DrinksCatalogScreen>
    with SingleTickerProviderStateMixin {
  final List<Item> _drinks;
  late TabController _tabController;
  late Map<String,List<Item>> _itemsCategoryMap;
  late List<String> _categories;

  _DrinksCatalogScreenState(this._drinks);

  @override
  void initState() {
    super.initState();
    _initData();
    _tabController = TabController(length: _categories.length, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  void _initData() {
    _itemsCategoryMap = {};
      _drinks.forEach((element) {
        if (_itemsCategoryMap.containsKey(element.itemType)) {
          _itemsCategoryMap[element.itemType]?.add(element);
        } else {
          _itemsCategoryMap.putIfAbsent(element.itemType, () => [element]);
        }
      });
      _categories = List.of(_itemsCategoryMap.keys);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.sort_rounded,
                        color: Colors.white.withOpacity(0.5),
                        size: 35,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white.withOpacity(0.5),
                        size: 35,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'It`s a Great Day for Coffee!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 50, 54, 56),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Find your coffee',
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.5)),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.white.withOpacity(0.5),
                        ))),
              ),
              TabBar(
                  controller: _tabController,
                  labelColor: Color(0xFFE57734),
                  unselectedLabelColor: Colors.white.withOpacity(0.5),
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 3,
                        color: Color(0xFFE57734),
                      ),
                      insets: EdgeInsets.symmetric(horizontal: 16)),
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  labelPadding: EdgeInsets.symmetric(horizontal: 18),
                  tabs: _categories.map((e) => Tab(text: e)).toList(),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: [
                  for(String category in _categories)
                  ItemsWidget(_itemsCategoryMap[category]!),
                ][_tabController.index],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomBar(),
    );
  }
}

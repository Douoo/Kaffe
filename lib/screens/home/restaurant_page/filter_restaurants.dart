import 'package:flutter/material.dart';
import 'package:kaffe/components/button.dart';
import 'package:kaffe/models/filter.dart';
import 'package:kaffe/utils/constants.dart';
import '../../../models/values.dart' as hardcoded;

import 'dart:math' as math;

class FilterRestaurant extends StatefulWidget {
  static const String route = '/filter';
  final Filter filter;
  const FilterRestaurant({Key key, this.filter}) : super(key: key);

  @override
  _FilterRestaurantState createState() =>
      _FilterRestaurantState(filter: filter);
}

class _FilterRestaurantState extends State<FilterRestaurant> {
  _FilterRestaurantState({Filter filter}) {
    if (filter != null && !filter.isDefault) {
      _category = filter.category;
      _city = filter.city;
      _price = filter.price;
      _sort = filter.sort;
    }
  }

  String _category;
  String _city;
  int _price;
  String _sort;

  Widget _buildDropdown<T>(
    List labels,
    List values,
    dynamic selected,
    FilterChangedCallback<T> onChanged,
  ) {
    final items = [
      for (var i = 0; i < values.length; i++)
        DropdownMenuItem<T>(value: values[i], child: Text(labels[i])),
    ];
    return DropdownButton<T>(
      items: items,
      isExpanded: true,
      value: selected,
      onChanged: onChanged,
    );
  }

  Widget _buildDropdownRow<T>({
    List<T> values,
    List<String> labels,
    T selected,
    IconData icon,
    FilterChangedCallback<T> onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(
            icon,
            color: kPrimaryColor,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
            child: _buildDropdown<T>(labels, values, selected, onChanged),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown({
    String selected,
    FilterChangedCallback<String> onChanged,
  }) {
    return _buildDropdownRow<String>(
      labels: ['Select Category', ...hardcoded.categories],
      values: [null, ...hardcoded.categories],
      selected: selected,
      icon: Icons.fastfood,
      onChanged: onChanged,
    );
  }

  Widget _buildCityDropdown({
    String selected,
    FilterChangedCallback<String> onChanged,
  }) {
    return _buildDropdownRow<String>(
      labels: ['Any Location', ...hardcoded.cities],
      values: [null, ...hardcoded.cities],
      selected: selected,
      icon: Icons.location_on,
      onChanged: onChanged,
    );
  }

  Widget _buildPriceDropdown({
    int selected,
    FilterChangedCallback<int> onChanged,
  }) {
    return _buildDropdownRow<int>(
      labels: ['Any Price', '\$', '\$\$', '\$\$\$', '\$\$\$\$'],
      values: [null, 1, 2, 3, 4],
      selected: selected,
      icon: Icons.monetization_on,
      onChanged: onChanged,
    );
  }

  Widget _buildSortDropdown({
    String selected,
    FilterChangedCallback<String> onChanged,
  }) {
    return _buildDropdownRow<String>(
      labels: ['Rating', 'Reviews'],
      values: ['avgRating', 'numRatings'],
      selected: selected,
      icon: Icons.sort,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Filter",
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context, null),
            icon: Icon(
              Icons.close,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: math.min(MediaQuery.of(context).size.width, 740),
            height: math.min(MediaQuery.of(context).size.height, 200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCityDropdown(
                    selected: _city,
                    onChanged: (String value) {
                      setState(() {
                        _city = value;
                      });
                    }),
                _buildCategoryDropdown(
                    selected: _category,
                    onChanged: (String value) {
                      setState(() {
                        _category = value;
                      });
                    }),
                _buildPriceDropdown(
                    selected: _price,
                    onChanged: (int value) {
                      setState(() {
                        _price = value;
                      });
                    }),
                _buildSortDropdown(
                    selected: _sort ?? 'avgRating',
                    onChanged: (String value) {
                      setState(() {
                        _sort = value;
                      });
                    }),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 140,
        child: Column(
          children: [
            TextButton.icon(
              onPressed: () => Navigator.pop(
                context,
                Filter(),
              ),
              icon: Icon(
                Icons.delete_outline_outlined,
                color: Colors.grey,
              ),
              label: Text('CLEAR ALL',
                  style: TextStyle(
                    color: Colors.grey,
                  )),
            ),
            RoundButton(
              onTap: () => Navigator.pop(
                  context,
                  Filter(
                    category: _category,
                    city: _city,
                    price: _price,
                    sort: _sort,
                  )),
              color: kPrimaryColor,
              textColor: kWhiteColor,
              title: "ACCEPT",
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HomePageAz extends StatefulWidget {
  const HomePageAz({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePageAz> {
  final ScrollController _scrollController = ScrollController();
  final List<String> _data = []; // This is your initial data
  final int _dataPerPage = 10; // Number of data to load per page
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Attach listener to scroll events
    _scrollController.addListener(_scrollListener);
    // Load initial data
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 100) {
      _loadData();
    }
  }

  // Simulated function to load data
  Future<void> _loadData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulated async data loading
      await Future.delayed(const Duration(seconds: 2));

      // Simulated adding new data
      List<String> newData = List.generate(
          _dataPerPage, (index) => 'Item ${_data.length + index + 1}');
      setState(() {
        _data.addAll(newData);
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lazy Loading Example'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _data.length + 1, // Add 1 for loading indicator
        itemBuilder: (context, index) {
          if (index < _data.length) {
            // Render actual data
            return ListTile(
              title: Text(_data[index]),
              subtitle: const Text('Azag.python'),
              onTap: () {
                print(_scrollController.position.pixels ==
                    _scrollController.position.maxScrollExtent);
                print(_scrollController.position.pixels);
                print(_scrollController.position.maxScrollExtent);
                print('');
              },
            );
          } else {
            // Render loading indicator at the end
            return _isLoading
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(); // Return empty container when not loading
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tokoonline/constans.dart'; // Ensure Palette is defined here
import 'package:tokoonline/users/depanpage.dart';
import 'package:tokoonline/users/kategoripage.dart'; // Ensure KategoriPage is imported here

// Define these variables or mock them
bool login = true; // Example
List<String> keranjanglist = []; // Example
int jmlnotif = 0; // Example

class Beranda extends StatefulWidget {
  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController!.addListener(_setActiveTabIndex);
  }

  void _setActiveTabIndex() {
    if (_tabController!.indexIsChanging) {
      setState(() {
        // Update state if necessary
      });
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.bg1, // Ensure this is defined
        title: TextField(
          onTap: () {
            Navigator.of(context).pushNamed('/cari');
          },
          readOnly: true,
          style: const TextStyle(fontSize: 15),
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search, color: Palette.orange),
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white),
            ),
            fillColor: const Color(0xfff3f3f4),
            filled: true,
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: login ? 5.0 : 15.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/keranjangusers',
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Stack(
                      children: [
                        const Icon(
                          Icons.shopping_cart,
                          size: 28.0,
                          color: Colors.white, // Ensure this is visible
                        ),
                        if (keranjanglist.isNotEmpty)
                          Positioned(
                            top: 2,
                            right: 4,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                keranjanglist.length.toString(),
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (login)
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      // Remove or comment out the line for NotifikasiPage if not used
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Stack(
                        children: [
                          const Icon(
                            Icons.notifications,
                            size: 28.0,
                            color: Colors.white, // Ensure this is visible
                          ),
                          if (jmlnotif > 0)
                            Positioned(
                              top: 2,
                              right: 4,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  jmlnotif.toString(),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
        actionsIconTheme: const IconThemeData(
          size: 26.0,
          color: Colors.white,
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Palette.orange,
          labelColor: Palette.orange,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Beranda'),
            Tab(text: 'Kategori'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          DepanPage(), // Removed const keyword
          KategoriPage(), // Removed const keyword
        ],
      ),
    );
  }
}

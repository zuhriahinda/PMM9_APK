import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'plant_description_page.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final int _totalItems = 3; // Total jumlah item pada BottomNavigationBar

  // Daftar nama produk
  final List<String> productNames = [
    "Jeruk Nipis",
    "Seledri",
    "Sereh",
    "plant 4",
    "plant 5",
    "plant 6",
    "plant 7",
    "plant 8",
    "plant 9",
    "plant 10"
  ];

  // Daftar path gambar produk
  final List<String> productImagePaths = [
    "images/jeruk.jpeg",
    "images/seledri.jpeg",
    "images/sereh.jpeg",
    "images/4.jpg",
    "images/4.jpg",
    "images/4.jpg",
    "images/4.jpg",
    "images/4.jpg",
    "images/4.jpg",
    "images/4.jpg",
  ];

  // Daftar deskripsi produk
  final List<String> productDescriptions = [
    "Description of plant 1",
    "Description of plant 2",
    "Description of plant 3",
    "Description of plant 4",
    "Description of plant 5",
    "Description of plant 6",
    "Description of plant 7",
    "Description of plant 8",
    "Description of plant 9",
    "Description of plant 10",
  ];

  List<String> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 255, 255, 255), // Ubah warna background menjadi putih

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 18),
            child: Row(
              children: [
                Container(
                  height: 55,
                  width: 350,
                  child: TextField(
                    onChanged: (value) {
                      searchByName(value);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CarouselSlider(
            items: [
              // List item carousel, contoh:
              Image.asset('images/3.jpg'),
              Image.asset('images/3.jpg'),
              Image.asset('images/3.jpg'),
            ],
            options: CarouselOptions(
              height: 200.0,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < _totalItems; i++)
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == i ? Colors.black : Colors.grey,
                  ),
                ),
            ],
          ),
          SizedBox(height: 20), // Spacer before product catalog
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: searchResults.isNotEmpty
                        ? searchResults.length
                        : productNames.length, // Jumlah item produk
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlantDescriptionPage(
                                name: searchResults.isNotEmpty
                                    ? searchResults[index]
                                    : productNames[index],
                                imagePath: searchResults.isNotEmpty
                                    ? productImagePaths[index]
                                    : productImagePaths[index],
                                description: searchResults.isNotEmpty
                                    ? productDescriptions[index]
                                    : productDescriptions[index],
                              ),
                            ),
                          );
                        },
                        child: ProductItem(
                          name: searchResults.isNotEmpty
                              ? searchResults[index]
                              : productNames[index],
                          imagePath: searchResults.isNotEmpty
                              ? productImagePaths[index]
                              : productImagePaths[index],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void searchByName(String query) {
    setState(() {
      if (query.isNotEmpty) {
        searchResults = productNames
            .where((name) => name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        searchResults.clear();
      }
    });
  }
}

class ProductItem extends StatelessWidget {
  final String name;
  final String imagePath;

  const ProductItem({Key? key, required this.name, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = ["라부부", "퉁퉁퉁퉁사후르"];
  // final List<String> _popularSearches = ["라부부", "퉁퉁퉁퉁사후르", "짱구", "도라에몽", "코난"];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.025),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.05,
                width: size.width * 0.95,
                child: Stack(
                  children: [
                    TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "검색어를 입력해주세요",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(189, 189, 189, 1),
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(189, 189, 189, 1),
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Iconify(
                            MaterialSymbols.cancel,
                            color: Color.fromRGBO(189, 189, 189, 1),
                          ),
                          onPressed: () {
                            _searchController.clear();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          SizedBox(
            height: size.height * 0.12, // Adjusted height for horizontal chips
            width: size.width * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "최근 검색어",
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                SizedBox(
                  height:
                      size.height *
                      0.05, // Adjust height as needed for horizontal chips
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _recentSearches.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color.fromRGBO(189, 189, 189, 1),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsGeometry.all(12),
                              child: Text(_recentSearches[index]),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _recentSearches.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "인기 검색어",
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

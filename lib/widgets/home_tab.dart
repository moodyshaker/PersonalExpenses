import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HomeTab extends StatelessWidget {
  final String name;
  final int selectedPage;
  final int pageNumber;
  final Function onPress;

  HomeTab({
    this.name,
    this.pageNumber,
    this.selectedPage,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    print('selected Page -> $selectedPage');
    return Expanded(
      child: GestureDetector(
        onTap: ()=> onPress(pageNumber),
        child: Container(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selectedPage == pageNumber ? Colors.black : Colors.grey,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 6.0,
              ),
              selectedPage == pageNumber
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      height: 4.0,
                      color: Colors.black,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

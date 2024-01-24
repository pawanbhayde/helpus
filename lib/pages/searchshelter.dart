import 'package:flutter/material.dart';
import 'package:helpus/widgets/custom_shalter_card.dart';

class SearchHomeShelter extends StatelessWidget {
  const SearchHomeShelter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: SizedBox(
              width: 100,
              child: Image(
                image: AssetImage('assets/images/helpus.png'),
                fit: BoxFit.cover,
              )),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // textfield
              SizedBox(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search Shelter',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              const LatestShalter(
                title: 'Shakti NGO Shelter Home',
                image: 'assets/images/ngo-banner-1.png',
                distance: '2.5 km',
              ),
              const LatestShalter(
                title: 'Homies NGO Shelter Home',
                image: 'assets/images/ngo-banner-2.png',
                distance: '3.5 km',
              ),
              const LatestShalter(
                title: 'UNEX NGO Shelter Home',
                image: 'assets/images/ngo-banner-3.png',
                distance: '4.5 km',
              ),
              const LatestShalter(
                title: 'Shakti NGO Shelter Home',
                image: 'assets/images/ngo-banner-1.png',
                distance: '2.5 km',
              ),
              const LatestShalter(
                title: 'Homies NGO Shelter Home',
                image: 'assets/images/ngo-banner-2.png',
                distance: '3.5 km',
              ),
              const LatestShalter(
                title: 'UNEX NGO Shelter Home',
                image: 'assets/images/ngo-banner-3.png',
                distance: '4.5 km',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:helpus/Widgets/custom_shalter_card.dart';
import 'package:helpus/auth/authentication.dart';
import 'package:helpus/auth/database.dart';
import 'package:helpus/pages/addhome.dart';
import 'package:helpus/pages/splash_screen.dart';
import 'package:helpus/widgets/custom_category_card.dart';
import 'package:helpus/widgets/custom_image_carousel.dart';
import 'package:helpus/widgets/custom_near_shelter_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign Out'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('This will sign you out of the app'),
                  Text('Are you sure?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Logout'),
                onPressed: () async {
                  await Authentication.signOut(context);
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplashScreen(),
                      ),
                      (route) => false);
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      //appbar
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: const SizedBox(
            width: 150,
            child: Image(
              image: AssetImage('assets/images/helpus.png'),
              fit: BoxFit.cover,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              iconSize: 25,
              onPressed: () {
                _showMyDialog();
              },
              icon: const Icon(Icons.logout, color: Colors.black),
            ),
          )
        ],
      ),

      //body
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),

            //image carousel
            CarouselWithDotsPage(imgList: const [
              'assets/images/1.jpg',
              'assets/images/2.jpg',
              'assets/images/3.jpg',
            ]),
            SizedBox(
              height: size.height * 0.03,
            ),

            //Donation Categories
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Donation Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeCategory(title: 'Food', image: 'assets/images/cat-1.png'),
                HomeCategory(title: 'Cloths', image: 'assets/images/cat-2.png'),
                HomeCategory(
                    title: 'Charity', image: 'assets/images/cat-3.png'),
                HomeCategory(
                    title: 'Education', image: 'assets/images/cat-4.png'),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),

            //Nearest Shelter Homes
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nearest Shelter Homes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            //nearest shelter homes cards
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SizedBox(
                  height: 180,
                  child: StreamBuilder(
                    stream: DatabaseService.getShelter(),
                    builder: (context, snapshot) {
                      // ignore: avoid_print
                      print(snapshot.data);
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return NeedFirstBox(
                              title: snapshot.data?[index]['name'],
                              image: snapshot.data?[index]['image'],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Latest Shelter Homes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            LatestShalter(
              title: 'Shakti NGO Shelter Home',
              image: 'assets/images/ngo-banner-1.png',
              distance: '2.5 km',
              onPressed: () {},
            ),
            LatestShalter(
              title: 'Homies NGO Shelter Home',
              image: 'assets/images/ngo-banner-2.png',
              distance: '3.5 km',
              onPressed: () {},
            ),
            LatestShalter(
              title: 'UNEX NGO Shelter Home',
              image: 'assets/images/ngo-banner-3.png',
              distance: '4.5 km',
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff395EE7),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddHomeShelter();
          }));
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}

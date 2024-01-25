import 'package:flutter/material.dart';
import 'package:helpus/auth/authentication.dart';
import 'package:helpus/model/user.dart';
import 'package:helpus/pages/change_password.dart';
import 'package:helpus/pages/edit_profile.dart';
import 'package:helpus/pages/help&support.dart';
import 'package:helpus/pages/splash_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? profile;

  @override
  void initState() {
    super.initState();

    Authentication.getCurrentUser().then((fetchedProfile) {
      setState(() {
        profile = fetchedProfile;
        print(profile);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    //
    //get current user
    final userProfile = Authentication.getCurrentUser();

    print(userProfile);

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
      appBar: AppBar(
        backgroundColor: const Color(0xffF3F2F5),
        title: const SizedBox(
            width: 150,
            child: Image(
              image: AssetImage('assets/images/helpus.png'),
              fit: BoxFit.cover,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: const Color(0xffF3F2F5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: user!.userMetadata?['avatar_url'] == null
                            ? const Icon(
                                Iconsax.user,
                                size: 50,
                              )
                            : Image.network(
                                user.userMetadata?['avatar_url'],
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      user.userMetadata?['name'] ?? profile?.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user.userMetadata?['email'] ?? profile?.email,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditProfileScreen();
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        side: const BorderSide(width: 1.0, color: Colors.black),
                        backgroundColor: const Color(0xffF3F2F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(100, 40),
                      ),
                      child: const Text('Edit Profile',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Custom_Profile_Item(
                title: 'Change Password',
                icon: Iconsax.lock,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ChangePasswod();
                      },
                    ),
                  );
                },
              ),
              Custom_Profile_Item(
                title: 'Help & Support',
                icon: Iconsax.support,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HelpAndSupport();
                      },
                    ),
                  );
                },
              ),
              Custom_Profile_Item(
                title: 'Logut',
                icon: Iconsax.logout,
                onPressed: () {
                  _showMyDialog();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Custom_Profile_Item extends StatelessWidget {
  const Custom_Profile_Item({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color(0xffF3F2F5),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Icon(
              Iconsax.arrow_right_3,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

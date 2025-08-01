import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signin_signup/Controllers/auth_controllers.dart';
import 'package:signin_signup/Controllers/home_page_controller.dart';
import 'package:signin_signup/Widgets/my_button.dart';
import 'package:signin_signup/Widgets/my_text_form_field.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomePageController homePageController = Get.put(HomePageController());

  AuthControllers authControllers = Get.put(AuthControllers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: MyTextFormField(
                controller: homePageController.nameController,
                hintText: 'Name',
                icon: Icon(Icons.person),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: MyTextFormField(
                controller: homePageController.userNameController,
                hintText: 'User Name',
                icon: Icon(Icons.person),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: MyTextFormField(
                controller: homePageController.emailController,
                hintText: 'Email',
                readOnly: true,
                icon: Icon(Icons.email),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: MyTextFormField(
                controller: homePageController.dobController,
                hintText: 'Date of Birth',
                icon: Icon(Icons.calendar_month),
              ),
            ),
            Obx(
              () => homePageController.isLodingData.value
                  ? SizedBox(
                      height: 50,
                      child: Center(child: CircularProgressIndicator()))
                  : SizedBox(
                      height: 50,
                    ),
            ),
            Obx(
              () => homePageController.isUpdating.value
                  ? CircularProgressIndicator()
                  : MyButton(
                      buttonName: 'Update',
                      onTap: () {
                        homePageController.updateProfile();
                      },
                    ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => homePageController.isDeleting.value
                  ? CircularProgressIndicator()
                  : MyButton(
                      buttonName: 'Delete ',
                      onTap: () {
                        homePageController.deleteFields();
                      },
                    ),
            ),
            Spacer(),
            MyButton(
              buttonName: 'LogOut Account',
              onTap: () {
                authControllers.logout();
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}












// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:signin_signup/Controllers/auth_controllers.dart';
// import 'package:signin_signup/models/user_model.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// AuthControllers authControllers = Get.put(AuthControllers());

// class _HomePageState extends State<HomePage> {
//   UserModel? currentUser;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadUser();
//   }

//   Future<void> loadUser() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     final uid = sp.getString('uid');

//     if (uid != null && uid.isNotEmpty) {
//       final userDoc =
//           await FirebaseFirestore.instance.collection('users').doc(uid).get();

//       if (userDoc.exists) {
//         currentUser = UserModel.fromJson(userDoc.data()!);
//       }
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : currentUser != null
//               ? Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         StreamBuilder(
//                           stream: FirebaseFirestore.instance
//                               .collection('users')
//                               .snapshots(),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.active) {
//                               if (snapshot.hasData) {
//                                 return ListView.builder(
//                                   shrinkWrap: true,
//                                   physics: NeverScrollableScrollPhysics(),
//                                   itemCount: snapshot.data!.docs.length,
//                                   itemBuilder: (context, index) {
//                                     return Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(vertical: 20),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           CircleAvatar(
//                                             radius: 25,
//                                             backgroundColor:
//                                                 Colors.grey.shade300,
//                                             backgroundImage: AssetImage(snapshot
//                                                 .data!
//                                                 .docs[index]['userImage']),
//                                           ),
//                                           Text(
//                                               'Name: ${snapshot.data!.docs[index]['name']}'),
//                                           Text(
//                                               'User Name: ${snapshot.data!.docs[index]['userName']}'),
//                                           Text(
//                                               'Email: ${snapshot.data!.docs[index]['userEmail']}'),
//                                           Text(
//                                               'DoB: ${(snapshot.data!.docs[index]['dob']).toDate().toLocal().toString().split(' ')[0]}'),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 );
//                               } else if (snapshot.hasError) {
//                                 return Center(
//                                     child: Text(snapshot.hasError.toString()));
//                               } else {
//                                 return Text('There is No Data');
//                               }
//                             } else {
//                               return Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             }
//                           },
//                         ),
//                         // CircleAvatar(
//                         //   radius: 50,
//                         //   backgroundImage: NetworkImage(currentUser!.userImage),
//                         // ),
//                         // const SizedBox(height: 16),
//                         // Text(
//                         //   currentUser!.name,
//                         //   style: const TextStyle(
//                         //       fontSize: 24, fontWeight: FontWeight.bold),
//                         // ),
//                         // Text(currentUser!.userEmail),
//                         // Text("Username: ${currentUser!.userName}"),
//                         // Text("DOB: ${currentUser!.dob.toDate()}"),
//                         // SizedBox(
//                         //   height: 50,
//                         // ),
//                         ElevatedButton(
//                             onPressed: () {
//                               authControllers.logout();
//                             },
//                             child: Text("LogOut")),
//                       ],
//                     ),
//                   ),
//                 )
//               : Center(
//                   child: InkWell(
//                       onTap: () {
//                         authControllers.logout();
//                       },
//                       child: Text('User data not found'))),
//     );
//   }
// }

























// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:signin_signup/Controllers/auth_controllers.dart';

// class HomePage extends StatefulWidget {
//   HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// AuthControllers authControllers = Get.put(AuthControllers());

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           "My Dashboard",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.menu, color: Colors.black),
//           onPressed: () {
//             authControllers.logout();
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Greeting
//             const Text(
//               "Hello, Asim 👋",
//               style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               "Welcome back! Here's what's new today.",
//               style: TextStyle(fontSize: 16, color: Colors.grey),
//             ),

//             const SizedBox(height: 20),

//             // Search bar
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Search...",
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding: const EdgeInsets.symmetric(vertical: 0),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Section title
//             const Text(
//               "Quick Actions",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//             ),

//             const SizedBox(height: 10),

//             // Grid of feature cards
//             GridView.count(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               crossAxisCount: 2,
//               mainAxisSpacing: 12,
//               crossAxisSpacing: 12,
//               childAspectRatio: 1.2,
//               children: [
//                 _buildFeatureCard(Icons.person, "Profile", Colors.blue),
//                 _buildFeatureCard(Icons.message, "Messages", Colors.green),
//                 _buildFeatureCard(Icons.settings, "Settings", Colors.orange),
//                 _buildFeatureCard(
//                     Icons.notifications, "Notifications", Colors.red),
//               ],
//             ),

//             const SizedBox(height: 20),

//             // News / updates section
//             const Text(
//               "Latest Updates",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 10),
//             _buildUpdateCard(
//                 "New Feature Released!",
//                 "We’ve added dark mode support in the latest version of the app.",
//                 Colors.deepPurple),
//             const SizedBox(height: 10),
//             _buildUpdateCard(
//                 "Weekly Summary",
//                 "Your activity report for this week is ready to view.",
//                 Colors.teal),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFeatureCard(IconData icon, String title, Color color) {
//     return GestureDetector(
//       onTap: () => Get.snackbar("Clicked", "You clicked on $title"),
//       child: Container(
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               backgroundColor: color,
//               radius: 28,
//               child: Icon(icon, color: Colors.white, size: 28),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               title,
//               style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildUpdateCard(String title, String subtitle, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: color,
//             child: const Icon(Icons.star, color: Colors.white),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title,
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 4),
//                 Text(subtitle,
//                     style:
//                         const TextStyle(fontSize: 14, color: Colors.black54)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:blood_donation/models/post/post.dart';
import 'package:blood_donation/pages/profile.dart';
import 'package:blood_donation/services/auth.dart';
import 'package:blood_donation/services/firestore.dart';
import 'package:blood_donation/shared/constants.dart';
import 'package:blood_donation/shared/decorations.dart';
import 'package:blood_donation/shared/widgets/loading.dart';
import 'package:blood_donation/shared/widgets/post_list.dart';
import 'package:blood_donation/shared/widgets/post_panel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  final search = TextEditingController();
  bool loading = false;
  bool isFiltering = false;

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _showAPostPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) => const PostPanel(),
      );
    }

    return StreamBuilder<List<Post>?>(
        initialData: const [],
        stream: isFiltering
            ? FirestoreService().filteredPosts(
                "${search.text[0].toUpperCase()}${search.text.substring(1).toLowerCase()}")
            : FirestoreService().posts,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (snapshot.hasData) {
            List<Post>? posts = snapshot.data;

            // inspect(posts);
            return loading
                ? const Center(
                    child: Loading(),
                  )
                : Container(
                    decoration: linearDecoration,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        title: const Text("HOME",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3.5)),
                        elevation: 0.0,
                        centerTitle: true,
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const ProfilePage()));
                              },
                              icon: const Icon(
                                Icons.person_rounded,
                                size: 30.0,
                                color: Colors.white,
                              ))
                        ],
                        leading: IconButton(
                          onPressed: () async {
                            await _auth.signOutDonor();
                          },
                          icon: const Icon(
                            Icons.logout_rounded,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      body: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(bottom: 12.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 12.0),
                                color: Colors.transparent,
                                child: TextFormField(
                                  controller: search,
                                  decoration: inputDecoration.copyWith(
                                    hintText: "Search Location Exactly",
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isFiltering = !isFiltering;
                                            if (isFiltering == false) {
                                              search.clear();
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          isFiltering
                                              ? Icons.delete_rounded
                                              : Icons.search_rounded,
                                          color: Colors.red,
                                          size: 26.0,
                                        )),
                                  ),
                                  style: inputStyle,
                                  autocorrect: true,
                                  keyboardType: TextInputType.text,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                )),
                            PostList(posts: posts),
                          ],
                        ),
                      ),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () => _showAPostPanel(),
                        backgroundColor: secondColor,
                        elevation: 0.0,
                        child: const Icon(
                          Icons.post_add_rounded,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
          } else {
            return const Center(
              child: Loading(),
            );
          }
        });
  }
}

import 'package:cs411_project2/view/widgets/dialog_with_tabs.dart';
import 'package:cs411_project2/view/widgets/bookmark_widget.dart';
import 'package:cs411_project2/view/widgets/folder_widget.dart';
import 'package:cs411_project2/viewmodel/auth_cubit/auth_cubit.dart';
import 'package:cs411_project2/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user/user_info.dart';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({super.key});

  @override
  State<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();
    final registerFormKey = GlobalKey<FormState>();
    return BlocConsumer<BookmarksCubit, BookmarksState>(
      bloc: context.read<BookmarksCubit>()..setFilters(),
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            centerTitle: true,
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                    const SizedBox(width: 10),
                    IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[100],
                        ),
                        height: 50,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a URL",
                            ),
                          ),
                        ),
                      ),
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return IconButton(
                            onPressed: () {
                              UserInfo.loggedUser != null
                                  ? _buildLoginDialog(context, loginFormKey)
                                  : _buildRegisterDialog(
                                      context, registerFormKey);
                            },
                            icon: const Icon(Icons.person));
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children:
                            context.read<BookmarksCubit>().temp.map((bookmark) {
                          return FolderWidget(
                            bookmarks:
                                context.read<BookmarksCubit>().myBookmarks,
                            folderName: bookmark.name!,
                          );
                        }).toList(),
                      ),
                    ),
                    Row(
                      children: [
                        Card(
                          child: Tooltip(
                            message: "Add New Bookmark/Folder",
                            child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DialogWithTabs();
                                      });
                                }),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 35,
                          child: TextField(
                            controller: context
                                .read<BookmarksCubit>()
                                .searchBookmarkController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Search Bookmarks",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  context.read<BookmarksCubit>().clearSearch();
                                },
                              ),
                            ),
                            onChanged: (value) {
                              context
                                  .read<BookmarksCubit>()
                                  .searchBookmark(value);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PopupMenuButton(
                            tooltip: "Filter Bookmarks",
                            itemBuilder: (context) =>
                                context.read<BookmarksCubit>().filters,
                            child: Icon(Icons.filter_list),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _buildLoginDialog(
      BuildContext context, GlobalKey<FormState> loginFormKey) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Login"),
            content: Form(
              key: loginFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    controller: context.read<AuthCubit>().loginEmailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      controller:
                          context.read<AuthCubit>().loginPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      }),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      if (loginFormKey.currentState!.validate()) {
                        context.read<AuthCubit>().login();
                      }
                    },
                    child: const Text("Login"),
                  ),
                ],
              )
            ],
          );
        });
  }

  void _buildRegisterDialog(
      BuildContext context, GlobalKey<FormState> registerFormKey) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Register"),
            content: Form(
              key: registerFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    controller:
                        context.read<AuthCubit>().registerEmailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      controller:
                          context.read<AuthCubit>().registerPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      }),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      if (registerFormKey.currentState!.validate()) {
                        context.read<AuthCubit>().register();
                      }
                    },
                    child: const Text("Register"),
                  ),
                ],
              )
            ],
          );
        });
  }
}

import 'package:cs411_project2/model/bookmark_model.dart';
import 'package:cs411_project2/view/widgets/custom_snackbars.dart';
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

class _BrowserScreenState extends State<BrowserScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
    final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
    final GlobalKey<FormState> addBookmarkFormKey = GlobalKey<FormState>();
    final GlobalKey<FormState> addFolderFormKey = GlobalKey<FormState>();
    TabController addTabController = TabController(length: 2, vsync: this);
    TabController authTabController = TabController(length: 2, vsync: this);
    return BlocConsumer<BookmarksCubit, BookmarksState>(
      bloc: context.read<BookmarksCubit>()..setFilters(),
      listener: (context, state) {
        if (state is BookmarksSuccess) {
          CustomSnackbars.displaySuccessMotionToast(
              context, state.title, state.description, () {
            context.read<BookmarksCubit>().clearForms();
            context.read<BookmarksCubit>().refresh();
            Navigator.pop(context);
          });
        } else if (state is BookmarksError) {
          CustomSnackbars.displayErrorMotionToast(
              context, state.title, state.description, () {
            context.read<BookmarksCubit>().clearForms();
            context.read<BookmarksCubit>().refresh();
            // Navigator.pop(context);
          });
        }
      },
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
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                    const SizedBox(width: 10),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.refresh)),
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
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          CustomSnackbars.displaySuccessMotionToast(
                              context, state.title, state.description, () {
                            context.read<BookmarksCubit>().getMyBookmarks();
                            context.read<BookmarksCubit>().refresh();
                            Navigator.pop(context);
                          });
                        } else if (state is AuthError) {
                          CustomSnackbars.displayErrorMotionToast(
                              context, state.title, state.description, () {
                            Navigator.pop(context);
                          });
                        }
                      },
                      builder: (context, state) {
                        return IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    if (UserInfo.loggedUser == null) {
                                      return Dialog(
                                        child: SingleChildScrollView(
                                          child: SizedBox(
                                            width: 400,
                                            height: 300,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TabBar(
                                                      controller:
                                                          authTabController,
                                                      tabs: const [
                                                        Tab(
                                                          text: "Login",
                                                        ),
                                                        Tab(
                                                          text: "Register",
                                                        )
                                                      ]),
                                                  Expanded(
                                                    child: TabBarView(
                                                        controller:
                                                            authTabController,
                                                        children: [
                                                          Form(
                                                            key: loginFormKey,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  TextFormField(
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      labelText:
                                                                          'Email',
                                                                    ),
                                                                    controller: context
                                                                        .read<
                                                                            AuthCubit>()
                                                                        .loginEmailController,
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
                                                                        return 'Email cannot be empty';
                                                                      }
                                                                      return null;
                                                                    },
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          10),
                                                                  TextFormField(
                                                                      obscureText:
                                                                          true,
                                                                      decoration:
                                                                          const InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        labelText:
                                                                            'Password',
                                                                      ),
                                                                      controller: context
                                                                          .read<
                                                                              AuthCubit>()
                                                                          .loginPasswordController,
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                                null ||
                                                                            value.isEmpty) {
                                                                          return 'Password cannot be empty';
                                                                        }
                                                                        return null;
                                                                      }),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Form(
                                                            key:
                                                                registerFormKey,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                TextFormField(
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                    labelText:
                                                                        'Email',
                                                                  ),
                                                                  controller: context
                                                                      .read<
                                                                          AuthCubit>()
                                                                      .registerEmailController,
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return 'Email cannot be empty';
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                TextFormField(
                                                                    obscureText:
                                                                        true,
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      labelText:
                                                                          'Password',
                                                                    ),
                                                                    controller: context
                                                                        .read<
                                                                            AuthCubit>()
                                                                        .registerPasswordController,
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
                                                                        return 'Password cannot be empty';
                                                                      }
                                                                      return null;
                                                                    }),
                                                              ],
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "Cancel")),
                                                      TextButton(
                                                          onPressed: () {
                                                            if (authTabController
                                                                        .index ==
                                                                    0 &&
                                                                loginFormKey
                                                                    .currentState!
                                                                    .validate()) {
                                                              context
                                                                  .read<
                                                                      AuthCubit>()
                                                                  .login();
                                                            } else if (authTabController
                                                                        .index ==
                                                                    1 &&
                                                                registerFormKey
                                                                    .currentState!
                                                                    .validate()) {
                                                              context
                                                                  .read<
                                                                      AuthCubit>()
                                                                  .register();
                                                            }
                                                          },
                                                          child: const Text(
                                                              "Submit")),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Dialog(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              context
                                                  .read<AuthCubit>()
                                                  .logout();
                                              context
                                                  .read<BookmarksCubit>()
                                                  .myBookmarkItems = [];
                                              context
                                                  .read<BookmarksCubit>()
                                                  .temp = [];
                                              context
                                                  .read<BookmarksCubit>()
                                                  .clearForms();
                                              context
                                                  .read<BookmarksCubit>()
                                                  .refresh();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Logout")),
                                      );
                                    }
                                  });
                            },
                            icon: Icon(
                              Icons.person,
                              color: UserInfo.loggedUser != null
                                  ? Colors.blue
                                  : Colors.red,
                            ));
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
                            (context.read<BookmarksCubit>().temp.isNotEmpty)
                                ? context
                                    .read<BookmarksCubit>()
                                    .temp
                                    .map((bookmark) {
                                    if (bookmark.type! == "F") {
                                      return FolderWidget(
                                        bookmarks: bookmark.items ?? [],
                                        folderName: bookmark.name!,
                                        folderId: bookmark.id!,
                                      );
                                    } else {
                                      return BookmarkWidget(
                                          bookmark: Bookmark(
                                              bookmarkId: bookmark.id,
                                              label: bookmark.label,
                                              name: bookmark.name,
                                              url: bookmark.url));
                                    }
                                  }).toList()
                                : [],
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
                                  if (UserInfo.loggedUser != null) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return DialogWithTabs(
                                            onPressed: () {
                                              if (addTabController.index == 0 &&
                                                  addBookmarkFormKey
                                                      .currentState!
                                                      .validate()) {
                                                context
                                                    .read<BookmarksCubit>()
                                                    .addBookmark();
                                              } else if (addTabController
                                                          .index ==
                                                      1 &&
                                                  addFolderFormKey.currentState!
                                                      .validate()) {
                                                context
                                                    .read<BookmarksCubit>()
                                                    .addFolder();
                                              }
                                            },
                                            tabController: addTabController,
                                            tabs: const [
                                              Tab(text: "Bookmark"),
                                              Tab(
                                                text: "Folder",
                                              )
                                            ],
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Form(
                                                  key: addBookmarkFormKey,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        TextFormField(
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText:
                                                                'Bookmark Name',
                                                          ),
                                                          controller: context
                                                              .read<
                                                                  BookmarksCubit>()
                                                              .addBookmarkNameController,
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return "Bookmark name cannot be empty";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              labelText:
                                                                  'Bookmark URL',
                                                            ),
                                                            controller: context
                                                                .read<
                                                                    BookmarksCubit>()
                                                                .addBookmarkURLController,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return "Bookmark URL cannot be empty";
                                                              }
                                                              return null;
                                                            }),
                                                        const SizedBox(
                                                            height: 10),
                                                        TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              labelText:
                                                                  'Bookmark Label',
                                                            ),
                                                            controller: context
                                                                .read<
                                                                    BookmarksCubit>()
                                                                .addBookmarkLabelController,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return "Bookmark label cannot be empty";
                                                              }
                                                              return null;
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Form(
                                                  key: addFolderFormKey,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              labelText:
                                                                  'Folder Name',
                                                            ),
                                                            controller: context
                                                                .read<
                                                                    BookmarksCubit>()
                                                                .addFolderNameController,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return "Folder name cannot be empty";
                                                              }
                                                              return null;
                                                            }),
                                                        const SizedBox(
                                                            height: 10),
                                                        TextFormField(
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText:
                                                                'Folder Label',
                                                          ),
                                                          controller: context
                                                              .read<
                                                                  BookmarksCubit>()
                                                              .addFolderLabelController,
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return "Folder label cannot be empty";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  }
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
                              border: const OutlineInputBorder(),
                              labelText: "Search Bookmarks",
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
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
                            child: const Icon(Icons.filter_list),
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
}

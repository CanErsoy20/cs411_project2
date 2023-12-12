// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DialogWithTabs extends StatefulWidget {
  DialogWithTabs({
    super.key,
    required this.tabs,
    required this.tabController,
    required this.children,
    required this.onPressed,
  });
  List<Tab> tabs;
  TabController tabController;
  List<Widget> children;
  void Function()? onPressed;
  @override
  _DialogWithTabsState createState() => _DialogWithTabsState();
}

class _DialogWithTabsState extends State<DialogWithTabs>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: SizedBox(
          width: 600,
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TabBar(controller: widget.tabController, tabs: widget.tabs),
                Expanded(
                  child: TabBarView(
                      controller: widget.tabController,
                      children: widget.children),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    TextButton(
                        onPressed: widget.onPressed, child: Text("Submit")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

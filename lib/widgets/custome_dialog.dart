import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomeDialog extends StatelessWidget {
  const CustomeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      alignment: Alignment.center,
      child: Container(
        width: 360,
        height: 632,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hướng dẫn sử dụng',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'Hệ thống cho phép bạn quét để thực hiện thêm bớt, sửa, xóa sản phẩm dịch vụ trong cửa hàng',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 26),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 0.5, color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonsTabBar(
                            borderWidth: 0.5,
                            borderColor: Colors.teal,
                            unselectedBorderColor: Colors.white,
                            height: 50,
                            radius: 16,
                            splashColor: Colors.teal.withOpacity(0.3),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            labelStyle: const TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.w600,
                            ),
                            unselectedLabelStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                            backgroundColor: Colors.white,
                            unselectedDecoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            tabs: [
                              Tab(
                                child: SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          150) /
                                      2,
                                  child: const Center(
                                    child: Text(
                                      'Gộp (mặc định)',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              Tab(
                                child: SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          150) /
                                      2,
                                  child: const Center(
                                    child: Text(
                                      'Tách',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Tab "Gộp"
                          ListView.builder(
                            itemCount: CustomListView.buttonData.length,
                            itemBuilder: (context, index) {
                              return CustomListView(
                                index: index,
                                isCombineTab: true,
                              );
                            },
                          ),
                          // Tab "Tách"
                          ListView.builder(
                            itemCount: CustomListView.buttonData.length,
                            itemBuilder: (context, index) {
                              return CustomListView(
                                index: index,
                                isCombineTab: false,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListView extends StatelessWidget {
  final int index;
  final bool isCombineTab;

  const CustomListView(
      {super.key, required this.index, required this.isCombineTab});

  static const List<Map<String, dynamic>> buttonData = [
    {'text': 'Chế độ', 'action': 'mode'},
    {'icon': Icons.add, 'action': 'add'},
    {'icon': Icons.remove, 'action': 'remove'},
    {'icon': Icons.refresh, 'action': 'refresh'},
    {'icon': Icons.delete, 'action': 'delete'},
  ];

  @override
  Widget build(BuildContext context) {
    final data = buttonData[index];
    final isModeItem = data['action'] == 'mode';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: isModeItem
                  ? EdgeInsets.symmetric(horizontal: 5)
                  : EdgeInsets.all(10),
              elevation: 1,
              backgroundColor: isModeItem ? Colors.grey : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: isModeItem
                ? SizedBox(
                    width: 60,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isCombineTab ? 'Gộp' : 'Tách',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                : Icon(
                    data['icon'],
                    color: Colors.grey,
                  ),
          ),
          const SizedBox(width: 50),
          SvgPicture.asset(
            isModeItem
                ? (isCombineTab
                    ? 'assets/combine_text.svg'
                    : 'assets/split_text.svg')
                : 'assets/${data['action']}_text.svg',
            width: 165,
          ),
        ],
      ),
    );
  }
}

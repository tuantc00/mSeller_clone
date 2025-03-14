import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../datas/branches_data.dart';
import '../model/branches_model.dart';
import '../model/package_model.dart';
import '../view_model/branches_view_model.dart';
import '../view_model/package_view_model.dart';
import '../widgets/package_card.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final packageViewModel =
        Provider.of<PackageViewModel>(context, listen: false);
    final branchViewModel =
        Provider.of<BranchesViewModel>(context, listen: false);

    // Fetch data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      packageViewModel.fetchPackage();
      branchViewModel.fetchBranch();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gói & thanh toán',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 37, 169, 135),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer2<PackageViewModel, BranchesViewModel>(
        builder: (context, packageViewModel, branchViewModel, child) {
          if (packageViewModel.isLoading || branchViewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (packageViewModel.errorMessage.isNotEmpty) {
            return Center(child: Text(packageViewModel.errorMessage));
          }

          if (branchViewModel.errorMessage.isNotEmpty) {
            return Center(child: Text(branchViewModel.errorMessage));
          }
          if (branchViewModel.branches == null) {
            return Center(child: Text('Không có dữ liệu chi nhánh'));
          }
          return BodyBuild(
            packages: packageViewModel.packages,
            branch: branchViewModel.branches!,
          );
        },
      ),
    );
  }
}

class BodyBuild extends StatelessWidget {
  final List<Package> packages;
  final Branch branch;

  const BodyBuild(
      {super.key,
      required this.packages,
      required this.branch}); // Sửa constructor

  @override
  Widget build(BuildContext context) {
    final remainDays = calculateRemainingDays(branch.expiredDate!);
    final showExpiredCard = remainDays <= 30;
    final showStatus = branch.status != false;

    return Stack(
      children: <Widget>[
        // Red background container
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white10,
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          child: Container(
            height: 230,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 37, 169, 135),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),
        ),

        Positioned(
          top: 20,
          left: 20,
          right: 20,
          child: Stack(
            children: [
              //EXPIRED CARD
              if (branch.status && remainDays <= 30)
                ExpiredCard(remainingDays: remainDays),
              BranchCard(
                branch: branch,
              ),
              // BRANCH CARD
            ],
          ),
        ),
        Positioned(
          top: 300,
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mã kích hoạt gói tài khoản',
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                      SizedBox(height: 10),
                      Form(
                        child: TextFormField(
                          decoration: InputDecoration(
                            suffix: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 37, 169, 135),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              onPressed: () {},
                              autofocus: false,
                              child: Text('Kích hoạt',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Nhập mã kích hoạt',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            constraints: BoxConstraints(
                                maxHeight: 60), // Giới hạn chiều cao
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ButtonsTabBar(
                              radius: 16,
                              backgroundColor: Colors.greenAccent,
                              unselectedBackgroundColor: Colors.white,
                              unselectedLabelStyle:
                                  const TextStyle(color: Colors.red),
                              splashColor: Colors.greenAccent,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              labelStyle: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                              tabs: [
                                Tab(
                                  child: Text(
                                    'Gói gia hạn',
                                  ),
                                ),
                                Tab(
                                  child: Text('Lịch sử gia hạn'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ListView.builder(
                              itemCount: packages.length,
                              itemBuilder: (context, index) {
                                final package = packages[index];
                                print('Gói hiển thị: ${package.name}');
                                return PackageCard(
                                  package: package,
                                  packViewModel: PackageViewModel(),
                                );
                              },
                            ),
                            Center(child: Text('Null')),
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
      ],
    );
  }
}

class BranchCard extends StatefulWidget {
  final Branch branch;

  const BranchCard({super.key, required this.branch});

  @override
  State<BranchCard> createState() => _BranchCardState();
}

class _BranchCardState extends State<BranchCard> {
  String statusMess = 'Chưa kích hoạt';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lastExtendDate = widget.branch.lastExtendDate;
    final formattedLastExtendDate =
        DateFormat('HH:mm dd-MM-yyyy').format(lastExtendDate!);

    final expiredDate = widget.branch.expiredDate;
    final formattedExpiredDate =
        DateFormat('HH:mm dd-MM-yyyy').format(expiredDate!);
    return Container(
      height: 230,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: SvgPicture.asset(widget.branch.avatar as String,
                          width: 44, height: 44),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Cửa hàng \n${widget.branch.name}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Chip(
                  avatar: null,
                  label: Text(
                      widget.branch.status ? 'Đã kích hoạt' : 'Chưa kích hoạt',
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: widget.branch.status
                      ? Color.fromARGB(255, 37, 169, 135)
                      : Colors.red,
                  side: widget.branch.status
                      ? BorderSide(color: Color.fromARGB(255, 37, 169, 135))
                      : BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(65),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            width: 331,
            height: 90,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 249, 250, 251),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Gia hạn cuối cùng: '),
                      Text('${formattedLastExtendDate}'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ngày hết hạn: '),
                      Text('${formattedExpiredDate}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpiredCard extends StatelessWidget {
  final int remainingDays;

  const ExpiredCard({super.key, required this.remainingDays});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.info_rounded, size: 15, color: Colors.white),
                      SizedBox(width: 4),
                      Text('Sắp hết hạn',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Text('Còn lại: $remainingDays ngày',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

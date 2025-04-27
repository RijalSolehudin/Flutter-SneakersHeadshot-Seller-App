import 'package:ecommerce_seller_app/presentation/home/pages/live_streaming_create_page.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
// import 'live_streaming_create_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: 200,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(30)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    stops: [
                      -0.3,
                      0.1,
                      0.8
                    ],
                    colors: [
                      AppColors.primary,
                      AppColors.white,
                      AppColors.primary
                    ])),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Color.fromARGB(255, 251, 251, 251),
                    ),
                    SpaceWidth(8.0),
                    Expanded(
                      child: Text(
                        'Updated at May 12, 2024',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Dashboard',
                  style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          const SpaceHeight(10.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SpaceWidth(10),
                Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.gray),
                        borderRadius: BorderRadius.circular(17)),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.archive_outlined,
                          size: 30,
                          color: AppColors.primary,
                        ),
                        Text("Process")
                      ],
                    )),
                const SpaceWidth(12.0),
                Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.gray),
                        borderRadius: BorderRadius.circular(17)),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.fire_truck,
                          size: 30,
                          color: AppColors.primary,
                        ),
                        Text("Shipping")
                      ],
                    )),
                const SpaceWidth(12.0),
                Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.gray),
                        borderRadius: BorderRadius.circular(17)),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.restart_alt,
                          size: 30,
                          color: AppColors.primary,
                        ),
                        Text("Return")
                      ],
                    )),
                const SpaceWidth(12.0),
                Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.gray),
                        borderRadius: BorderRadius.circular(17)),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.star,
                          size: 30,
                          color: AppColors.primary,
                        ),
                        Text("Testimoni")
                      ],
                    )),
                const SpaceWidth(10)
              ],
            ),
          ),
          const SpaceHeight(20.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: AppColors.stroke),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Assets.icons.chart.svg(),
                    const SpaceWidth(8.0),
                    const Text('Total Product'),
                  ],
                ),
                const SpaceHeight(16.0),
                const Text(
                  '69',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SpaceHeight(22.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: AppColors.stroke),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Order'),
                    Text(
                      '10 June - 10 May  2024',
                      style:
                          TextStyle(color: Color.fromARGB(255, 117, 122, 128)),
                    ),
                  ],
                ),
                SpaceHeight(16.0),
                Text(
                  '89',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SpaceHeight(22.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: const Color.fromARGB(255, 42, 255, 60)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Revenue'),
                    Text(
                      '09-05-2024',
                      style:
                          TextStyle(color: Color.fromARGB(255, 117, 122, 128)),
                    ),
                  ],
                ),
                SpaceHeight(12.0),
                Text(
                  'Rp. 3,780,000 ',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_siakad_app/common/constants/colors.dart';
import 'package:flutter_siakad_app/common/constants/images.dart';
import 'package:flutter_siakad_app/common/widgets/menu_card.dart';
import 'package:flutter_siakad_app/common/widgets/search_input.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Perkuliahan",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: ColorName.primary,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      // TODO
                      // return const AbsensiPage();
                      return Container(); // Placeholder for AbsensiPage
                    }));
                  },
                  icon: const Icon(
                    Icons.qr_code_scanner,
                    color: ColorName.primary,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications,
                    color: ColorName.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        SearchInput(
          controller: SearchController(),
        ),
        const SizedBox(height: 40.0),
        MenuCard(
          label: 'Kartu Hasil\nStudi',
          backgroundColor: const Color(0xff686BFF),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              //TODO
              // return const KhsPage();
              return Container(); // Placeholder for KhsPage
            }));
          },
          imagePath: Images.khs,
        ),
        const SizedBox(height: 40.0),
        MenuCard(
          label: 'Nilai\nMata Kuliah',
          backgroundColor: const Color(0xffFFB023),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              //TODO
              // return const NilaiMkPage();
              return Container(); // Placeholder for NilaiMkPage
            }));
          },
          imagePath: Images.nMatkul,
        ),
        const SizedBox(height: 40.0),
        MenuCard(
          label: 'Jadwal\nMata Kuliah',
          backgroundColor: const Color(0xffFF68F0),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              //TODO
              // return const SchedulesPage();
              return Container(); // Placeholder for SchedulesPage
            }));
          },
          imagePath: Images.jadwal,
        ),
      ],
    );
  }
}

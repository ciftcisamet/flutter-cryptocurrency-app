import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CoinScreen(),
    );
  }
}

class CoinScreen extends StatefulWidget {
  CoinScreen({Key? key}) : super(key: key);

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff141517),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: 10,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20.0);
            },
            itemBuilder: (BuildContext context, int index) {
              return CryptoCard(index: index);
            },
          ),
        ),
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  static const List<Color> gradientColors = [
    Color(0xff039562),
    Color(0xff039562),
  ];

  static const List<Color> negativeGradientColors = [
    Color(0xffbd4237),
    Color(0xffbd4237),
  ];

  bool showAvg = false;

  CryptoCard({required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
            backgroundColor: const Color(0xff1f2124),
            radius: 22,
            child: Stack(
              children: [
                Image.network(
                  'https://xtcryptosignals.com/static/imgs/logos/ETH.png',
                  width: 20,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 14),
                    child: Image.network(
                      'https://xtcryptosignals.com/static/imgs/logos/BTC.png',
                      width: 20,
                    ))
              ],
            )),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BTC-USDT',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 4.0),
            Row(
              children: const [
                Text(
                  '€42,221.57',
                  style: TextStyle(color: Color(0xff5e5e63), fontSize: 13),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 16.0),
        Expanded(child: SizedBox(height: 30, child: LineChart(mainData()))),
        const SizedBox(width: 12.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.arrow_drop_up,
                  color: Color(0xff26ad5f),
                  size: 24,
                ),
                Text(
                  '0.15%',
                  style: TextStyle(color: Color(0xff26ad5f), fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: false,
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 5),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: index % 3 == 0 ? negativeGradientColors : gradientColors,
          barWidth: 2,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: index % 3 == 0
                ? negativeGradientColors
                    .map((color) => color.withOpacity(0.1))
                    .toList()
                : gradientColors
                    .map((color) => color.withOpacity(0.1))
                    .toList(),
          ),
        ),
      ],
    );
  }
}

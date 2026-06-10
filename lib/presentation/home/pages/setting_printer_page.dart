import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:ticketing_app/core/core.dart';
import 'package:ticketing_app/presentation/home/model/printer_model.dart';
import 'package:ticketing_app/presentation/home/widget/menu_printer_button.dart';
import 'package:ticketing_app/presentation/home/widget/menu_printer_content.dart';

class SettingPrinterPage extends StatefulWidget {
  const SettingPrinterPage({super.key});

  @override
  State<SettingPrinterPage> createState() => _SettingPrinterPageState();
}

class _SettingPrinterPageState extends State<SettingPrinterPage> {
  int selectedIndex = 0;

  String _info = "";
  String macName = '';
  String _msj = '';
  bool connected = false;
  List<BluetoothInfo> items = [];

  final List<String> _options = [
    "Permission bluetooth granted",
    "Permission bluetooth",
    "Bluetooth enabled",
    "connection status",
    "update info",
  ];

  final String _selectedSize = "2";
  final _txtText = TextEditingController(text: "Hallo !");
  bool _progress = false;
  String _msjprogress = "";

  String optionprinttype = "58 mm";
  List<String> options = ["58 mm", "80 mm"];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    int porcentbatery = 0;

    try {
      platformVersion = await PrintBluetoothThermal.platformVersion;
      print("platform version: $platformVersion");
      porcentbatery = await PrintBluetoothThermal.batteryLevel;
    } on PlatformException {
      platformVersion = "Failder to get platform version";
    }

    if (!mounted) return;

    final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    print("Bluetooth enabled: $result");
    if (result) {
      _msj = "Bluetooth enabled, please search and connect";
    } else {
      _msj = "Bluetooth not enabled, please connect";
    }

    setState(() {
      _info = "$platformVersion ($porcentbatery% battery)";
    });
  }

  Future<void> getBluetooth() async {
    setState(() {
      _progress = true;
      _msjprogress = "Searching for printers...";
      items = [];
    });
    final List<BluetoothInfo> listResult =
        await PrintBluetoothThermal.pairedBluetooths;

    setState(() {
      _progress = false;
    });

    if (listResult.isEmpty) {
      _msj = "No printers";
    } else {
      _msj = "Touch an item in the list to connect";
    }

    setState(() {
      items = listResult;
    });
  }

  Future<void> connect(String mac) async {
    setState(() {
      _progress = true;
      _msjprogress = "Connecting...";
      connected = false;
    });
    final bool result = await PrintBluetoothThermal.connect(
      macPrinterAddress: mac,
    );
    print("state connected: $result");
    if (result) connected = true;
    setState(() {
      _progress = false;
    });
  }

  Future<void> disconnect() async {
    final bool status = await PrintBluetoothThermal.disconnect;
    setState(() {
      connected = false;
    });
    print("Status disconnected: $status");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelola Printer'),
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Assets.images.back.image(),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          Container(
            width: context.deviceWidth / 2,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.stroke,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MenuPrinterButton(
                  label: 'Search',
                  onPressed: () {
                    getBluetooth();
                    selectedIndex = 0;
                    setState(() {});
                  },
                  isActive: selectedIndex == 0,
                ),
                MenuPrinterButton(
                  label: 'Disconnect',
                  onPressed: () {
                    selectedIndex = 1;
                    setState(() {});
                  },
                  isActive: selectedIndex == 1,
                ),
                MenuPrinterButton(
                  label: 'Test',
                  onPressed: () {
                    selectedIndex = 2;
                    setState(() {});
                  },
                  isActive: selectedIndex == 2,
                ),
              ],
            ),
          ),
          SpaceHeight(34),
          // Setting data
          _Body(
            macName: macName,
            data: items,
            clickHandler: (mac) async {
              macName = mac;
              await connect(mac);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

// Setiap widget harus ada build context
// INI PRIVATE

class _Body extends StatelessWidget {
  // final int selectedIndex;
  final String macName;
  final List<BluetoothInfo> data;
  final Function(String) clickHandler;

  const _Body({
    super.key,
    required this.macName,
    required this.data,
    required this.clickHandler,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Text('Tidak ada printer yang ditemukan');
    } else {
      return Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: AppColors.black.withOpacity(0.1),
              blurRadius: 30,
              spreadRadius: 0,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => InkWell( 
            onTap: () {
              clickHandler(data[index].macAdress);
            },
            child: MenuPrinterContent(
              data: data[index],
              isSelected: macName == data[index].macAdress,
            ),
          ),
          separatorBuilder: (context, index) => SpaceHeight(12),
          // Buat ngeluarin data nya, pake length
          itemCount: data.length,
        ),
      );
    }
  }
}

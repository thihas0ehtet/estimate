import 'package:estimate/widgets/custom_dropdown.dart';
import 'package:estimate/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class EarthworkPage extends StatefulWidget {
  const EarthworkPage({super.key});

  @override
  State<EarthworkPage> createState() => _EarthworkPageState();
}

class _EarthworkPageState extends State<EarthworkPage> {
  final lengthTE = TextEditingController();
  final widthTE = TextEditingController();
  final heigthTE = TextEditingController();
  final qtyTE = TextEditingController();

  final salaryRateTE = TextEditingController();

  double length = 1;
  double width = 1;
  double height = 1;
  int qty = 1;

  int salaryRate = 1;

  String selectedLandType = "";
  List landTypes = [
    {"id": 0, "name": "Ordinary Soil", "value": 0.015},
    {"id": 1, "name": "Medium Soil", "value": 0.02},
    {"id": 2, "name": "Hard Soil", "value": 0.03},
  ];

  double getTotalQuantity() => length * width * height * qty;
  double getLandTypeRate() => selectedLandType.isEmpty
      ? 1
      : landTypes[int.parse(selectedLandType)]['value'];

  double getWorkers() => getLandTypeRate() * getTotalQuantity();

  double getTotalAmount() => salaryRate * getWorkers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Earthwork"),
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InputView(
                        label: "Length",
                        textEditingController: lengthTE,
                        onChanged: (value) => setState(() {
                          length = double.tryParse(value) ?? 1;
                        }),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: InputView(
                        label: "Width",
                        textEditingController: widthTE,
                        onChanged: (value) => setState(() {
                          width = double.tryParse(value) ?? 1;
                        }),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputView(
                        label: "Height",
                        textEditingController: heigthTE,
                        onChanged: (value) => setState(() {
                          height = double.tryParse(value) ?? 1;
                        }),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: InputView(
                        label: "Qty",
                        textEditingController: qtyTE,
                        onChanged: (value) => setState(() {
                          qty = int.tryParse(value) ?? 1;
                        }),
                      ),
                    ),
                  ],
                ),
                const Text("Land Type"),
                const SizedBox(
                  height: 5,
                ),
                CustomDropdown(
                    value: selectedLandType,
                    list: landTypes,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        selectedLandType = value;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                InputView(
                  label: "Salary Rate",
                  textEditingController: salaryRateTE,
                  onChanged: (value) => setState(() {
                    salaryRate = int.tryParse(value) ?? 1;
                  }),
                ),
              ],
            ),
          )),
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(color: Colors.grey.shade100),
            child: Column(
              children: [
                ShowInfoWidget(
                    label: "Total Quantity (feet)",
                    amount: getTotalQuantity() == 1
                        ? "0"
                        : getTotalQuantity().toStringAsFixed(2)),
                ShowInfoWidget(
                  label: "Workers (Nos)",
                  amount: (getWorkers() == 1 || getLandTypeRate() == 1)
                      ? "0"
                      : getWorkers().toStringAsFixed(2),
                ),
                ShowInfoWidget(
                  label: "Amount (MMK)",
                  amount: (salaryRate == 1 || getTotalAmount() == 1)
                      ? "0"
                      : getTotalAmount().toString(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InputView extends StatelessWidget {
  final String label;
  final Function(String value) onChanged;
  final TextEditingController textEditingController;
  const InputView(
      {super.key,
      required this.label,
      required this.onChanged,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(
          height: 5,
        ),
        CustomInput(
          controller: textEditingController,
          keyboardType: TextInputType.number,
          onChanged: onChanged,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class ShowInfoWidget extends StatelessWidget {
  final String label;
  final String amount;
  const ShowInfoWidget({super.key, required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            amount,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/scan_state_view_model.dart';

class BuildNumberAdjust extends StatefulWidget {
  const BuildNumberAdjust({super.key});

  @override
  State<BuildNumberAdjust> createState() => _BuildNumberAdjustState();
}

class _BuildNumberAdjustState extends State<BuildNumberAdjust> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<BarcodeScanViewModel>(context, listen: false);
    _controller = TextEditingController(text: viewModel.counter.toString());
    _focusNode = FocusNode();

    viewModel.addListener(() {
      if (_controller.text != viewModel.counter.toString()) {
        _controller.text = viewModel.counter.toString();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BarcodeScanViewModel>(context);

    return Container(
      width: 103,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.5, color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              viewModel.setCounter(viewModel.counter + 1);
            },
            child: Container(
              width: 32,
              height: 36,
              alignment: Alignment.center,
              child: Icon(Icons.add, color: Colors.black, size: 18),
            ),
          ),
          Container(
            width: 36,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.grey.withOpacity(0.3),
            ),
            child: Center(
              child: IntrinsicWidth(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(fontSize: 14),
                  onTap: () {
                    _controller.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _controller.text.length,
                    );
                  },
                  onChanged: (value) {
                    int? newValue = int.tryParse(value);
                    if (newValue != null && newValue >= 1) {
                      viewModel.setCounter(newValue);
                    } else if (value.isEmpty || newValue == null) {
                    } else {
                      viewModel.setCounter(1);
                      _controller.text = '1';
                    }
                  },
                  onSubmitted: (value) {
                    int? newValue = int.tryParse(value);
                    if (newValue != null && newValue >= 1) {
                      viewModel.setCounter(newValue);
                    } else {
                      viewModel.setCounter(1);
                      _controller.text = '1';
                    }
                  },
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              viewModel.setCounter(viewModel.counter - 1);
            },
            child: Container(
              width: 32,
              height: 36,
              alignment: Alignment.center,
              child: Icon(Icons.remove, color: Colors.black, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

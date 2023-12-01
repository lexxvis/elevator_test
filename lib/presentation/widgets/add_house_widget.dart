import 'package:elevator_test/utils/constants/colors.dart';
import 'package:elevator_test/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../app_model.dart';
import '../../utils/constants/dimentions.dart';

/// TextFormField input decoration
const _inputDecoration = InputDecoration(
  filled: true,
  counterText: '',
  isDense: true,
  fillColor: Colors.white,
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(left: 5, right: 5),
  errorStyle: TextStyle(fontSize: 0),
);

/// TExtFormField text style
const _textStyle = TextStyle(
  fontSize: 14,
  fontFamily: 'Inter',
  decorationThickness: 0,
);

///
/// Dialog widget add houe element
///
class AddHouseWidget extends StatefulWidget {
  const AddHouseWidget({super.key});

  @override
  State<AddHouseWidget> createState() => _AddHouseWidgetState();
}

class _AddHouseWidgetState extends State<AddHouseWidget> {
  final _formKey = GlobalKey<FormState>();

  late final FocusNode _nameFocusNode;
  late final FocusNode _floorsCountFocusNode;
  late final TextEditingController _nameController;
  late final TextEditingController _floorsCountController;

  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
    _nameFocusNode = FocusNode();
    _floorsCountFocusNode = FocusNode();
    _nameController = TextEditingController();
    _floorsCountController = TextEditingController();
  }

  @override
  void dispose() {
    _floorsCountController.dispose();
    _nameController.dispose();
    _floorsCountFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int floorsCount;
    return Stack(
      children: [
        Center(
          child: Container(
              width: MediaQuery.sizeOf(context).height / layoutHeight * 321,
              height: MediaQuery.sizeOf(context).height / layoutHeight * 185,
              decoration: BoxDecoration(
                color: AppColors.mainScreenBackground,
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            const Expanded(flex: 1, child: SizedBox()),
                            const Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(AppStrings.addHouse,
                                    style: TextStyle(fontSize: 16)),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                  icon: const Icon(Ionicons.close_outline),
                                  onPressed: () => Navigator.of(context).pop()),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            const Expanded(flex: 1, child: SizedBox()),
                            const Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(AppStrings.name,
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: TextFormField(
                                    autofocus: false,
                                    maxLength: 16,
                                    focusNode: _nameFocusNode,
                                    controller: _nameController,
                                    style: _textStyle,
                                    decoration: _inputDecoration,
                                    validator: (String? value) =>
                                        _checkNameInput(value),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            const Expanded(flex: 1, child: SizedBox()),
                            const Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  AppStrings.floorsCount,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: FractionallySizedBox(
                                  widthFactor: 0.3,
                                  child: TextFormField(
                                    validator: (String? value) =>
                                        _checkFloorsCountInput(value),
                                    autofocus: false,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    maxLength: 3,
                                    focusNode: _floorsCountFocusNode,
                                    controller: _floorsCountController,
                                    style: _textStyle,
                                    decoration: _inputDecoration,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: FractionallySizedBox(
                                      widthFactor: 120 / 321,
                                      heightFactor: 24 / 185 * 3.5,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            floorsCount = int.parse(
                                                _floorsCountController.text);
                                            context.read<AppModel>().insert(
                                                name: _nameController.text,
                                                floorsCount: floorsCount);

                                            Navigator.of(context).pop();
                                          }
                                        },
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          padding: EdgeInsets.zero,
                                          side: const BorderSide(
                                              color: Colors.black, width: 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                btnRadius),
                                          ),
                                        ),
                                        child: const Text(AppStrings.add),
                                      ))))),
                    ],
                  ))),
        ),
      ],
    );
  }
}

/// check floors counter input
/// check if null or empty
/// limits min 1 floor? max 99 floors
String? _checkFloorsCountInput(String? value) {
  if (value == null || value.isEmpty) {
    return 'empty';
  }
  try {
    final count = int.parse(value);
    if (count == 0 || count > 100) {
      return ('incorrect counter');
    }
  } catch (e) {
    return 'parsing error';
  }
  return null;
}

/// check house name input
String? _checkNameInput(String? value) {
  if (value == null || value.isEmpty) {
    return 'empty';
  }
  return null;
}

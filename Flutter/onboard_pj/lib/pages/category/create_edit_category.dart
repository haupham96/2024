import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateEditCategory extends StatefulWidget {
  CreateEditCategory({super.key});

  @override
  State<CreateEditCategory> createState() => _CreateEditCategoryState();
}

class _CreateEditCategoryState extends State<CreateEditCategory> {
  final TextEditingController _nameTextController = TextEditingController();

  final List<Color> _colors = [];
  int selectedIndex = 0;
  IconData? _icon;

  @override
  void initState() {
    super.initState();
    _colors.addAll([
      const Color(0xFFC9CC41),
      const Color(0xFF66CC41),
      const Color(0xFF41CCA7),
      const Color(0xFF4181CC),
      const Color(0xFF41A2CC),
      const Color(0xFFCC8441),
      const Color(0xFF9741CC),
      const Color(0xFFCC4173),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Create new category",
          style: TextStyle(
              color: Colors.white.withOpacity(0.87),
              fontSize: 20,
              fontFamily: GoogleFonts.lato().fontFamily,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNameField(),
          _buildChooseIcon(),
          _buildChooseBackground(),
          const Spacer(),
          _buildBottomButtonGroup()
        ],
      ),
    ));
  }

  Widget _buildNameField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleField("Category name :"),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: _nameTextController,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                hintText: "Category name",
                hintStyle:
                    const TextStyle(fontSize: 16, color: Color(0xFFAFAFAF)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xFF979797))),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChooseIcon() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleField("Category icon :"),
          GestureDetector(
            onTap: _chooseIcon,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white.withOpacity(.21)),
              child: _icon != null
                  ? Icon(
                      _icon,
                      size: 20,
                      color: _colors.elementAt(selectedIndex),
                    )
                  : Text(
                      "Choose icon from library",
                      style: TextStyle(
                          fontSize: 12, color: Colors.white.withOpacity(0.87)),
                    ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChooseBackground() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleField("Category color :"),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 36,
            child: ListView.builder(
                itemBuilder: (context, index) {
                  final color = _colors.elementAt(index);
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: color),
                      child: isSelected
                          ? const Icon(Icons.check,
                              size: 20, color: Colors.white)
                          : null,
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
                itemCount: _colors.length),
          )
        ],
      ),
    );
  }

  Widget _buildBottomButtonGroup() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24)
          .copyWith(top: 107, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Cancel",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Lato",
                    color: Colors.white.withOpacity(0.44)),
              )),
          const Spacer(),
          ElevatedButton(
              onPressed: _handleCreateCategory,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8875FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: const Text("Create category",
                  style: TextStyle(
                      fontSize: 16, fontFamily: "Lato", color: Colors.white)))
        ],
      ),
    );
  }

  Widget _buildTitleField(String title) {
    return Text(
      title,
      style: GoogleFonts.lato(
        color: Colors.white.withOpacity(0.87),
        fontSize: 16,
      ),
    );
  }

  void _handleCreateCategory() {
    var categoryName = _nameTextController.text;
  }

  void _chooseIcon() async {
    IconData? iconData = await FlutterIconPicker.showIconPicker(
      context,
      iconPackModes: [IconPack.material],
    );
    if (iconData != null) {
      setState(() {
        _icon = iconData;
      });
    }
  }
}

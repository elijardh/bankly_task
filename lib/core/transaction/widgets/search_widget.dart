import 'package:bankly_task/app/extensions.dart';
import 'package:bankly_task/app/presentations/colors.dart';
import 'package:bankly_task/app/presentations/font_family.dart';
import 'package:bankly_task/app/presentations/texts.dart';
import 'package:bankly_task/core/transaction/bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController keyWordController = TextEditingController();

  String filterKeyword = "Description";
  FocusNode keywordFocusNode = FocusNode();

  TextInputType inputType = TextInputType.text;

  List<String> filterList = [
    'Description',
    'Amount',
    'Account Number',
    'Account Name',
    'Bank Name'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) => Material(
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(
          child: Container(
            height: 40.h,
            width: 330.w,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Positioned(
                    left: 1,
                    top: 17,
                    child: SvgPicture.asset("Search".toSVG())),
                Positioned(
                  right: 1,
                  top: 10,
                  child: Container(
                    height: 20.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                          244,
                          247,
                          255,
                          1,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: 160.h,
                              width: 280.w,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                child: Wrap(
                                  runSpacing: 20,
                                  spacing: 20,
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: filterList
                                      .map((e) => InkWell(
                                          onTap: () {
                                            filterKeyword = e;

                                            if (filterKeyword == "Amount" ||
                                                filterKeyword ==
                                                    "Account Number") {
                                              inputType = TextInputType.number;
                                            } else {
                                              inputType = TextInputType.text;
                                            }

                                            context.read<TransactionBloc>().add(
                                                FilterTransaction(
                                                    keyword:
                                                        keyWordController.text,
                                                    specification:
                                                        filterKeyword));

                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Container(
                                              height: 25.h,
                                              width: 90.w,
                                              decoration: BoxDecoration(
                                                  color: filterKeyword == e
                                                      ? XColors.mainColor
                                                      : const Color.fromRGBO(
                                                          244, 247, 255, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                child: NormalText(
                                                  text: e,
                                                  fontSize: 12,
                                                  textColor: filterKeyword == e
                                                      ? Colors.white
                                                      : XColors.mainColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: XFontFamily.sfui,
                                                ),
                                              ))))
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NormalText(
                            text: "Filter",
                            textColor: XColors.mainColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SvgPicture.asset("filter".toSVG())
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: keyWordController,
                    focusNode: keywordFocusNode,
                    keyboardType: inputType,
                    onChanged: (value) {
                      context.read<TransactionBloc>().add(FilterTransaction(
                          keyword: value, specification: filterKeyword));
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: XFontFamily.sfui),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

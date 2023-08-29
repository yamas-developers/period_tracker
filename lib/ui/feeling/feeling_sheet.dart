import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:period_tracker/providers/feeling_provider.dart';
import 'package:provider/provider.dart';

import '../../dates_provider.dart';
import '../../utils/constants.dart';
import '../../utils/public_methods.dart';
import '../../widgets/misc_widgets.dart';
import '../self_care/statuses.dart';
import 'package:intl/intl.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    Key? key,
    required this.day,
  }) : super(key: key);

  final DateTime day;

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

enum BottomSheetStages { one, two, three }

class _BottomSheetWidgetState extends State<BottomSheetWidget>
    with WidgetsBindingObserver {
  // final double _headerHeight = 300.0;

  // final double _maxHeight = 900.0;
  bool implemented = false;

  BottomSheetStages currentStage = BottomSheetStages.two;
  final _scrollController = ScrollController();
  bool _isKeyboardVisible = false;

  bool editMode = false;

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DatesProvider datePro =
          Provider.of<DatesProvider>(context, listen: false);
      FeelingProvider feelingPro =
          Provider.of<FeelingProvider>(context, listen: false);
      datePro.selectedDay = widget.day;
      feelingPro.storeData(datePro.feelingData[widget.day]);
      if (datePro.feelingData[widget.day] == null) {
        setState(() {
          editMode = true;
        });
      }
    });
    super.initState();
  }

  dragUpStage() {
    if (currentStage == BottomSheetStages.one) {
      currentStage = BottomSheetStages.two;
    } else if (currentStage == BottomSheetStages.two) {
      currentStage = BottomSheetStages.three;
    }
    setState(() {});
  }

  dragDownStage() {
    _hideKeyboard();
    if (currentStage == BottomSheetStages.two) {
      currentStage = BottomSheetStages.one;
    } else if (currentStage == BottomSheetStages.three) {
      currentStage = BottomSheetStages.two;
    } else if (currentStage == BottomSheetStages.one) {
      Navigator.pop(context);
    }
    setState(() {});
  }

  Future<void> _scrollToField() async {
    await Future.delayed(Duration(milliseconds: 800));
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    double stageOne = _size.height * 0.3;
    double stageTwo = _size.height * 0.6;
    double stageThree = _size.height;

    final mediaQuery = MediaQuery.of(context);
    final bottomInset = mediaQuery.viewInsets.bottom;
    _isKeyboardVisible = bottomInset > 0;

    log('MK: vertical drag update 0 ${bottomInset}');
    return Consumer2<DatesProvider, FeelingProvider>(
        builder: (context, datesPro, feelingPro, _) {
      return AnimatedContainer(
          color: Colors.white,
          constraints: BoxConstraints(
            maxHeight: _size.height,
            minHeight: 0,
          ),
          curve: Curves.easeOut,
          height: currentStage == BottomSheetStages.one
              ? stageOne
              : currentStage == BottomSheetStages.two
                  ? stageTwo
                  : stageThree,
          duration: const Duration(milliseconds: 600),
          child: GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails data) {
              if (implemented) return;
              log('MK: vertical drag update ${data.delta.direction}');

              bool isDragUp = data.delta.direction < 0;

              log('MK: vertical drag direction is up: ${isDragUp}');

              if (isDragUp) {
                dragUpStage();
              } else {
                dragDownStage();
              }
              implemented = true;
              this.setState(() {});
            },
            onVerticalDragStart: (DragStartDetails data) {
              implemented = false;
              log('MK: vertical drag started');
            },
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  color: currentStage == BottomSheetStages.three
                      ? accentColor
                      : Colors.white,
                  child: Row(children: <Widget>[
                    if (currentStage == BottomSheetStages.one)
                      IconButton(
                          onPressed: () {
                            _hideKeyboard();
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close))
                    else
                      CustomAnimatedIcon(
                        firstIcon: Icons.arrow_upward,
                        secondIcon: Icons.arrow_downward,
                        firstCallback: dragUpStage,
                        secondCallback: dragDownStage,
                        color: currentStage == BottomSheetStages.three
                            ? Colors.white
                            : null,
                        currentIcon: currentStage == BottomSheetStages.two ? 0 : 1,
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${DateFormat("MMMM dd, ").format(datesPro.selectedDay)}'
                          '${DateFormat("E").format(datesPro.selectedDay).toUpperCase()}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: currentStage == BottomSheetStages.three
                                  ? Colors.white
                                  : null),
                        ),
                        Text(
                          'Medium Chance of getting pregnant',
                          style: TextStyle(
                              fontSize: 12,
                              color: currentStage == BottomSheetStages.three
                                  ? Colors.white54
                                  : greyFontColor),
                        ),
                      ],
                    ),
                  ]),
                ),
                if (currentStage != BottomSheetStages.three)
                  Divider(
                    color: greyDisabledColor,
                  )
                else
                  SizedBox(
                    height: 10,
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            sbw(18),
                            Text(
                              "14th day of cycle",
                              style:
                                  TextStyle(color: greyFontColor, fontSize: 16),
                            ),
                          ],
                        ),
                        sbh(10),
                        RectangularStatuses(),
                        if (!editMode)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Wrap(children: [
                                    LastAddedDataItem(
                                        icon: 'assets/icons/symptoms.png',
                                        list: feelingPro.selectedSymptoms),
                                    LastAddedDataItem(
                                        icon: 'assets/icons/mood.png',
                                        list: feelingPro.selectedMood),
                                    LastAddedDataItem(
                                        icon: 'assets/icons/sex.png',
                                        list: feelingPro.selectedSex),
                                    LastAddedDataItem(
                                        icon: 'assets/icons/menstruation.png',
                                        list:
                                            feelingPro.selectedMensus.isNotEmpty
                                                ? [feelingPro.selectedMensus]
                                                : []),
                                    LastAddedDataItem(
                                        icon: 'assets/icons/blood.png',
                                        list: feelingPro.selectedDischarge),
                                    LastAddedDataItem(
                                        icon: 'assets/icons/contraceptives.png',
                                        list:
                                            feelingPro.selectedContraceptives),
                                    LastAddedDataItem(
                                        icon: 'assets/icons/notes.png',
                                        list: feelingPro.selectedNotes),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          editMode = true;
                                        });
                                      },
                                      child: LastAddedData(
                                        title: 'Add',
                                        icon: 'assets/icons/add.png',
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          )
                        else ...[
                          FeelingWidget(
                            icon: 'assets/icons/symptoms.png',
                            attributes: feelingPro.symptoms,
                            onTap: (val) {
                              if (feelingPro.selectedSymptoms.contains(val)) {
                                feelingPro.selectedSymptoms.remove(val);
                              } else {
                                feelingPro.selectedSymptoms.add(val);
                              }
                              setData(datesPro, feelingPro);
                            },
                            title: 'Symptoms',
                            selectedAttributes: feelingPro.selectedSymptoms,
                          ),
                          FeelingWidget(
                            icon: 'assets/icons/mood.png',
                            attributes: feelingPro.mood,
                            onTap: (val) {
                              if (feelingPro.selectedMood.contains(val)) {
                                feelingPro.selectedMood.remove(val);
                              } else {
                                feelingPro.selectedMood.add(val);
                              }
                              setData(datesPro, feelingPro);
                            },
                            title: 'Mood',
                            selectedAttributes: feelingPro.selectedMood,
                          ),
                          FeelingWidget(
                            icon: 'assets/icons/sex.png',
                            attributes: feelingPro.sex,
                            onTap: (val) {
                              if (feelingPro.selectedSex.contains(val)) {
                                feelingPro.selectedSex.remove(val);
                              } else {
                                feelingPro.selectedSex.add(val);
                              }
                              setData(datesPro, feelingPro);
                            },
                            title: 'Sex',
                            selectedAttributes: feelingPro.selectedSex,
                          ),
                          FeelingWidget(
                            icon: 'assets/icons/menstruation.png',
                            attributes: feelingPro.mensus,
                            onTap: (val) {
                              if (val == feelingPro.selectedMensus) {
                                feelingPro.selectedMensus = '';
                              } else {
                                feelingPro.selectedMensus = val;
                              }
                              setData(datesPro, feelingPro);
                            },
                            title: 'Menstruation flow',
                            selectedAttributes: [feelingPro.selectedMensus],
                          ),
                          FeelingWidget(
                            icon: 'assets/icons/blood.png',
                            attributes: feelingPro.vaginalDischarge,
                            onTap: (val) {
                              if (feelingPro.selectedDischarge.contains(val)) {
                                feelingPro.selectedDischarge.remove(val);
                              } else {
                                feelingPro.selectedDischarge.add(val);
                              }
                              setData(datesPro, feelingPro);
                            },
                            title: 'Vaginal Discharge',
                            selectedAttributes: feelingPro.selectedDischarge,
                          ),
                          FeelingWidget(
                            icon: 'assets/icons/contraceptives.png',
                            attributes: feelingPro.contraceptives,
                            onTap: (val) {
                              if (feelingPro.selectedContraceptives
                                  .contains(val)) {
                                feelingPro.selectedContraceptives.remove(val);
                              } else {
                                feelingPro.selectedContraceptives.add(val);
                              }
                              setData(datesPro, feelingPro);
                            },
                            title: 'Oral contraceptives',
                            selectedAttributes:
                                feelingPro.selectedContraceptives,
                          ),
                          NotesWidget(
                            scrollToField: _scrollToField,
                            storeData: () {
                              setData(datesPro, feelingPro);
                            },
                          ),
                          sbh(_isKeyboardVisible ? bottomInset + 20 : 80)
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }

  void _hideKeyboard() {
    // Unfocus the current FocusNode, which hides the keyboard
    FocusScope.of(context).unfocus();
  }

  setData(DatesProvider datesPro, FeelingProvider feelingPro) {
    setState(() {});
    String jsonString = feelingPro.getDecodedData();
    if (jsonString.isEmpty) {
      if (datesPro.feelingData.keys.contains(datesPro.selectedDay)) {
        datesPro.feelingData.remove(datesPro.selectedDay);
      }
    } else {
      datesPro.feelingData[datesPro.selectedDay] = jsonString;
    }
  }
}

class LastAddedDataItem extends StatelessWidget {
  const LastAddedDataItem({
    super.key,
    required this.list,
    required this.icon,
  });

  final List list;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? SizedBox()
        : Builder(builder: (context) {
            String title = '';
            for (int i = 0; i < list.length; i++) {
              if (i != 0 && i < list.length) {
                title += ', ';
              }
              title += list[i].toString();
            }
            return LastAddedData(
              title: title,
              icon: icon,
            );
          });
  }
}

class LastAddedData extends StatelessWidget {
  const LastAddedData({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: greyBgColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(icon, height: 23, width: 23),
          sbw(10),
          Text(
            title,
            style: TextStyle(
              color: fontColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class FeelingWidget extends StatelessWidget {
  const FeelingWidget({
    super.key,
    required this.attributes,
    this.onTap,
    required this.title,
    required this.icon,
    required this.selectedAttributes,
  });

  final List attributes;
  final dynamic onTap;
  final String title;
  final String icon;
  final List selectedAttributes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sbh(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
          child: Row(children: [
            Image.asset(icon, height: 30, width: 30),
            sbw(16),
            Text(
              title,
              style: TextStyle(fontSize: 16),
            )
          ]),
        ),
        sbh(20),
        SizedBox(
          height: 40,
          child: ListView.builder(
            itemCount: attributes.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      onTap(attributes[index]);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: index == 0 ? 48 : 0),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        margin:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                        decoration: BoxDecoration(
                          color: selectedAttributes.contains(attributes[index])
                              ? accentColor
                              : greyBgColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          attributes[index],
                          style: TextStyle(
                              color:
                                  selectedAttributes.contains(attributes[index])
                                      ? Colors.white
                                      : fontColor),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

class NotesWidget extends StatefulWidget {
  NotesWidget({
    super.key,
    this.scrollToField,
    this.storeData,
  });

  final dynamic scrollToField;
  final storeData;

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<FeelingProvider, DatesProvider>(
        builder: (context, feelingPro, datesPro, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sbh(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
            child: Row(children: [
              Image.asset('assets/icons/notes.png', height: 30, width: 30),
              sbw(16),
              Text(
                'Notes',
                style: TextStyle(fontSize: 16),
              )
            ]),
          ),
          sbh(20),
          if (feelingPro.allNotes.length > 0)
            SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: feelingPro.allNotes.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  String note = feelingPro.allNotes[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          log('MK: all notes in top0: ${feelingPro.allNotes}');
                          if (feelingPro.selectedNotes.contains(note)) {
                            feelingPro.selectedNotes.remove(note);
                          } else {
                            feelingPro.selectedNotes.add(note);
                          }
                          log('MK: all notes in top1: ${feelingPro.allNotes}');
                          widget.storeData();
                          log('MK: all notes in top2: ${feelingPro.allNotes}');
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: index == 0 ? 48 : 0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            margin: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 0),
                            decoration: BoxDecoration(
                              color: feelingPro.selectedNotes.contains(note)
                                  ? accentColor
                                  : greyBgColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  note,
                                  style: TextStyle(
                                    color:
                                        feelingPro.selectedNotes.contains(note)
                                            ? Colors.white
                                            : fontColor,
                                  ),
                                ),
                                sbw(10),
                                GestureDetector(
                                    onTap: () {
                                      if (feelingPro.selectedNotes
                                          .contains(note)) {
                                        feelingPro.selectedNotes.remove(note);
                                      }
                                      feelingPro.allNotes.remove(note);
                                      if (feelingPro.selectedNotes
                                          .contains(note)) {
                                        feelingPro.notes.remove(note);
                                      }
                                      if (feelingPro.notes.contains(note)) {
                                        feelingPro.notes.remove(note);
                                      }
                                      widget.storeData();
                                    },
                                    child: Icon(
                                      Icons.cancel,
                                      color: feelingPro.selectedNotes
                                              .contains(note)
                                          ? Colors.white54
                                          : greyFontColor,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0, left: 48),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText:
                      '${feelingPro.notes.length > 0 ? 'Add another note' : 'Add a note'}',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: accentColor,
                    ),
                    onPressed: () {
                      if (!feelingPro.selectedNotes.contains(controller.text)) {
                        feelingPro.selectedNotes.add(controller.text);
                      }
                      if (!feelingPro.allNotes.contains(controller.text)) {
                        feelingPro.allNotes.add(controller.text);
                      }
                      if (feelingPro.notes.contains(controller.text)) {
                        feelingPro.notes.add(controller.text);
                      }
                      controller.text = '';
                      widget.storeData();
                    },
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: greyBgColor,
                  ))),
              onTap: widget.scrollToField,
            ),
          ),
          sbh(0)
        ],
      );
    });
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../view/items_page.dart';

class AutoCompleteToolField extends StatelessWidget {

  const AutoCompleteToolField({
    Key? key,
    required this.toolItems,
    required this.controller,
    required this.onToolSelected,
    required this.onChanged,
    required this.suggestionCallBack, this.trailing,
  }) : super(key: key);

  final List<Shop> toolItems;
  final TextEditingController controller;
  final void Function(Shop) onToolSelected;
  final ValueChanged<String> onChanged;
  final FutureOr<Iterable<Shop>> Function(String) suggestionCallBack;
  final Widget? trailing;
  // final List<Shop> filtereditemlist = [];
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TypeAheadFormField(
          autoFlipDirection: true,
          textFieldConfiguration: TextFieldConfiguration(
            textCapitalization: TextCapitalization.words,
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'Enter Tool Number / Name',
              border: InputBorder.none,
            ),
          ),
          suggestionsCallback: suggestionCallBack,
          itemBuilder: (context, suggestion) {
            //
            // final item = filtereditemlist[index];
            // final isItemSelected = isItemAlreadySelected(item);
            return ListTile(
              title: Text("${suggestion.price}"),
              subtitle: Text("${suggestion.name}"),
              trailing: trailing,
              // leading: FadeInImage.memoryNetwork(
              //   placeholder:
              //   kTransparentImage, // A transparent placeholder
              //   image: "${suggestion.image}",
              //   fit: BoxFit.cover,
              //   width: 48,
              //   height: 48,
              //   imageErrorBuilder:
              //       (context, error, stackTrace) {
              //     return Icon(
              //         Icons.image_not_supported);
              //   },
              //   placeholderErrorBuilder:
              //       (context, error, stackTrace) {
              //     return CircularProgressIndicator();
              //   },
              // ),

            );
          },
          transitionBuilder:
              (context, suggestionsBox, controller) {
            return suggestionsBox;
          },
          onSuggestionSelected: onToolSelected,
        ),
      ),
    );
  }
}
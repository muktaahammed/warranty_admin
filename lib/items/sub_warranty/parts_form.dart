import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'parts_model.dart';

typedef OnDelete();

class PartsForm extends StatefulWidget {
  final PartsModel partsModel;
  final form = GlobalKey<FormState>();
  final state = _PartsFormState();
  final OnDelete onDelete;
  PartsForm({Key key, this.partsModel, this.onDelete}) : super(key: key);
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }

  @override
  _PartsFormState createState() => _PartsFormState();
}

class _PartsFormState extends State<PartsForm> {
  double _currentPartsValue = 7;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();

  bool autoValidate = false;
  bool showResetIcon = true;
  DateTime value = DateTime.now();

  //
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(8),
      child: Form(
        key: widget.form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppBar(
              leading: Icon(Icons.verified_user),
              elevation: 0,
              title: Text('Add Parts'),
              backgroundColor: Colors.green[800],
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: widget.onDelete,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: TextFormField(
                onSaved: (newValue) {
                  setState(() {
                    widget.partsModel.partsName = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Parts Name',
                  hintText: 'Enter parts name',
                  isDense: true,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: DateTimeField(
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        labelText: 'Purchase Date',
                        labelStyle: TextStyle(),
                      ),
                      onChanged: (val) =>
                          widget.partsModel.warrantyEnd = val.toString(),
                      format: format,
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now(),
                            ),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                      resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    flex: 1,
                    child: DateTimeField(
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        labelText: 'Warranty end',
                        labelStyle: TextStyle(),
                      ),
                      onChanged: (val) =>
                          widget.partsModel.purchesDate = val.toString(),
                      format: format,
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now(),
                            ),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                      resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                    ),
                  ),
                ],
              ),

              /*  Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      onSaved: (val) => widget.partsModel.purchesDate = val,
                      decoration: InputDecoration(
                        labelText: 'Purches Date',
                        hintText: '20-02-2021',
                        isDense: true,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: TextFormField(
                      onSaved: (val) => widget.partsModel.warrantyEnd = val,
                      decoration: InputDecoration(
                        labelText: 'Warranty End',
                        hintText: '28-05-2021',
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ), */
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Slider(
                    value: _currentPartsValue,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: _currentPartsValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        widget.partsModel.alarmDate = value.toString();
                        _currentPartsValue = value;
                        print('Parts alarm setted is: $value');
                      });
                    },
                  ),
                  Text('Alarm set : $_currentPartsValue days')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///form validator

}

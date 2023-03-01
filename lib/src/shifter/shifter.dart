// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:shifter_core/src/common/observable/obs.dart';
import 'package:shifter_core/src/shifter/core/shifter_core.dart';
import 'package:shifter_core/src/shifter/mapper/shifter_position_mapper.dart';
import 'package:shifter_core/src/shifter/models/direction.dart';
import 'package:shifter_core/src/shifter/models/gear.dart';
import 'package:shifter_core/src/shifter/models/shifter_event.dart';
import 'package:shifter_core/src/shifter/models/shifter_position.dart';

abstract class IShifter {
  bool get isActive;
  bool get isLocked;

  IReadonlyObs<ShifterPosition> get position;
  IReadonlyObs<Gear> get gear;

  void setCore(IShifterCore newCore);

  void handleShifterEvent(ShifterEvent event);

  IShifterPositionMapper get mapper;
}

class Shifter implements IShifter {
  Shifter(IShifterCore core)
    : _core = core,
      gear = core.gear.obs,
      position = core.position.obs;

  IShifterCore _core;

  @override
  void setCore(IShifterCore newCore) {
    _core = newCore;
    _updateObsValues();
  }
  
  @override
  final IObs<ShifterPosition> position;

  @override
  final IObs<Gear> gear;

  @override
  bool get isActive => _core.isActive;

  @override
  bool get isLocked => _core.isLocked;

  @override
  void handleShifterEvent(ShifterEvent event) {
    final direction = getDirectionAtEvent(event);
    if(direction != null) _core.handleDirection(direction);

    else if(event == ShifterEvent.take) _core.setActive(true);
    else if(event == ShifterEvent.dismiss) _core.setActive(false);
    else if(event == ShifterEvent.lock) _core.setLocked(true);
    else if(event == ShifterEvent.unlock) _core.setLocked(false);

    else throw Exception("Unknown shifter event");

    _updateObsValues();
  }

  void _updateObsValues() {
    gear.setValue(_core.gear);
    position.setValue(_core.position);
  }
  
  @override
  IShifterPositionMapper get mapper => _core.mapper;
}
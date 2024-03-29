/// Support for doing something awesome.
///
/// More dartdocs go here.
library shifter_core;

export 'src/common/observable/dispose_wrapper.dart';
export 'src/common/extentions/map_extention.dart';
export 'src/common/observable/obs.dart';
export 'src/common/observable/observable.dart';
export 'src/common/entity.dart';
export 'src/shifter/calculate/shifter_gear_calculator.dart';
export 'src/shifter/calculate/shifter_position_calculator.dart';
export 'src/shifter/core/mechanical_shifter_core.dart';
export 'src/shifter/core/shifter_core.dart';
export 'src/shifter/mapper/shifter_position_mapper.dart' show IShifterPositionMapper;
export 'src/shifter/mapper/default_mappers.dart';
export 'src/shifter/mapper/shifter_position_factory.dart' show
  IShifterPositionFactory,
  IShifterPositionMapperSerializer,
  createMapper,
  ShifterPositionMapperSerializer;
  
export 'src/shifter/models/direction.dart'; 
export 'src/shifter/models/gear.dart';
export 'src/shifter/models/shifter_event.dart';
export 'src/shifter/models/shifter_position.dart';
export 'src/shifter/shifter.dart';

// TODO: Export any libraries intended for clients of this package.
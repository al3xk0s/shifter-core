import 'package:shifter_core/src/common/extentions/map_extention.dart';

import '../models/gear.dart';
import '../models/shifter_position.dart';
import 'shifter_position_mapper.dart';

typedef IShifterPositionFactory
   = IShifterPositionMapper Function(int id, String name, Map<ShifterPosition, Gear> source);

IShifterPositionMapper createMapper(int id, String name, Map<ShifterPosition, Gear> source)
  => ShifterPositionMapper(id: id, name: name, targetMap: source);

abstract class IShifterPositionMapperSerializer {
  Map<String, dynamic> toMap(IShifterPositionMapper mapper);
  IShifterPositionMapper fromMap(Map<String, dynamic> data);

  List<Map<String, dynamic>> toMapList(List<IShifterPositionMapper> mappers);
  List<IShifterPositionMapper> fromMapList(List<Map<String, dynamic>> data);
}

class ShifterPositionMapperSerializer implements IShifterPositionMapperSerializer {
  ShifterPositionMapperSerializer(IShifterPositionFactory mapperFactory) : _factory = mapperFactory;

  final IShifterPositionFactory _factory;

  @override
  List<IShifterPositionMapper> fromMapList(List<Map<String, dynamic>> data)
    => data.map(fromMap).toList();

  @override
  IShifterPositionMapper fromMap(Map<String, dynamic> data) => _factory.call(
    data['id'],
    data['name'],
    _decodePositionMap(data['values']),
  );

  Map<String, dynamic> _encodePosition(ShifterPosition position) => {
    'vertical': position.vertical.value,
    'horizontal': position.horizontal.value,
  };

  ShifterPosition _decodePosition(Map<String, dynamic> data) =>
    ShifterPosition(
      VerticalPosition(data['vertical']), 
      HorizontalPosition(data['horizontal']),
    );

  Map<ShifterPosition, Gear> _decodePositionMap(List<Map<String, dynamic>> data) 
    => Map.fromEntries(
      data.map(
        (d) => MapEntry<ShifterPosition, Gear>(
          _decodePosition(d),
          Gear.values[d['gear']],
        )
      ),
    );

  List<Map<String, dynamic>> _encodePositionMap(Map<ShifterPosition, Gear> source)
    => source
      .entries
      .map(
        (e) => _encodePosition(e.key)..put('gear', e.value.index)
      )
      .toList();

  @override
  Map<String, dynamic> toMap(IShifterPositionMapper mapper) => {
    'id': mapper.id,
    'name': mapper.name,
    'values': _encodePositionMap(mapper.toMap()),
  };

  @override
  List<Map<String, dynamic>> toMapList(List<IShifterPositionMapper> mappers)
    => mappers.map(toMap).toList();
}

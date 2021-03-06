
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vic_19/Model/City.dart';
import 'package:vic_19/Model/Location.dart';
import 'package:vic_19/Model/LocationData.dart';

abstract class TablesEvent extends Equatable{
}
class TablesGetCitiesEvent extends TablesEvent{
  DateTime _dateCities;
  TablesGetCitiesEvent(this._dateCities);
  // TablesGetCitiesEvent();
  @override
  List<Object> get props => [_dateCities];
  // List<Object> get props => [];
}

class TablesGetMunicipalityEvent extends TablesEvent{
  // LocationData _location;
  // int _locationId;
  City _city;
  DateTime _dateTime;
  // TablesGetMunicipalityEvent(this._location);
  TablesGetMunicipalityEvent(this._dateTime,this._city);
  @override
  List<Object> get props => [_dateTime,_city];

}

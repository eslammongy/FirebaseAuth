
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/data/searced_place.dart';
import 'package:flutter_maps/helper/places_services.dart';
import 'package:flutter_maps/logic/map_cubit/maps_status.dart';

class MapsPartBloc extends Cubit<MapsBlocStatus>{

  static MapsPartBloc get(context) => BlocProvider.of(context);

  MapsPartBloc(): super(MapsInitialStatus());
  
  final PlacesServices placesServices = PlacesServices();
  late List<PlaceSearch> searchResultList;

   getSearchPlaces(String cityName)async{
    searchResultList = await placesServices.getAutoCompleteSearchedPlaces(cityName);
    emit(GetAutoCompleteSearchedPlacesSuccess());
    print(searchResultList.length);
  }
}

abstract class MapsBlocStatus {}


class MapsInitialStatus extends MapsBlocStatus {}

class GetAutoCompleteSearchedPlacesLoading extends MapsBlocStatus{}
class GetAutoCompleteSearchedPlacesSuccess extends MapsBlocStatus{}
class GetAutoCompleteSearchedPlacesError extends MapsBlocStatus{
  final String errorMessage;

  GetAutoCompleteSearchedPlacesError({required this.errorMessage});
}
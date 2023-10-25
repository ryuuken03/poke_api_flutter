import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/pokemon_view_model.dart';
import '../view_model/pokemon_detail_view_model.dart';

final pokemonProvider = ChangeNotifierProvider((_) => PokemonViewModel());
final pokemonDetailProvider = ChangeNotifierProvider((_) => PokemonDetailViewModel());

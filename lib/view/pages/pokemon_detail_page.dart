import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_api/util/providers.dart';
import 'package:poke_api/util/string_extention.dart';
import 'package:poke_api/view/widgets/body_builder.dart';

class PokemonDetailPage extends ConsumerStatefulWidget {
  const PokemonDetailPage({
    this.title, 
    this.url, 
    super.key});

  final String? title;
  final String? url;
  static const String routeName = "/pokemon-detail";

  @override
  ConsumerState<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends ConsumerState<PokemonDetailPage> {

  @override
  void initState() {
    ref.read(pokemonDetailProvider).getAPIDetailPokemon(widget.url!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    var viewModel = ref.watch(pokemonDetailProvider);
    var data = viewModel.data;
    List<Widget> imageWidgets = viewModel.getImages();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title != null ? widget.title! : "Detail Pokemon"),
      ),
      body: BodyBuilder(
        apiRequestStatus: viewModel.requestStatus, 
        reload: () => viewModel.getAPIDetailPokemon(widget.url!),
        child: Container(
          padding: EdgeInsets.all(10),
          child: 
            data == null
            ? Container()
            : ListView(
                children: [
                  RowTableWidget(
                    label: "Name",
                    value: data.name!.titleCase(),
                  ),
                  imageWidgets.length > 0
                  ? Row(
                      children:imageWidgets
                    )
                  : Container(),
                  RowTableWidget(
                    label: "Height",
                    value: (data.height / 10).toDouble().toString()+ " m",
                  ),
                  RowTableWidget(
                    label: "Weight",
                    value: (data.weight / 10).toDouble().toString() + " Kg",
                  ),
                  data.base_experience == null
                  ? Container()
                  : RowTableWidget(
                    label: "Base Experience",
                    value: data.base_experience.toString(),
                  ),
                  RowTableWidget(
                    label: "Stats",
                    value: viewModel.getStats(),
                  ),
                  RowTableWidget(
                    label: "Types",
                    value: viewModel.getTypes(),
                  ),
                  RowTableWidget(
                    label: "Moves",
                    value: viewModel.getMoves(),
                  ),
                  RowTableWidget(
                    label: "Abilities",
                    value: viewModel.getAbilities(),
                  ),
                ],
              ),
        )
      ),
    );
  }
}

class RowTableWidget extends StatelessWidget {
  const RowTableWidget({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,  
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            child: Text(
              ": ",
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
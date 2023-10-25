import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_api/data/models/default.dart';
import 'package:poke_api/util/api_request_status.dart';
import 'package:poke_api/util/providers.dart';
import 'package:poke_api/util/string_extention.dart';
import 'package:poke_api/view/pages/pokemon_detail_page.dart';
import 'package:poke_api/view/widgets/body_builder.dart';

class PokemonPage extends ConsumerStatefulWidget {
  const PokemonPage({
    this.url, 
    super.key});

  final String? url;
  static const String routeName = "/pokemon";

  @override
  ConsumerState<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends ConsumerState<PokemonPage> {
  List<Default> listDataShow  = [];
  List<String> listImageShow  = [];

  TextEditingController searchController = TextEditingController();

  late ScrollController controller = ScrollController()
    ..addListener(scrollListener);

  @override
  void initState() {
    ref.read(pokemonProvider).getAPIPokemon(widget.url!).then((value){
      ref.read(pokemonProvider).getApiPokemonLoadMore();
    });
    super.initState();
  }

  void pustToDetailPokemon(BuildContext context, String key, String value) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          print("Push to Detail Pokemon");
          return PokemonDetailPage(title: key.titleCase(), url: value);
        },
      ),
    );
  }
  void scrollListener() {
    if (controller.position.extentAfter == 0) {
      var viewModel = ref.watch(pokemonProvider);
      if (viewModel.requestStatus == APIRequestStatus.loaded  && viewModel.urlNext!= null) {
        viewModel.getApiPokemonLoadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(pokemonProvider);
    listDataShow = viewModel.listShow;
    listImageShow = viewModel.listImageShow;
    var grid = 2; //2 : 1
    var aspectRasio = 3.0; //3.5 : 6.5
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon"),
      ),
      body: BodyBuilder(
        apiRequestStatus: viewModel.requestStatus, 
        reload: () => viewModel.getAPIPokemon(widget.url!),
        child: listDataShow.length == 0
          ? Container()
          : ListView(
            controller: controller,
            children: [
              GridView.builder(
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: grid, childAspectRatio: aspectRasio),
                itemCount: listDataShow.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var item = listDataShow[index];
                  return GestureDetector(
                    onTap: () {
                      pustToDetailPokemon(context, item.name!.replaceAll("-", " ").titleCase(), item.url!);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        children: [
                          Image.network(listImageShow[index],width: 40,height: 40,),
                          Expanded(
                            child: Text(
                              item.name!.replaceAll("-", " ").titleCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              viewModel.requestStatus == APIRequestStatus.loading
              ? Container(
                margin: EdgeInsets.all(10),
                child: Center(child: CircularProgressIndicator())
              )
              :Container() 
            ]
          ),
      ),
    );
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pjsk_sticker/pages/sticker.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});
  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  bool _first = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    const String about =
        "UHJvamVjdCBTZWthaSBTdGlja2Vy5Li65YWN6LS56L2v5Lu277yM5aaC5p6c5oKo5piv5LuY6LS56I635b6X77yM6K+356uL5Y2z6YCA5qy+77yBClByb2plY3QgU2VrYWkgU3RpY2tlcu+8iOS7peS4i+eugOensOKAnOacrOi9r+S7tuKAne+8ieeUqOaIt+WNj+iurueUseacrOi9r+S7tuW8gOWPkeiAhe+8iOS7peS4i+eugOensOKAnOaIkeS7rOKAne+8ieS4jueUqOaIt+etvuiuouOAgueUqOaIt+W6lOiupOecn+mYheivu+OAgeWFheWIhueQhuino+acrOWNj+iuruS4reWQhOadoeasvu+8jOivt+eUqOaIt+WuoeaFjumYheivu+W5tumAieaLqeaOpeWPl+aIluS4jeaOpeWPl+acrOWNj+iuriAo5pyq5oiQ5bm05Lq65bqU5Zyo5rOV5a6a55uR5oqk5Lq66Zmq5ZCM5LiL6ZiF6K+7KeOAggogICAg6Zmk6Z2e5oKo5o6l5Y+X5pys5Y2P6K6u5p2h5qy+77yM5ZCm5YiZ5oKo5peg5p2D5LiL6L2944CB5a6J6KOF5oiW5L2/55So5pys6L2v5Lu25Y+K5YW255u45YWz5pyN5Yqh44CC5oKo55qE5a6J6KOF44CB5L2/55So6KGM5Li65bCG6KeG5Li65a+55pys5Y2P6K6u55qE5o6l5Y+X77yM5bm25ZCM5oSP5o6l5Y+X5pys5Y2P6K6u5ZCE6aG55p2h5qy+55qE57qm5p2f44CCCgogICAg44CQ55So5oi356aB5q2i6KGM5Li644CRCiAgICAgICDml6DorrrlnKjku7vkvZXmg4XlhrXkuIvvvIznlKjmiLfpg73kuI3lvpfkvZzlh7rmnKzova/ku7bnpoHmraLnmoTooYzkuLrvvJoKICAgIO+8iDHvvInnpoHmraLlr7nmnKzova/ku7bov5vooYzkv67mlLnjgIHnr6HmlLnvvJsKICAgIO+8iDLvvInnpoHmraLlnKjmnKrnu4/ov4fmiJHku6zmjojmnYPlhYHorrjnmoTmg4XlhrXkuIvlkJHku7vkvZXmuKDpgZPlj5HluIPmnKzova/ku7bnmoTku7vkvZXniYjmnKzvvJsKICAgIO+8iDPvvInnpoHmraLliKnnlKjmnKzova/ku7bov5vooYzku7vkvZXmtonlj4roibLmg4XjgIHmmrTlipvjgIHnp43ml4/mrafop4bjgIHmgZDmgJbkuLvkuYnnrYnkuI3oia/lhoXlrrnnmoTkvKDmkq3lkozlrqPkvKDvvJsKICAgIO+8iDTvvInnpoHmraLlh7rllK7mnKzova/ku7bnmoTku7vkvZXpg6jliIbvvIzljIXmi6zkvYbkuI3pmZDkuo7ova/ku7bmnKzkvZPvvIzmupDku6PnoIHlj4rkvb/nlKjmlrnms5XnrYnjgIIKCiAgICDjgJDlhY3otKPlo7DmmI7jgJEKICAgIO+8iDHvvInmnKzova/ku7bml6jlnKjkuKrkurrmtYvor5XkuI7lrabkuaDlvIDlj5HvvIzor7fli7/nlKjkuo7llYbkuJrnlKjpgJTvvIzor7fli7/nlKjkuo7pnZ7ms5XnlKjpgJTvvJsKICAgIO+8iDLvvInmgqjlv4XpobvlnKjkuIvovb3mnKzova/ku7blkI7nmoQyNOWwj+aXtuWGheWIoOmZpO+8jOS7peS/neaKpOebuOW6lOS6uuWRmOaIluS8geS4mueahOWQiOazleadg+ebiu+8jOWwiumHjeWFtuWKs+WKqOaIkOaenO+8mwogICAg77yIM++8ieacrOi9r+S7tuWPquS/neivgeiHqui6q+S4jeS8muWMheWQq+S7u+S9leaBtuaEj+S7o+egge+8jOS4jeS8muS4u+WKqOaUtumbhuS7u+S9leS4quS6uuS/oeaBr++8jOS9huS4jeiDveS/neivgeesrOS4ieaWueW6k+WuieWFqO+8mwogICAg77yINO+8ieacrOi9r+S7tuWujOWFqOWfuuS6juaCqOS4quS6uuaEj+aEv+S9v+eUqO+8jOaCqOW6lOivpeWvueiHquW3seeahOS9v+eUqOihjOS4uuWSjOaJgOaciee7k+aenOaJv+aLheWFqOmDqOi0o+S7u++8mwogICAg77yINe+8ieacrOi9r+S7tuW5tuS4jeS/neivgeS4juaJgOacieaTjeS9nOezu+e7n+aIluehrOS7tuiuvuWkh+WFvOWuueOAguaIkeS7rOS4jeWvueWboOS9v+eUqOacrOi9r+S7tuiAjOS6p+eUn+eahOS7u+S9leaKgOacr+aIluWuieWFqOmXrumimOaJv+aLhei0o+S7u++8mwogICAg77yINu+8ieacrOi9r+S7tuS4jeS8muaUtumbhuOAgeWtmOWCqOOAgeS9v+eUqOS7u+S9leeUqOaIt+eahOS4quS6uuS/oeaBr++8jOWMheaLrOS9huS4jemZkOS6juWnk+WQjeOAgeWcsOWdgOOAgeeUteWtkOmCruS7tuWcsOWdgOOAgeeUteivneWPt+eggeetieOAguWcqOS9v+eUqOacrOi9r+S7tui/h+eoi+S4re+8jOS4jeS8mui/m+ihjOS7u+S9leW9ouW8j+eahOS4quS6uuS/oeaBr+mHh+mbhu+8mwogICAg77yIN++8ieeUqOaIt+WboOesrOS4ieaWueWmgueUteS/oemDqOmXqOeahOmAmuiur+e6v+i3r+aVhemanOOAgeaKgOacr+mXrumimOOAgee9kee7nOOAgeeUteiEkeaIluaJi+acuuaVhemanOOAgeWwhuezu+e7n+S4jeeos+WumuaAp+WPiuWFtuS7luWQhOenjeS4jeWPr+aKl+WKm+WOn+WboOiAjOmBreWPl+eahOe7j+a1juaNn+Wkse+8jOaIkeS7rOS4jeaJv+aLhei0o+S7u+OAggoKICAgIOOAkOWFtuWug+adoeasvuOAkQogICAg77yIMe+8ieaIkeS7rOS/neeVmemaj+aXtuS/ruaUueOAgeWinuWKoOOAgeWIoOmZpOacrOWNj+iuruS4reeahOWGheWuueiAjOS4jeWPpuihjOmAmuefpeeahOadg+WIqeOAgueUqOaIt+WPr+S7peWcqOacrOi9r+S7tueahOacgOaWsOeJiOacrOS4reafpemYheebuOWFs+adoeasvuWNj+iuruOAguacrOWNj+iuruadoeasvuWPmOabtOWQju+8jOWmguaenOeUqOaIt+e7p+e7reS9v+eUqOacrOi9r+S7tu+8jOWNs+inhuS4uueUqOaIt+W3suWQjOaEj+S/ruaUueWQjueahOWNj+iuruOAguWmguaenOeUqOaIt+S4jeWQjOaEj+S/ruaUueWQjueahOWNj+iuru+8jOW6lOW9k+eri+WNs+WBnOatouS9v+eUqOacrOi9r+S7tu+8mwogICAg77yIMu+8ieacrOWNj+iuruaJgOacieeahOadoeasvuagh+mimOS7heS4uumYheivu+aWueS+v++8jOacrOi6q+W5tuaXoOWunumZheWQq+S5ie+8jOS4jeiDveS9nOS4uuacrOWNj+iurua2teS5ieino+mHiueahOS+neaNru+8mwogICAg77yIM++8ieaIkeS7rOS/neeVmeWvueS6juacrOWNj+iurueahOacgOe7iOino+mHiuadg+OAgg==";

    Future.microtask(() {
      if (mounted && _first) {
        _first = false;
        showAdaptiveDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("关于"),
              content: SingleChildScrollView(
                padding: EdgeInsets.all(8),
                child: Text(
                  utf8.decode(base64Decode(about)),
                  softWrap: true,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("关闭"),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: StickerPage());
  }
}

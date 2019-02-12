part of agenda;




class FirestoreListView extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  final String nombreDB;

  FirestoreListView({this.documents,this.nombreDB});

  @override
  Widget build(BuildContext context) {
    DatosAgenda dFrm= new DatosAgenda();


    final BorderSide bordeFuera = new BorderSide(color: Colors.green, width: 2.0);

    final DateTime fDesde  = DateTime.now().add(new Duration(days: -2));
    final DateTime fHasta = DateTime.now().add(new Duration(days: 8));
    List<IconData> oi =[
      MdiIcons.accountBox,
      MdiIcons.hospitalBuilding,
      MdiIcons.pharmacy,
      MdiIcons.infinity
    ];


    Container miTabla(int index) {

      TableRow fila(String palabra,var key,var ref,bool btn){
        IconData doyIcono(){
          if(dFrm.donde=="Consultorio") return oi[0];
          if(dFrm=="Hóspital") return oi[1];
          if(dFrm=="Farmacia") return oi[2];
          if(dFrm=="Otro") return oi[3];
          return Icons.error;



        }
        return   new TableRow(
            children: <Widget>[

              btn? new Padding(
                 padding: const EdgeInsets.only(left: 10.0),
                 child:new ListTile(
                   //accountBox,hospitalBuilding,pharmacy,infinity
                   leading: new Icon(doyIcono()),
                           title:  new Padding(
                             padding: const EdgeInsets.only(left: 5.0),
                             child:new Text(palabra),
                            )
                 )): new Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: new Text(palabra,overflow: TextOverflow.ellipsis,)
              ),
         btn? IconButton(
             icon: Icon(Icons.edit),
             onPressed: () {
                 Navigator.push(
                 context,
                 new MaterialPageRoute(
                     builder: (context) => new FrmAgenda(
                         nombreDB:nombreDB,
                         dBkey: key)),
               );
             }
         ): new Text(""),

          btn?IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Firestore.instance.runTransaction((transaction) async {
                DocumentSnapshot snapshot =
                await transaction.get(ref);
                await transaction.delete(snapshot.reference);
              });
            },
          ): new Text(""),//Delete
        ]);

      }
      String fechaEstado(){
        List<String> tipo=["Pendiente","listo","Vencida"];
        return "${formateoFechaL(dFrm.cuando)}->${tipo[dFrm.vencida]}";


      }

      Color colorContainer(DateTime fDesde,DateTime f, DateTime fHasta) {
        bool queColor=fDesde.isBefore(f) && f.isBefore(fHasta);
        return queColor?Colors.pink:Colors.blueGrey;
      }

      return Container(
          color: colorContainer(fDesde,dFrm.cuando,fHasta),
          //transform: new Matrix4.rotationZ(0.1),
          padding: EdgeInsets.all(10.0),
          child: new Table(
              border: new TableBorder(
                top: bordeFuera,
                right: bordeFuera,
                bottom: bordeFuera,
                left: bordeFuera,

              ),

              columnWidths: const <int, TableColumnWidth> {
                //0: FixedColumnWidth(35.0),
                1: FixedColumnWidth(100.0),
                2: FixedColumnWidth(35.0),
                3: FixedColumnWidth(35.0),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                fila(fechaEstado(),
                     documents[index].documentID,
                     documents[index].reference,
                     false),
                fila("${dFrm.donde}/${dFrm.que}/${dFrm.quien}",
                     documents[index].documentID,
                     documents[index].reference,
                     true),
                fila(dFrm.asunto,
                     documents[index].documentID,
                     documents[index].reference,
                     false),
               ]
          ));
    }




    return ListView.builder(
      itemCount: documents.length,

        //itemExtent: 110.0,

      itemBuilder: (BuildContext context, int index) {
        dFrm.lectura(documents[index].data);


        return miTabla(index);

      },
    );
  }



}



part of agenda;

class SoporteFrmAgenda{

  List<String> doyDonde(){

    return ["Consultorio","Hóspital","FPopular","Siquiatra","Otro"];
  }

  List<String> doyQue(){
      return[
        "Médico", "Exámen","Inyeccion"
      ];
  }

  List<String> doyQuien(){
    return[
      "Mary", "Max","Ambos"
    ];
  }




  String sHoy(){
    DateTime f = DateTime.now();
    return formateoFechaL(f);

  }


}
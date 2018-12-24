part of agenda;

class DatosAgenda
{
String donde;
String que;
String quien;
DateTime cuando;
String asunto;
String nota;
int vencida;

inicio(SoporteFrmAgenda sop){

  donde=sop.doyDonde()[0];
  que=sop.doyQue()[0];
  quien=sop.doyQuien()[0];
  cuando=DateTime.now();
  asunto="";
  nota="";
  vencida=0;
}

lectura(Map snap){
  donde= snap['donde'];
  que= snap['que'];
  quien= snap['quien'];
  cuando=snap['cuando'];
  asunto= snap['asunto'];
  nota= snap['nota'];
  vencida= snap['vencida'];

}

}
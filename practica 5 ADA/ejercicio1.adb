{1. Se requiere modelar un puente de un solo sentido, el puente solo soporta el peso de 5 
unidades de peso. Cada auto pesa 1 unidad, cada camioneta pesa 2 unidades y cada camión 
3 unidades. Suponga que hay una cantidad innumerable de vehículos (A autos, B 
camionetas y C camiones). 
a. Realice la solución suponiendo que todos los vehículos tienen la misma prioridad. 
b. Modifique la solución para que tengan mayor prioridad los camiones que el resto de los 
vehículos. }

//a. Realice la solución suponiendo que todos los vehículos tienen la misma prioridad. 


Procedure Puente is

Task auto;
Task camioneta;
Task camión;
Task coordinador is
     Entry pedidoAuto();
     Entry pedidoCamion();
     Entry pedidoCamioneta();
End coordinador;

arrAutos: array(1..A) of auto;
arrCamionetas: array(1..B) of camioneta;
arrCamiones: array(1..C) of camión

Task Body coordinador is
  pesoTotal:int
Begin
  pesoTotal=0; //inicializo
  loop
   SELECT
    WHEN(pesoTotal + 1 <= 5) --> accept pedidoAuto do
                                   pesoTotal=pesoTotal + 1;
                                 end pedidoAuto;
    OR
    WHEN(pesoTotal + 2 <= 5) --> accept pedidoCamioneta do
                                   pesoTotal=pesoTotal + 2;
                                 end pedidoCamioneta;
    OR
    WHEN(pesoTotal + 3 <= 5) --> accept pedidoCamion do
                                  pesoTotal=pesoTotal + 3;
                                 end pedidoCamion;

    OR accept salir(p: IN int) do
              pesoTotal= pesoTotal - p;
    end salir;

   END SELECT
  end loop;
End coordinador;

//es NECESARIO tener 3 Entry distintos, uno para cada vehiculo, para poder asociar el vehicuo con su propio peso
Task Body auto is
  peso:int;
Begin
  peso=1;
  Coordinador.pedidoAuto; //pide permiso para pasar
  --cruzando;
  Coordinador.salir(peso); //le avisa que se retira
End auto;

Task Body camioneta is
 peso:int;
Begin
  peso=2;
  Coordinador.pedidoCamioneta;
  --cruzando;
  Coordinador.salir(peso);
End camioneta;

Task Body camión is
  peso:int;
Begin
  peso=3;
  Coordinador.pedidoCamion;
  --cruzando;
  Coordinador.salir(peso);
End camión;

//codio ppal: no va nada porque todas las tareas se ejecutan por si solas
Begin
  null;
End Puente;

///////////////////////////////////////////////////////////////////////
// b. Modifique la solución para que tengan mayor prioridad los camiones que el resto de los 
vehículos.


//cambios: El accept PedidoCamion siempre se evalúa sin condición.
//Las otras (PedidoCamioneta y PedidoAuto) deben evaluarse solo si no hay camiones esperando.

Procedure Puente is

Task auto;
Task camioneta;
Task camión;
Task coordinador is
     Entry pedidoAuto();
     Entry pedidoCamion();
     Entry pedidoCamioneta();
End coordinador;

arrAutos: array(1..A) of auto;
arrCamionetas: array(1..B) of camioneta;
arrCamiones: array(1..C) of camión

Task Body coordinador is
  pesoTotal:int
Begin
  pesoTotal=0; //inicializo
  loop
   SELECT
    WHEN(pesoTotal + 1 <= 5) and (pedidoCamion'count = 0) --> accept pedidoAuto do
                                                              pesoTotal=pesoTotal + 1;
                                                              end pedidoAuto;
    OR
    WHEN(pesoTotal + 2 <= 5) and (pedidoCamion'count = 0) --> accept pedidoCamioneta do
                                                              pesoTotal=pesoTotal + 2;
                                                              end pedidoCamioneta;
    OR
    WHEN(pesoTotal + 3 <= 5) --> accept pedidoCamion do
                                  pesoTotal=pesoTotal + 3;
                                 end pedidoCamion;

    OR accept salir(p: IN int) do
              pesoTotal= pesoTotal - p;
    end salir;

   END SELECT
  end loop;
End coordinador;

//es NECESARIO tener 3 Entry distintos, uno para cada vehiculo, para poder asociar el vehicuo con su propio peso
Task Body auto is
  peso:int;
Begin
  peso=1;
  Coordinador.pedidoAuto; //pide permiso para pasar
  --cruzando;
  Coordinador.salir(peso); //le avisa que se retira
End auto;

Task Body camioneta is
 peso:int;
Begin
  peso=2;
  Coordinador.pedidoCamioneta;
  --cruzando;
  Coordinador.salir(peso);
End camioneta;

Task Body camión is
  peso:int;
Begin
  peso=3;
  Coordinador.pedidoCamion;
  --cruzando;
  Coordinador.salir(peso);
End camión;

//codio ppal: no va nada porque todas las tareas se ejecutan por si solas
Begin
  null;
End Puente;


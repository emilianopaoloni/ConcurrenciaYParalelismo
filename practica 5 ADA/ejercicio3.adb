{3. Se dispone de un sistema compuesto por 1 central y 2 procesos. Los procesos envían 
señales a la central. La central comienza su ejecución tomando una señal del proceso 1, 
luego toma aleatoriamente señales de cualquiera de los dos indefinidamente. Al recibir una 
señal de proceso 2, recibe señales del mismo proceso durante 3 minutos. 
El proceso 1 envía una señal que es considerada vieja (se deshecha) si en 2 minutos no fue 
recibida. 
El proceso 2 envía una señal, si no es recibida en ese instante espera 1 minuto y vuelve a 
mandarla (no se deshecha). }

Procedure Sistema

task Central is
   entry SeñalUno();
   entry SeñalDos();
end Central;

task  Proceso1;
task  Proceso2;

task body Central is
boolean modoExclusivo:= false; //cuando esta var el true,la central recibe señales solo del p2
begin
  accept SeñalUno(); //recibe señal de p1
  loop
    select //toma aleatoriamente señales de p1 o p2
      
       when(not modoExclsivo) -->    accept SeñalUno;

    or when(not modoExclusivo) --> accept SeñalDos;  
                                   modoExlusivo:= true;
                                                              

    or  when (modoExclusivo)   --> accept SeñalDos; //recibe solo señales de p2 por 3 minutos
                                      end select

    or when (modoExclusivo)   --> delay 180;
                                  modoExclusivo:=false;
  end loop
end Central

task body Proceso1 is 
begin
 loop
   select
     Central.SeñalUno;
   or delay 120
     --se desecha la señal
   end select
   --genera una nueva señal
 end loop
end Proceso1

task body Proceso2 is 
boolean aceptada:=false;
begin
 loop
   select
     Central.señalDos;
   or delay 60 
     --vuelve a mandar la misma señal (no se desecha)
   end select
 end loop
end Proceso2


begin
  null
end Sistema
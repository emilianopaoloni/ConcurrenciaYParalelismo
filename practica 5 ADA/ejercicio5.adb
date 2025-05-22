{5. En un sistema para acreditar carreras universitarias, hay UN Servidor que atiende pedidos 
de U Usuarios de a uno a la vez y de acuerdo al orden en que se hacen los pedidos. Cada 
usuario trabaja en el documento a presentar, y luego lo envía al servidor; espera la respuesta 
del mismo que le indica si está todo bien o hay algún error. Mientras haya algún error vuelve 
a trabajar con el documento y a enviarlo al servidor. Cuando el servidor le responde que 
está todo bien el usuario se retira. Cuando un usuario envía un pedido espera a lo sumo 2 
minutos a que sea recibido por el servidor, pasado ese tiempo espera un minuto y vuelve a 
intentarlo (usando el mismo documento). }

Procedure Sistema

task Servidor
  entry Pedido (doc IN texto; respuesta OUT integer);
end Servidor;

task type Usuario;

arrUsuarios = array (1..U) of Usuario;

task body Usuario is
    documento: texto;
    rta: integer;
    hacerNuevo: integer;
begin
    rta:=1;
    hacerNuevo:=1;
    while rta = 1 loop
      if hacerNuevo = 1 then
            documento:= hacerDocumento(); //hace documento nuevo
      end if;

      select 

         Servidor.Pedido(documento, rta);
         hacerNuevo:= rta;
      or delay 120
         delay 60;
         hacerNuevo:= 0; //no hay que volver a hacer el documento
      end select;
    end loop;
end Usuario;

task body Servidor is
    loop
       accept Pedido(doc, respuesta);
             respuesta:= analizarDocumento(doc); // asigna 1 si esta mal, y 0 si esta bien
       end Pedido;
    end loop;
end Servidor;

 
begin
  null;
end Sistema;


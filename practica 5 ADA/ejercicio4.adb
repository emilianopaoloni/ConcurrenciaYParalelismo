{4. En una clínica existe un médico de guardia que recibe continuamente peticiones de 
atención de las E enfermeras que trabajan en su piso y de las P personas que llegan a la 
clínica ser atendidos.  
Cuando una persona necesita que la atiendan espera a lo sumo 5 minutos a que el médico lo 
haga, si pasado ese tiempo no lo hace, espera 10 minutos y vuelve a requerir la atención del 
médico. Si no es atendida tres veces, se enoja y se retira de la clínica. 
Cuando una enfermera requiere la atención del médico, si este no lo atiende inmediatamente 
le hace una nota y se la deja en el consultorio para que esta resuelva su pedido en el 
momento que pueda (el pedido puede ser que el médico le firme algún papel). Cuando la 
petición ha sido recibida por el médico o la nota ha sido dejada en el escritorio, continúa 
trabajando y haciendo más peticiones. 
El médico atiende los pedidos teniendo dándoles prioridad a los enfermos que llegan para ser 
atendidos. Cuando atiende un pedido, recibe la solicitud y la procesa durante un cierto 
tiempo. Cuando está libre aprovecha a procesar las notas dejadas por las enfermeras.}

Procedure Clinica

task Medico is
  entry EsperaEnfermera();
  entry EsperaPersona();
end Medico;

task Escritorio is
  entry EnvioNota(nota: in Text; recibido: out Integer); //enfermera envia nota
  entry DameNota(n: out Text); //medico pide nota
end Escritorio

task type Enfermera;
task type Persona;

arrEnfermeras: array(1..E) of Enfermera;
arrPersonas: array(1..C) of Persona;

task body Enfermera is
  nota: text;
  recibido: integer;
begin
  loop
    --trabajar;
    select
      Medico.esperaEnfermera;
  
    else
      nota = escribirNota();
      Escritorio.envioNota(nota, recibido);

    end select;
  end loop;
end Enfermera;


task body Persona
intentos: integer;
begin
  intentos=0;
  loop
    select
       Medico.esperaPersona;
       exit; //ya lo atendieron, sale del loop
     
    or delay 300 //espera 5 minutos
       intentos++;
       (if intentos=3) exit; //sale del loop
       delay 600 //espera 10 minutos antes de volver a pedir atención al medico

    end select;
  end loop;
  -- se va de la clinica;
end Persona;


task body Medico
  text n; //nota
begin
  loop
    select
      accept esperaEnfermera;
      --atiende a enfermera;
    
    or when(esperaEnfermera'count = 0) --> accept esperaPersona;
                                           --atiende a persona;

    or when(esperaEnfermera'count = 0) and (esperaPersona'count = 0) --> select
                                                                           Escritorio.dameNota(n);
                                                                           procesarNota(n); 
                                                                         or
                                                                         else
                                                                            //si no hay notas, no se queda esperando
                                                                            //sige trabajando
                                                                            null
                                                                         end select;
    end select;
  end loop;
end Medico


task body Escritorio
  text n; //nota
  queue notas;
begin
  loop
    select
       accept envioNota(nota: IN text, recibido: OUT integer);
              recibido=1;
              push(notas, nota); //guarda la nota en el buffer
       end envioNota;
    or
       when (not empty(notas)) --> accept dameNota(nota: OUT text); //el medico le pide una nota
                                   pop(notas, nota); //envia la nota desencolándola del buffer
                                   end dameNota;
    end select;
  end loop;
end Escritorio;


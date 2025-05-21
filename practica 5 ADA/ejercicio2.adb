{2. Se quiere modelar la cola de un banco que atiende un solo empleado, los clientes llegan y si 
esperan más de 10 minutos se retiran}

Procedure Banco

task Empleado is
  entry pedido();
end Empleado

task type Cliente;

arrClientes: array[1..C] of cliente;

task body Cliente is
Begin
  SELECT
    empleado.pedido();
    --cliente fue atendido
  OR DELAY 600 //espera 10 minutos a ser atendido
    --cliente se va
  END SELECT
end Cliente;

task body Empleado is
   loop
     ACCEPT pedido();
     --atiende cliente;
     END pedido;
   end loop;

end Empleado

Begin
  null
End Banco
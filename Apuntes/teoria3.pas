{
   Teoria de FOD:
   Algoritmica clasica sobra archivos.
   Archivo maestro: Resume informacion sobre el dominio de un problema espeigico.
   Ejemplo: El archivo de productos de una empresa.
   Archivo detalle: Contiene movimientos realizados sobre la informacion almacenada en el maestro.
   Ejemplo: archivo conteniendo las ventas sobre esos productos
   
   Es importante analizar las precondiciones de cada caso particular
   Los algoritmos a desarrollar deben tener en cuenta estas precondiciones, caso contrario determina la falla de su ejecucion
   
   Ejemplo de preconciciones:
   *Existe un archivo maestro
   *Existe un unico archivo detalle que modifica a maestro
   *Cada registro del detalle modifica a un solo registro del maestro que seguro eiste.
   *No todos los reistros del maestro son necesariamete modificados.
   *Cada elemento del mestro que se modifica es alterado por un solo elemento del archivo detalle.
   *Ambos archivos estan ordenados por igual criterio
   
   
				Ejemplo: Definicion de tipos:
}

program teoria3;

type
	producto = record
		cod: string;
		descripcion: string;
		pu : real; {precio unitario}
		stock: integer;
	end;
	venta_prod = record
		cod: string;
		cant_vendida: integer;
	end;
	maestro = file of producto;
	detalle = file of venta_prod;
	
	

var
	mae: maestro;
	det: detalle;
	regm: producto;
	regd: venta_prod;
		
begin
	assign(mae, 'archivo_maestro');
	assign(det, 'archivo_detalle');
	reset(mae);
	reset(det);				{damos por hecho que ya existen los archivos}
	
	while(not(EOF(det)) do begin
		read(mae, regm);
		read(det, regd);
		while(regm.cod <> regd.cod) do
			read(mae, regm);
		regm.stock:= regm.stock - regd.cant_vendida);
		seek(mar, filepos(mae)-1);
		write(mae, regm);
	end;
	close(det);
	close(mae);
end.	
	


{
	Actualizacion de un archivo maestro con un arcihvo detalle.
	
	*Mismas precondiciones de antes + * Cada elemento del maestro puede no ser modificado o ser modificado por uno
																																				   o más elementos del detalle

	Buscar diapositivas..

}




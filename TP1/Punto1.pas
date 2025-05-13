{
Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. La carga finaliza
cuando se ingresa el número 30000, que no debe incorporarse al archivo. El nombre del
archivo debe ser proporcionado por el usuario desde teclado.
}


program practica1ejercicio1;

type

	arc_enteros= file of integer;


procedure crearArchivo(var archivo: arc_enteros);
var nombre_archivo: string;
begin
	writeln('Ingrese el nombre del archivo. ');
	readln(nombre_archivo);
	assign(archivo, nombre_archivo);
	rewrite(archivo);
end;



procedure leerDatos(var numeros: arc_enteros);
var num: integer;
begin
	writeln('Ingrese un numero para agregar al archivo');
	read(num);
	while num<> 30000 do begin
		write(numeros, num);
		writeln('Ingrese un numero para agregar al archivo');
		read(num);
	end;
end;



var
	archivo: arc_enteros;
	
BEGIN
	crearArchivo(archivo);
	leerDatos(archivo);
	close(archivo);
END.


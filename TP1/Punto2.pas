{
Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y
el promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.
}


program practica1ejercicio2;

type
	
	arc_enteros= file of integer;

procedure abrirArchivo(var archivo: arc_enteros);
var nombre_archivo: string;
begin
	writeln('Ingrese el nombre del archivo de enteros que quiere abrir. ');
	readln(nombre_archivo);
	assign(archivo, nombre_archivo);
	reset(archivo);
end;

var
	archivo: arc_enteros;
	cant, suma, num, total: integer;
	promedio: real;
	
BEGIN
	suma:= 0; cant:= 0; promedio:= 0; total:=0;
	abrirArchivo(archivo);
	writeln('Numeros contenidos en el archivo: ');
	while not eof(archivo) do begin
		read(archivo, num);
		suma:= suma + num;
		if(num<1500) then
			cant:= cant + 1;
		write(num,' ');
		total:= total + 1;
	end;
	promedio:= suma / total;
	writeln();
	writeln('El promedio de todos los numeros es: ', promedio:3:3);
	writeln('El archivo tiene ', cant, ' numeros menores a 1500');
END.


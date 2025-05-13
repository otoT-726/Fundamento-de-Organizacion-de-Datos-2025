{
	Una empresa posee un archivo con información de los ingresos percibidos por diferentes
	empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
	nombre y monto de la comisión. La información del archivo se encuentra ordenada por
	código de empleado y cada empleado puede aparecer más de una vez en el archivo de
	comisiones.
	Realice un procedimiento que reciba el archivo anteriormente descrito y lo compacte. En
	consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
	única vez con el valor total de sus comisiones.
}


program  ejercicio1;

const valor_alto = 9999;

type
	emp = record
		cod : integer;
		nombre: string;
		comision: real;
	end;
	
	arc=file of emp;
	
procedure leer(var a: arc;var e:emp);
begin
	if(not eof(a)) then
		read(a, e)
	else
		e.cod := valor_alto;
end;
	
	
	
procedure unificar(var a,archivo: arc);
var e: emp; actual: emp; monto_actual: real;
begin
	assign(archivo, 'archivoEmpTP2Actualizado.dat');
	rewrite(archivo);
	leer(a, e);
	while(e.cod <> valor_alto) do begin
		actual:= e;
		monto_actual:= 0;
		while(actual.cod = e.cod) do begin
			monto_actual:= monto_actual + e.comision;
			leer(a,e);
		end;
		actual.comision:= monto_actual;
		write(archivo, actual);
	end;
	close(archivo);
end;


procedure imprimir(e:emp);
begin
	writeln(e.nombre, ', numero de empleado: ', e.cod, ' comision: ',e.comision:2:2);
end;


procedure imprimirArchivo(var archivo: arc);
var e: emp;
begin
	while(not eof(archivo)) do begin
		read(archivo, e);
		imprimir(e);
		writeln();
	end;
end;


procedure leerEmpleado(var e:emp);
begin
	with e do begin
		writeln('Ingrese el numero de empleado '); 
		readln(cod);
		writeln('Ingrese el nombre del empleado '); 
		readln(nombre);
		writeln('Ingrese la comision del empleado '); 
		readln(comision);
	end;
end;


procedure crearArchivo(var a : arc);
var e: emp; nombre: string;
begin
	writeln('Ingrese el nombre del archivo');
	readln(nombre);
	assign(a, nombre);
	rewrite(a);
	leerEmpleado(e);
	while(e.cod <> 0 ) do begin
		write(a, e);
		leerEmpleado(e);
	end;
end;



var a,aNuevo: arc;

begin
	assign(a, 'archivoEmpTP2.dat');
	reset(a);
	//crearArchivo(a);
	//imprimirArchivo(a);
	unificar(a,aNuevo);
	reset(aNuevo);
	imprimirArchivo(aNuevo);
	close(a);
end.

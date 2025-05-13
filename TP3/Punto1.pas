{
	Modificar el ejercicio 4 de la práctica 1 (programa de gestión de empleados),
	agregándole una opción para realizar bajas copiando el último registro del archivo en
	la posición del registro a borrar y luego truncando el archivo en la posición del último
	registro de forma tal de evitar duplicados.
}

program ejercicio1;


type
	Empleado = record
		num: integer;
		apellido: string;
		nombre: string;
		edad: integer;
		dni: longint;
	end;
	
	archivo_empleados = file of empleado;


procedure leerEmpleado(var e: empleado);
begin
	writeln('Ingrese el numero de empleado: ');
	readln(e.num);
	writeln('Ingrese el apellido del empleado: ');
	readln(e.apellido);
	writeln('Ingrese el nombre del empleado: ');
	readln(e.nombre);
	writeln('Ingrese la edad del empleado: ');
	readln(e.edad);
	writeln('Ingrese el DNI de empleado: ');
	readln(e.dni);
end;


procedure crearArchivo(var archivo: archivo_empleados);
var nombre_archivo: string;
begin
	writeln('Ingrese el nombre del archivo de empleados que desea crear. ');
	readln(nombre_archivo);
	assign(archivo, nombre_archivo);
	rewrite(archivo);
end;


procedure cargarArchivo(var archivo: archivo_empleados);
var e: empleado;
begin
	leerEmpleado(e);
	while (e.apellido<> 'fin') do begin
		write(archivo, e);
		leerEmpleado(e);
	end;
end;


procedure A(var archivo: archivo_empleados);
begin
	crearArchivo(archivo);
	cargarArchivo(archivo);
end;


procedure imprimir(e: empleado);
begin
	writeln(e.nombre, ' ', e.apellido, ' ',e.edad, ' Anios', ', numero de empleado: ', e.num, ' DNI: ',e.dni);
end;


procedure buscarEmpleado(var archivo: archivo_Empleados);
var 
	dato: string; 
	e: empleado;
begin
	writeln('Ingrese el nombre o apellido del empleado al que busca');
	readln(dato);
	while(not eof(archivo)) do begin
		read(archivo, e);
		if(e.nombre = dato) or (e.apellido = dato) then
			imprimir(e);
	end;
end;


procedure imprimirArchivo(var archivo: archivo_Empleados);
var e: empleado;
begin
	while(not eof(archivo)) do begin
		read(archivo, e);
		imprimir(e);
		writeln();
	end;
end;


procedure imprimirMayores(var archivo: archivo_empleados);
var e: empleado;
begin
	while(not eof(archivo)) do begin
		read(archivo, e);
		if(e.edad >70) then
			imprimir(e);
	end;
end;


procedure agregarEmpleado(var archivo: archivo_empleados);
var
	e, emp: empleado;
	i: integer;
	existe: boolean;
begin
	leerEmpleado(emp);
	while(emp.apellido <> 'fin') do begin
		existe:= False;
		read(archivo, e);
		for i:= 1 to filesize(archivo)-1 do begin
			if e.num= emp.num then
				existe:= true;
			read(archivo, e);
		end;
		if not existe then begin
			write(archivo, emp);
			writeln('--Empleado cargado con exito--');
		end
		else 
			writeln('--El numero de empleado ingresado ya existe-- ');
		leerEmpleado(emp);
	end;
end;

procedure modificarEdad(var archivo: archivo_empleados);
var e: empleado; num, edad: integer;
begin
	writeln('--Ingrese el numero del empleado que desea modificar: ');
	read(num);
	read(archivo, e);
	while(not eof(archivo) and (num <> e.num)) do
		read(archivo, e);
	if(e.num = num) then begin
		writeln('--Ingrese nueva edad');
		read(edad);
		e.edad:= edad;
		seek(archivo, filepos(archivo)-1);
		write(archivo, e);
		writeln('--Empleado actualizado con exito--');
	end
	else
		writeln('--El numero de empleado ingresado no existe--')
	
end;


procedure exportarArchivo(var archivo: archivo_empleados);
var 
	archivo_maestro: text;
	ea: empleado; 
begin
	assign(archivo_maestro, 'todos_empleados.txt');
	rewrite(archivo_maestro);
	while(not eof(archivo)) do begin
		read(archivo, ea);
		writeln(archivo_maestro, '-------------------------------------------');
		writeln(archivo_maestro, 'Numero de empleado: ',ea.num, ' Apellido: ', ea.apellido);
		writeln(archivo_maestro, 'Nombre: ' ,ea.nombre);
		writeln(archivo_maestro, 'Edad: ' ,ea.edad,' DNI: ', ea.dni);
	end;
	writeln('Archivo exportado con exito a "todos_empleados.txt"');
	close(archivo_maestro);
end;


procedure exportarSinDNI(var archivo: archivo_empleados);
var
	texto: text;
	e: empleado;
begin
	assign(texto, 'EmpleadosSinDNI.txt');
	rewrite(texto);
	while(not eof(archivo)) do begin
		read(archivo, e);
		if(e.dni = 0) then
			write(texto, ' Numero de empleado: ', e.num, ' Apellido: ', e.apellido, ' Nombre: ', e.nombre, ' Edad: ', e.edad, ' Usted no a ingresado su DNI, por favor acerquese a la oficina a resolver la situacion');
	end;
	close(texto);
	writeln('Archivo exportado con exito a "EmpleadosSinDNI.txt"');
end;


procedure eliminarEmpleado(var archivo: archivo_empleados);
var num : integer; emp: empleado;
begin
	writeln('Ingrese el numero de empleado que desea eliminar ');
	readln(num);
	read(archivo, emp);
	while(not eof(archivo)) and (num <> emp.num) do
		read(archivo, emp);
	if(num = emp.num) then begin
		while(not eof(archivo)) do begin
			read(archivo, emp);
			seek(archivo, filepos(archivo) - 2);
			write(archivo, emp);
			seek(archivo, filepos(archivo)+1);
		end;
		seek(archivo, filesize(archivo)-1);
		truncate(archivo);
	end;
end;

procedure B(var archivo: archivo_empleados);
var 
	nombre_archivo: string;
	opcion: integer;
begin
	writeln('--- Nombre del archivo: ');
	readln(nombre_archivo);
	assign(archivo, nombre_archivo);
	reset(archivo);
	Writeln('---Oprima 1 para buscar empleados por nombre/ apellido determinado ');	
	Writeln('--- Oprima 2 para  listar todos los empleados ');
	Writeln( '---Oprima 3 para  listar a todos los empleados mayores de 70 anios ');
	Writeln('---Oprima 4 para agregar un nuevo empleado a la lista. Ingrese apellido "fin" para terminar la carga');
	Writeln('---Oprima 5 para modificar la edad de un empleado---');
	Writeln('---Oprima 6 para exportar el archivo---');
	Writeln('---Oprima 7 para exportar a los empleados que no hayan ingresado su DNI---');
	Writeln('---Oprima 8 para eliminar a un empleado dado---');
	Writeln(' ---Oprima 0 para salir ');
	readln(opcion);
	case opcion of 
		1: buscarEmpleado(archivo);
		2: imprimirArchivo(archivo);
		3: imprimirMayores(archivo);
		4: agregarEmpleado(archivo);
		5: modificarEdad(archivo);
		6: exportarArchivo(archivo);
		7: exportarSinDNI(archivo);
		8: eliminarEmpleado(archivo);
	end;
	close(archivo);
end;


procedure menu(var archivo: archivo_empleados);
var opcion: integer;
begin
	writeln('			---	Bienvenido al menu!	---');
	writeln('---Oprima 1 para crear un nuevo archivo de empleados.');
	writeln('---Oprima 2 para abrir un archivo existente. ');
	writeln('---Oprima 0 para salir del menu');
	readln(opcion);
	case opcion of
		1: A(archivo);
		2: B(archivo);
		0: begin writeln();
			writeln('----      	SALIENDO DEL MENU		----');
			end;
	end;
end;


var
	archivo: archivo_empleados;

BEGIN
	menu(archivo);
END.

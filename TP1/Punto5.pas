{
Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
	a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
		ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
		correspondientes a los celulares deben contener: código de celular, nombre,
		descripción, marca, precio, stock mínimo y stock disponible.
	
	b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
		stock mínimo.
	
	c. Listar en pantalla los celulares del archivo cuya descripción contenga una
		cadena de caracteres proporcionada por el usuario.
	
	d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
		“celulares.txt” con todos los celulares del mismo. El archivo de texto generado
		podría ser utilizado en un futuro como archivo de carga (ver inciso a), por lo que
		debería respetar el formato dado para este tipo de archivos en la NOTA 2.
}


program ejercicio5;

type
	celular = record
		stock_min: integer;
		stock: integer;
		precio: real;
		cod: integer;
		nombre: string;
		descripcion: string;
		marca: string;
	end;

	archivo_celulares = file of celular;


procedure leerCelular(var c: celular);
begin
	writeln('Ingrese el codigo de celular: ');
	readln(c.cod);
	writeln('Ingrese el nombre del celular: ');
	readln(c.nombre);
	writeln('Ingrese la marca del celular: ');
	readln(c.marca);
	writeln('Ingrese una descripcion del celular: ');
	readln(c.descripcion);
	writeln('Ingrese el stock minimo del celular: ');
	readln(c.stock_min);
	writeln('Ingrese el stock actual del celular: ');
	readln(c.stock);
	writeln('Ingrese el precio del celular: ');
	readln(c.precio);
end;


procedure imprimir(c:celular);
begin
	with c do begin
		writeln('Celular numero: ', cod);
		writeln('Marca y nombre del celular: ', marca, ' ', nombre, ', ', descripcion);
		writeln('Stock minimo: ', stock_min, ', Stock actual: ', stock, ' Precio: ', precio:2:2);
	end;
end;


procedure crearArchivo(var archivo: archivo_celulares);
var c: celular;
	texto: text;
	nombre: string;
begin
	writeln('Ingrese el nombre del nuevo archivo de celulares.');
	readln(nombre);
	assign(archivo, nombre);
	rewrite(archivo);
	assign(texto, 'celulares.txt');
	reset(texto);
	while(not eof(texto)) do begin
		with c do begin
			readln(texto, cod,precio, marca);
			readln(texto, stock, stock_min, descripcion);
			readln(texto, nombre);
		end;
		write(archivo, c);
	end;
	close(texto);
	close(archivo);
end;


procedure exportarSinStock(var a: archivo_celulares);
var c: celular; texto: text;
begin
	assign(texto, 'SinStock.txt');
	rewrite(texto);
	read(a, c);
	while(not eof(a)) do begin
		while(c.stock <> 0) do 
			read(a, c);
		if(c.stock = 0) then begin
			writeln(texto, c.cod, ' ' , c.precio:2:2, ' ' , c.marca);
			writeln(texto, c.stock, ' ' , c.stock_min, ' ' , c.descripcion);
			writeln(texto, c.nombre, ' No hay stock');
		end;
	end;
	close(texto);
end;


procedure listarNoDisponibles(var archivo: archivo_celulares);
var c: celular;
begin
	read(archivo, c);
	while(not eof(archivo)) do begin
		if(c.stock < c.stock_min) then
			imprimir(c);
		read(archivo, c);
	end;
	if(c.stock < c.stock_min) then
			imprimir(c);
end;


procedure listarDescripcion(var archivo: archivo_celulares);
var c: celular;
begin
	read(archivo, c);
	while(not eof(archivo)) do begin
		if(c.descripcion <> '') then
			imprimir(c);
		read(archivo, c);
	end;
	if(c.descripcion <> '') then
			imprimir(c);
end;


procedure exportarArchivo(var archivo: archivo_celulares);
var c: celular; texto: text;
begin
	assign(texto, 'celulares.txt');
	rewrite(texto);
	with c do begin
		while(not eof(archivo)) do begin
			read(archivo, c);
			writeln(texto, cod, ' ', precio:2:2, ' ', marca);
			writeln(texto, stock, ' ', stock_min, ' ' , descripcion);
			writeln(texto, nombre);
		end;
	end;
	close(texto);
end;


procedure modificarStock(var archivo: archivo_celulares);
var c: celular ; num, stock: integer;
begin
	writeln('--Ingrese el numero del celular que desea modificar: ');
	read(num);
	read(archivo, c);
	while(not eof(archivo) and (num <> c.cod)) do
		read(archivo, c);
	if(c.cod = num) then begin
		writeln('--Ingrese nuevo stock');
		read(stock);
		c.stock:= stock;
		seek(archivo, filepos(archivo)-1);
		write(archivo, c);
		writeln('--Celular actualizado con exito--');
	end
	else
		writeln('--El numero de celular ingresado no existe--')
	
end;


procedure agregarCelular(var a: archivo_celulares);
var c: celular;
begin
	seek(a, filesize(a));
	leerCelular(c);
	while(c.cod <> 0) do begin
		write(a, c);
		leerCelular(c);
	end;
end;


procedure operar(var archivo: archivo_celulares);
var 
	nombre_archivo: string;
	opcion: integer;
begin
	writeln('--- Nombre del archivo: ');
	readln(nombre_archivo);
	assign(archivo, nombre_archivo);
	reset(archivo);
	Writeln('---Oprima 1 para listar no disponibles ');	
	Writeln('---Oprima 2 para listar con descripcion ');
	Writeln('---Oprima 3 para exportar ');
	Writeln('---Oprima 4 para agregar un celular ');
	Writeln('---Oprima 5 para modificar el stock de un celular ');
	Writeln('---Oprima 6 para exportar celulares sin stock ');
	Writeln(' ---Oprima 0 para salir ');
	readln(opcion);
	case opcion of 
		1: listarNoDisponibles(archivo);
		2: listarDescripcion(archivo);
		3: exportarArchivo(archivo);
		4: agregarCelular(archivo);
		5: modificarStock(archivo);
		6: exportarSinStock(archivo);
		0: begin writeln();
			writeln('----      	SALIENDO DEL MENU			----');
			end;
	end;
	close(archivo);
end;


procedure menu(var archivo: archivo_celulares);
var opcion: integer;
begin
	writeln('			---	Bienvenido al menu!	---');
	writeln('---Oprima 1 para crear un nuevo archivo de celulares.');
	writeln('---Oprima 2 operar con un archivo existente. ');
	writeln('---Oprima 0 para salir del menu');
	readln(opcion);
	case opcion of
		1: crearArchivo(archivo);
		2: operar(archivo);
		0: begin writeln();
			writeln('----      	SALIENDO DEL MENU			----');
			end;
	end;
end;	


var archivo: archivo_celulares;

BEGIN
	menu(archivo);
END.

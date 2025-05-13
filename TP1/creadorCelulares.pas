program untitled;

type
	celular = record
		stock_min: integer;
		stock: integer;
		precio : real;
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
		writeln('Stock minimo: ', stock_min, ', Stock actual: ', stock);
	end;
end;


procedure crearArchivo(var archivo: text);
var c: celular;
begin
	with c do begin
		leerCelular(c);
		while(cod <> 0) do begin
			writeln(archivo, cod, ' ', precio, ' ', marca);
			writeln(archivo, stock, ' ', stock_min, ' ', descripcion);
			writeln(archivo, nombre);
			leerCelular(c);
		end;
	end;
	close(archivo);
end;



var
	archivo: text;
	nombre: string;
BEGIN
	writeln('ingrese nombre del archivo');
	read(nombre);
	assign(archivo, nombre);
	rewrite(archivo);
	crearArchivo(archivo);
END.

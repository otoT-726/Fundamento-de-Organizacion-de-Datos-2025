{
	Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado con
	la información correspondiente a las prendas que se encuentran a la venta. De cada
	prenda se registra: cod_prenda, descripción, colores, tipo_prenda, stock y
	precio_unitario. Ante un eventual cambio de temporada, se deben actualizar las
	prendas a la venta. Para ello reciben un archivo conteniendo: cod_prenda de las
	prendas que quedarán obsoletas. Deberá implementar un procedimiento que reciba
	ambos archivos y realice la baja lógica de las prendas, para ello deberá modificar el
	stock de la prenda correspondiente a valor negativo.
	Adicionalmente, deberá implementar otro procedimiento que se encargue de
	efectivizar las bajas lógicas que se realizaron sobre el archivo maestro con la
	información de las prendas a la venta. Para ello se deberá utilizar una estructura
	auxiliar (esto es, un archivo nuevo), en el cual se copien únicamente aquellas prendas
	que no están marcadas como borradas. Al finalizar este proceso de compactación
	del archivo, se deberá renombrar el archivo nuevo con el nombre del archivo maestro
	original.
}
program ejercicio6;

const 
	valor_alto = 9999;
	
type
	
	prenda = record
		cod: integer;
		descripcion: string;
		colores: string;
		tipo: string;
		stock: integer;
		precio: real;
	end;
	
	archivo_prendas = file of prenda;
	archivo_obsoletos = file of integer;
	
procedure leer(var archivo: archivo_prendas; var p: prenda);
begin
	if(not eof(archivo)) then
		read(archivo, p)
	else
		p.cod:= valor_alto;
end;

procedure leerPrenda(var p: prenda);
begin
  write('Ingrese el código de la prenda(',valor_alto,' para finalizar la carga): ');
  readln(p.cod);
  if(p.cod <> valor_alto) then begin
		write('Ingrese la descripción de la prenda: ');
		readln(p.descripcion);
		write('Ingrese los colores disponibles: ');
		readln(p.colores);
		write('Ingrese el tipo de prenda: ');
		readln(p.tipo);
		write('Ingrese el precio: ');
		readln(p.precio);
	end;
end;

procedure imprimirPrenda(p: prenda);
begin
  writeln('--- Información de la Prenda ---');
  writeln('Código: ', p.cod);
  writeln('Descripción: ', p.descripcion);
  writeln('Colores: ', p.colores);
  writeln('Tipo: ', p.tipo);
  writeln('Precio: $', p.precio:0:2);
end;

procedure renovarStock(var archivo: archivo_prendas; var archivo_eliminados: archivo_obsoletos);
var p: prenda; num: integer;
begin
	while(not eof(archivo_eliminados)) do begin
		read(archivo_eliminados, num);
		leer(archivo, p);
		while(p.cod <> num) and (p.cod <> valor_alto) do
			leer(archivo, p);
		if(p.cod = num) then begin
			p.stock:= -p.stock;
			seek(archivo, filepos(archivo)-1);
			write(archivo, p);
		end;
	end;
end;

procedure renovarArchivo(var archivo: archivo_prendas; nombre: string);
var p: prenda; archivo_nuevo: archivo_prendas;
begin
	assign(archivo_nuevo, 'archivo_nuevo');
	rewrite(archivo_nuevo);
	leer(archivo, p);
	while(p.cod<>valor_alto) do begin
		if(p.stock > 0) then
			write(archivo_nuevo, p);
		leer(archivo, p);
	end;
	rename(archivo_nuevo, nombre);
end;


procedure crearArchivo(var archivo: archivo_prendas; var nombre: string);
var 
	p: prenda;
begin
	write('Ingrese el nombre del archivo que desea crear:');
	read(nombre);
	assign(archivo, nombre);
	rewrite(archivo);
	leerPrenda(p);
	while(p.cod<> valor_alto) do begin
		write(archivo, p);
		leer(archivo, p);
	end;
end;


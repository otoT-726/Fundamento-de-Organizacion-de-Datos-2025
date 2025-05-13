{
	El encargado de ventas de un negocio de productos de limpieza desea administrar el stock
	de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los
	productos que comercializa. De cada producto se maneja la siguiente información: código de
	producto, nombre comercial, precio de venta, stock actual y stock mínimo. Diariamente se
	genera un archivo detalle donde se registran todas las ventas de productos realizadas. De
	cada venta se registran: código de producto y cantidad de unidades vendidas. Se pide
	realizar un programa con opciones para:
	
	a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
		● Ambos archivos están ordenados por código de producto.
		● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
			archivo detalle.
		● El archivo detalle sólo contiene registros que están en el archivo maestro.
	
	b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
		stock actual esté por debajo del stock mínimo permitido.
}

program ejercicio2;

const valor_alto= 9999;

type
	prod = record
		cod: integer;
		nombre: string;
		precio: real;
		stock: integer;
		stock_min: integer;
	end;
	
	venta = record
		cod: integer;
		cant: integer;
	end;
	
	
	maestro = file of prod;
	detalle= file of venta;
	
	
procedure leerM(var a: maestro; var p: prod);
begin
		if(not eof(a)) then
			read(a,p)
		else
			p.cod:= valor_alto;
end;


procedure leerD(var a: detalle; var p: venta);
begin
		if(not eof(a)) then
			read(a,p)
		else
			p.cod:= valor_alto;
end;

	
procedure actualizarMaestro(var a: maestro);
var regm: prod; regd, actual: venta; aDet: detalle; ventas_actuales: integer;
begin
	assign(aDet, 'archivoDetalleP2.dat');
	reset(aDet);
	leerD(aDet, regd);
	while(regd.cod <> valor_alto) do begin
		leerM(a, regm);
		ventas_actuales:=0;
		actual:= regd;
		while(actual.cod = regd.cod) do begin
			ventas_actuales:= ventas_actuales + regd.cant;
			leerD(aDet, regd);
		end;
		regm.stock := regm.stock - ventas_actuales;
		seek(a, filepos(a)-1);
		write(a, regm);
	end;
	close(aDet);
end;


procedure exportarSinStock(var a: maestro);
var regm: prod; texto: text;
begin
	assign(texto, 'stock_minimo.txt');
	rewrite(texto);
	leerM(a, regm);
	while(regm.cod <> valor_alto) do begin
		if(regm.stock < regm.stock_min) then
			with regm do
				writeln(texto, ' ', cod, ' ', precio:1:2, ' ', stock, ' ', stock_min, ' ', nombre);
		leerM(a, regm);
	end;
	close(texto);
end;


var a: maestro;

begin
	assign(a, 'archivoMaestroP2.dat');
	reset(a);
	actualizarMaestro(a);
	exportarSinStock(a);
	close(a);
end.

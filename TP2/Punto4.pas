{
	Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
	De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
	stock mínimo y precio del producto.
	Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
	debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
	maestro. La información que se recibe en los detalles es: código de producto y cantidad
	vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
	descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
	debajo del stock mínimo. Pensar alternativas sobre realizar el informe en el mismo
	procedimiento de actualización, o realizarlo en un procedimiento separado (analizar
	ventajas/desventajas en cada caso).
	Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
	puede venir 0 o N registros de un determinado producto
}

program ejercicio4;

const valor_alto= 9999;

type
	producto = record
		cod: integer;
		nombre: string;
		descripcion: string;
		stock: integer;
		stock_min: integer;
		precio: real;
	end;
	
	venta = record
		cod: integer;
		cant: integer;
	end;
	
	maestro= file of producto;
	detalle= file of venta;
	vector  = array[0..30] of detalle;
	vectorRegistros = array[1..30] of venta;


procedure leer(var a: detalle; var v: venta);
begin
	if(not eof(a)) then
		read(a,v)
	else
		v.cod:= valor_alto;
end;


procedure inicializarVector(var v: vector; var vReg: vectorRegistros);
var i: integer; nombreArchivo:string;
begin
		for i:= 1 to 30 do begin
			writeln('Ingrese el nombre del archivo detalle');
			readln(nombreArchivo);
			assign(v[i], nombreArchivo);
			reset(v[i]);
			leer(v[i],vReg[i]);
		end;
end;
	
	
procedure leerM(var a: maestro; var p: producto);
begin
	if(not eof(a)) then
		read(a,p)
	else
		p.cod:= valor_alto;
end;
	
	

	
	
procedure minimo(var v: vector;var v_min: venta; var vReg: vectorRegistros);
var i, pos: integer;
begin
	v_min.cod:= valor_alto;
	for i := 1 to 30 do 
		if(vReg[i].cod< v_min.cod) then begin
			v_min:=vReg[i];
			pos:= i;	
		end;
	leer(v[pos], vReg[pos]);
end;

procedure actualizarMaestro(var maestro : maestro; var v: vector; var vReg: vectorRegistros);
var
	pD: venta;pM: producto; stockActual:integer; texto: text;
begin
	assign(texto, 'prodSinStock.txt');
	rewrite(texto);
	minimo(v, pD, vReg);
	stockActual:= 0;
	while(pD.cod <> valor_alto) do begin
		leerM(maestro, pM);
		while(pD.cod <> pM.cod) do
			leerM(maestro, pM);
		while(pD.cod = pM.cod) do begin
			stockActual:= stockActual + pD.cant;
			minimo(v,pD, vReg);
		end;
		pM.stock := pM.stock - stockActual;
		if(pM.stock < pM.stock_min) then begin
			writeln(texto, ' ', pM.nombre, ' ');
			writeln(texto, ' ', pM.stock, ' ', pM.precio, ' ', pM.descripcion);
		end;
		seek(maestro, filepos(maestro)-1);
		write(maestro, pM);
		
	end;
end;


procedure sinStock(var a: maestro; var texto: text);	      // resolucion mediante proceso alterno
var rM: producto;//Ventaja: modularizacion (reutilizacion) Desventaja: Recorro el archivo dos veces.
begin
	leerM(a, rM);
	while(rM.cod <> valor_alto) do begin
		if(rM.stock < rM.stock_min) then begin
			writeln(texto, ' ', rM.nombre, ' ');
			writeln(texto, ' ', rM.stock, ' ', rM.precio, ' ', rM.descripcion);
		end;
		leerM(a,rM);
	end;
end;


var master: maestro; v: vector; i: integer; vReg : vectorRegistros;
begin
	assign(master, 'archivoMaestroP4');
	reset(master);
	inicializarVector(v, vReg);
	actualizarMaestro(master, v, vReg);
	close(master);
	
	for i := 1 to 30 do
		close(v[i]);
end.

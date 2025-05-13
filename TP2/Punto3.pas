{
	A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un
	archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas
	alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos
	agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de
	localidad, cantidad de alfabetizados y cantidad de encuestados. Se pide realizar los módulos
	necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.
	NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle
	pueden venir 0, 1 ó más registros por cada provincia.
}

program ejercicio3;

const valor_alto= 'ZZZZZZZZZZZZZZ';

type
	provincia = record
		nombre: string;
		alfa: integer;
		encuestados: integer;
	end;
	prov = record
		cod: integer;
		nombre: string;
		alfa: integer;
		encuestados: integer;
	end;
	
	maestro= file of provincia;
	detalle = file of prov;


procedure leerD(var d: detalle;var p: prov);
begin
	if(not eof(d)) then
		read(d, p)
	else
		p.nombre := valor_alto;
end;


procedure minimo(r1,r2: prov; var a: prov);
begin
	if(r1.nombre < r2.nombre) then
		a:= r1
	else
		a:=r2;
end;

procedure actualizarMaestro(var a: maestro;var det1, det2: detalle);
var
	regm: provincia; regd1, regd2, detA: prov; 
begin
	leerD(det1, regd1);
	leerD(det2, regd2);
	minimo(regd1,regd2, detA);
	while(detA.nombre <> valor_alto) and (not eof(a)) do begin
		read(a, regm);
		while(detA.nombre <> regm.nombre) do
			read(a, regm);
		while(regm.nombre = detA.nombre) do begin
			regm.alfa:= regm.alfa + detA.alfa;
			regm.encuestados:= regm.encuestados + detA.encuestados;
		end;
		seek(a, filepos(a)-1);
		write(a, regm);
		leerD(det1, regd1);
		leerD(det2, regd2);
		minimo(regd1,regd2, detA);
	end;
end;


var 
	a: maestro;
	d1,d2: detalle;
begin
	assign(a, 'archivoMaestroP3');
	reset(a);
	assign(d1, 'archivoDetalle1P3');
	reset(d1);
	assign(d2, 'archivoDetalle2P3');
	reset(d2);
	actualizarMaestro(a,d1,d2);
	close(a);
	close(d1);
	close(d2);
end.

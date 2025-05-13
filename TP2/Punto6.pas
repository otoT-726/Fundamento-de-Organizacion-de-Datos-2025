{
	Se desea modelar la información necesaria para un sistema de recuentos de casos de covid
	para el ministerio de salud de la provincia de buenos aires.
	Diariamente se reciben archivos provenientes de los distintos municipios, la información
	contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad de
	casos activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos
	fallecidos.
	El ministerio cuenta con un archivo maestro con la siguiente información: código localidad,
	nombre localidad, código cepa, nombre cepa, cantidad de casos activos, cantidad de casos
	nuevos, cantidad de recuperados y cantidad de fallecidos.
	Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
	recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
	localidad y código de cepa.
	Para la actualización se debe proceder de la siguiente manera:
	1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
	2. Idem anterior para los recuperados.
	3. Los casos activos se actualizan con el valor recibido en el detalle.
	4. Idem anterior para los casos nuevos hallados.
	Realice las declaraciones necesarias, el programa principal y los procedimientos que
	requiera para la actualización solicitada e informe cantidad de localidades con más de 50
	casos activos (las localidades pueden o no haber sido actualizadas).

}

program ejercicio6;

const 
	valor_alto = 'ZZZZZ';
	cant_detalles = 10;

type
	
	str5 = string[5];
	
	datos_muni = record
		cod_localidad: str5;
		cod_cepa: str5;
		cant_activos: integer;
		cant_nuevos: integer;
		cant_recuperados: integer;
		cant_muertos: integer;
	end;
	
	datos_covid = record
		cod_localidad: str5;
		cod_cepa: str5;
		nombre_localidad: string;
		cant_activos: integer;
		cant_nuevos: integer;
		cant_recuperados: integer;
		cant_muertos: integer;
	end;
	
	maestro = file of datos_covid;
	detalle = file of datos_muni;
	
	v_detalles = array[1.. cant_detalles] of detalle;
	v_registros = array[1.. cant_detalles] of datos_muni;
	
	
procedure leer(var a: detalle; var datos: datos_muni);
begin
	if(not eof(a)) then
		read(a,datos)
	else
		datos.cod_localidad:= valor_alto;
end;


procedure leerM(var a: maestro; var dato: datos_covid);
begin
	if(not eof(a)) then
		read(a,dato)
	else
		dato.cod_localidad:= valor_alto;
end;



procedure inicializarVector(var vd: v_detalles; var vr: v_registros);
var i: integer;nombre: string;
begin
	for i:= 1 to cant_detalles do begin
		readln(nombre);
		assign(vd[i], nombre);
		reset(vd[i]);
		leer(vd[i], vr[i]);
	end;
	
end;
		

procedure minimo(var vd: v_detalles; vr: v_registros; var dato_minimo: datos_muni);
var pos, i: integer;
begin
	dato_minimo.cod_localidad:= valor_alto;
	for i:= 1 to cant_detalles do begin
		if(vr[i].cod_localidad < dato_minimo.cod_localidad) then begin
			dato_minimo := vr[i];
			pos:= i;
		end;
	end;
	leer(vd[pos], vr[pos]);
end;


procedure actualizarMaestro(var a_maestro: maestro; var vd: v_detalles; var vr: v_registros;var cant: integer);
var dato_minimo: datos_muni; dato_maestro: datos_covid; localidad: string;
begin
	inicializarVector(vd,vr);
	minimo(vd,vr,dato_minimo);
	leerM(a_maestro,dato_maestro);
	while(dato_minimo.cod_localidad <> valor_alto) do begin
		localidad:= dato_minimo.cod_localidad;
		while(dato_minimo.cod_localidad <> dato_maestro.cod_localidad) do 
			leerM(a_maestro, dato_maestro);
		while(localidad = dato_minimo.cod_localidad) do begin
			while(dato_minimo.cod_cepa <> dato_maestro.cod_cepa) do
				leerM(a_maestro, dato_maestro);
			while(dato_maestro.cod_cepa = dato_minimo.cod_cepa) do begin
				dato_maestro.cant_recuperados:= dato_maestro.cant_recuperados + dato_minimo.cant_recuperados;
				dato_maestro.cant_muertos:= dato_maestro.cant_muertos + dato_minimo.cant_muertos;
				dato_maestro.cant_nuevos:= dato_maestro.cant_nuevos + dato_minimo.cant_nuevos;
				dato_maestro.cant_activos:= dato_maestro.cant_activos + dato_minimo.cant_activos;
				minimo(vd,vr,dato_minimo);
			end;
			seek(a_maestro, filepos(a_maestro) - 1);
			write(a_maestro, dato_maestro);
		end;
		if(dato_maestro.cant_activos > 50) then
				cant:= cant+1;
	end;
end;

var
	vd: v_detalles;
	vr: v_registros;
	cant: integer;
	archivo: maestro;

begin
	assign(archivo, 'archivoMaestroP6.txt');
	reset(archivo);
	cant:= 0;
	actualizarMaestro(archivo, vd, vr,  cant);
	writeln('hay ', cant ,' localidades con mas de 50 casos activos');

end.

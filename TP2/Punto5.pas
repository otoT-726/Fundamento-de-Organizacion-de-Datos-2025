{
	Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma fue
	construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
	máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
	archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
	cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
	cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
	detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
	tiempo_total_de_sesiones_abiertas.
	Notas:
		● Cada archivo detalle está ordenado por cod_usuario y fecha.
		● Un usuario puede iniciar más de una sesión el mismo día en la misma máquina, o
			inclusive, en diferentes máquinas.
		● El archivo maestro debe crearse en la siguiente ubicación física: /var/log.
}

program ejercicio5;

const 
	valor_alto= 9999;
	cant_detalles= 5;
	

type
	
	fech = record
		dia: integer;
		mes: integer;
		anio: integer;
	end;
	
	servidor = record  // maestro
		cod_usuario : integer;
		fecha: fech;
		tiempo_total: real;
	end;
	
	sesion = record
		cod_usuario: integer;
		fecha: fech;
		tiempo_sesion: integer;
	end;
	
	maestro = file of servidor;
	detalle = file of sesion;
	vectorDetalles = array[1..cant_detalles] of detalle;
	vectorRegistros = array[1.. cant_detalles] of sesion;


procedure leer(var a:detalle; var reg: sesion);
begin
	if(not eof(a)) then
		read(a,reg)
	else
		reg.cod_usuario:= valor_alto;
end;


procedure inicializarVector(var vd: vectorDetalles; var vr: vectorRegistros);
var i: integer; nombre: string;
begin
	for i:= 1 to cant_detalles do begin
		readln(nombre);
		assign(vd[i], nombre);
		reset(vd[i]);
		read(vd[i], vr[i]);
	end;
end;


procedure anterior(var menor: sesion; f1, f2: sesion);
begin
    if (f1.fecha.anio < f2.fecha.anio) then
        menor := f1
    else if (f1.fecha.anio > f2.fecha.anio) then
        menor := f2
    else if (f1.fecha.mes < f2.fecha.mes) then
        menor := f1
    else if (f1.fecha.mes > f2.fecha.mes) then
        menor := f2
    else if (f1.fecha.dia < f2.fecha.dia) then
        menor := f1
    else
        menor := f2;
end;


procedure minimo(var vd: vectorDetalles; var vr: vectorRegistros; var reg: sesion);
var i, pos: integer;
begin
	reg.cod_usuario:= valor_alto;
	for i:= 1 to cant_detalles do begin
		if(vr[i].cod_usuario < reg.cod_usuario) then begin
			reg:= vr[i];
			pos:= i;
		end;
	leer(vd[pos],vr[pos]);
	end;
end;


procedure crearMaestro(var vd: vectorDetalles; var vr: vectorRegistros; var amaestro: maestro);
var reg, actual: sesion; regm: servidor;
begin
	inicializarVector(vd,vr);
	minimo(vd,vr, reg);
	while(reg.cod_usuario <> valor_alto) do begin
		actual:=reg;
		regm.cod_usuario:= reg.cod_usuario;
		while(actual.cod_usuario = reg.cod_usuario) do begin
			regm.tiempo_total:= regm.tiempo_total + reg.tiempo_sesion;
			minimo(vd,vr,reg);
			regm.fecha:= reg.fecha;
		end;
		write(amaestro, regm);
	end;
end;


var vd: vectorDetalles; vr: vectorRegistros; archivo: maestro; i: integer;

begin
	assign(archivo, '/var/log/maestroP5.txt');
	rewrite(archivo);
	crearMaestro(vd,vr,archivo);
	close(archivo);
	for i:= 1 to cant_detalles do 
		close(vd[i]);
end.

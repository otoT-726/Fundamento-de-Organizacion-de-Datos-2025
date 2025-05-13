{
	Definir un programa que genere un archivo con registros de longitud fija conteniendo
	información de asistentes a un congreso a partir de la información obtenida por
	teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y
	nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del
	archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
	asistente inferior a 1000.
	Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
	String a su elección. Ejemplo: ‘@Saldaño’.
}
program ejercicio2;

const
	valor_alto = 9999;
	
type
	
	asistentes = record
		nro: integer;
		apellido: string[20];
		nombre: string[20];
		email: string[30];
		telefono: longint;
		dni: longint;
	end;
	
	archivo_asistentes= file of asistentes;
	
procedure leerAsistente(var a: asistentes);
begin
	with a do begin
		write('Ingrese número de asistente (0 para finalizar): ');
		readln(nro);
		if nro <> 0 then begin
			write('Ingrese apellido: ');
			readln(apellido);
			write('Ingrese nombre: ');
			readln(nombre);
			write('Ingrese email: ');
			readln(email);
			write('Ingrese teléfono: ');
			readln(telefono);
			write('Ingrese D.N.I.: ');
			readln(dni);
		end;
	end;
end;

procedure crearArchivo(var archivo: archivo_asistentes);
var a: asistentes; nombre: string;
begin
	writeln('Ingrese el nombre del archivo nuevo: ');
	readln(nombre);
	assign(archivo, nombre);
	rewrite(archivo);
	leerAsistente(a);
	while(a.nro <> 0) do begin
		write(archivo, a);
		leerAsistente(a);
	end;
end;

procedure leer(var archivo: archivo_asistentes; var a: asistentes);
begin
	if(not eof(archivo)) then
		read(archivo, a)
	else
		a.nro:= valor_alto;
end;

procedure eliminarAsistentesMenores1000(var archivo: archivo_asistentes);
var a: asistentes;
begin
	reset(archivo);
	leer(archivo, a);
	while(a.nro <> valor_alto) do begin
		if(a.nro < 1000) then begin
			a.apellido:= '*' + a.apellido;
			seek(archivo, filepos(archivo)-1);
			write(archivo, a);
		end;
		leer(archivo, a)
	end;
end;

procedure imprimirAsistente(a: asistentes);
begin
	with a do begin
		writeln('Número de asistente: ', nro);
		writeln('Apellido: ', apellido);
		writeln('Nombre: ', nombre);
		writeln('Email: ', email);
		writeln('Teléfono: ', telefono);
		writeln('D.N.I.: ', dni);
		writeln('--------------------');
	end;
end;

procedure imprimirArchivo(var archivo : archivo_asistentes);
var a: asistentes;
begin
	reset(archivo);
	leer(archivo, a);
	while(a.nro <> valor_alto) do begin
		imprimirAsistente(a);
		leer(archivo, a);
	end;
end;

var
	archivo: archivo_asistentes; opcion: integer; nombre_archivo: string;
begin
	writeln('Ingrese 1 para crear un nuevo archivo.');
	writeln('Ingrese 2 para imprimir un archivo ya existente.');
	readln(opcion);
	case opcion of
		1:	crearArchivo(archivo);
		2: begin
				writeln('Ingrese el nombre del archivo que desea abrir: ');
				readln(nombre_archivo);
				assign(archivo, nombre_archivo);
		end;
	end;
	writeln('-----------------------------');
	imprimirArchivo(archivo);
	eliminarAsistentesMenores1000(archivo);
	imprimirArchivo(archivo);
	close(archivo);
end.

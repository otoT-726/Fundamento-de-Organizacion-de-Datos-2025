program archivos0;

type
	persona = record
		nombre: string[25];
		apellido: string[25];
		dni: integer;
		edad: integer;
	end;
	
	archivo_personas= file of persona;
	
procedure leerPersona(var p: persona);
begin
	writeln('Ingrese el nombre de la persona: ');
	readln(p.nombre);
	writeln('Ingrese el apellido de la persona: ');
	readln(p.apellido);
	writeln('Ingrese el DNI de la persona: ');
	readln(p.dni);
	writeln('Ingrese la edad de la persona: ');
	readln(p.edad);
end;
	
procedure imprimirPersona(p: persona);
begin
	writeln('La persona se llama: ', p.nombre, ' ', p.apellido );
	writeln('su DNI es: ', p.dni);
	writeln('Y tiene ', p.edad, ' anios');
end;
	
	
	
var
	personas: archivo_personas;
	per: persona;
	long, i: integer;
	
	
BEGIN
	assign(personas, 'Archivo_Personas.dat');
	reset(personas);
	long:= fileSize(personas);

	for i:= 1 to long do begin
		read(personas, per);
		imprimirPersona(per)
	end;
	close(personas);
END.





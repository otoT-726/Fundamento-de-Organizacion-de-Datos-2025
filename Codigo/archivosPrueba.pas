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
	
var
	personas: archivo_personas;
	per: persona;
	i: integer;
	
	
BEGIN
	assign(personas, 'Archivo_Personas.dat');
	rewrite(personas);

	for i:= 1 to 3 do begin
		leerPersona(per);
		write(personas, per);
	end;
	close(personas);
END.





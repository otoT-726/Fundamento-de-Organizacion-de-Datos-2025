program archivos_0;

type
	persona = record
		dni: integer;
		apellido: string[25];
		nombre: string[25];
		direccion: string[25];
		genero: char;
	end;
	archivo_enteros = file of integer;
	archivo_string = file of string;
	archivo_personas = file of personas;

var
	enteros: archivo_enteros;

BEGIN

	assign(enteros, 'enteros.dat');
	rewrite(enteros);
	
END.

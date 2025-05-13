{
		Se dispone de un archivo maestro con información de los alumnos de la Facultad de
		Informática. Cada registro del archivo maestro contiene: código de alumno, apellido, nombre,
		cantidad de cursadas aprobadas y cantidad de materias con final aprobado. El archivo
		maestro está ordenado por código de alumno.
		Además, se tienen dos archivos detalle con información sobre el desempeño académico de
		los alumnos: un archivo de cursadas y un archivo de exámenes finales. El archivo de
		cursadas contiene información sobre las materias cursadas por los alumnos. Cada registro
		incluye: código de alumno, código de materia, año de cursada y resultado (solo interesa si la
		cursada fue aprobada o desaprobada). Por su parte, el archivo de exámenes finales
		contiene información sobre los exámenes finales rendidos. Cada registro incluye: código de
		alumno, código de materia, fecha del examen y nota obtenida. Ambos archivos detalle
		están ordenados por código de alumno y código de materia, y pueden contener 0, 1 o
		más registros por alumno en el archivo maestro. Un alumno podría cursar una materia
		muchas veces, así como también podría rendir el final de una materia en múltiples
		ocasiones.
		Se debe desarrollar un programa que actualice el archivo maestro, ajustando la cantidad
		de cursadas aprobadas y la cantidad de materias con final aprobado, utilizando la
		información de los archivos detalle. Las reglas de actualización son las siguientes:
		● Si un alumno aprueba una cursada, se incrementa en uno la cantidad de cursadas
			aprobadas.
		● Si un alumno aprueba un examen final (nota >= 4), se incrementa en uno la cantidad
			de materias con final aprobado.
		
		Notas:
			● Los archivos deben procesarse en un único recorrido.
			● No es necesario comprobar que no haya inconsistencias en la información de los
				archivos detalles. Esto es, no puede suceder que un alumno apruebe más de una
				vez la cursada de una misma materia (a lo sumo la aprueba una vez), algo similar
				ocurre con los exámenes finales.
}

program ejercicio7;

const
	valor_alto = 'ZZZZZ';
type
	
	alumnos = record
		cod : string[5];
		apellido : string[20];
		nombre : string[20];
		cursadas_aprobadas: integer;
		finales_aprobados: integer;
	end;
	
	cursada = record
		cod: string[5];
		cod_materia: string[5];
		anio: integer;
		resultado: boolean;
	end;
	
	finale = record
		cod: string[5];
		cod_materia: string[5];
		fecha_examen : fecha;
		nota: real;
	end;
	
	fecha = record
		dia: integer;
		mes: string;
		anio: integer;
	end;
	
	aMaestro = file of alumnos;  		//Ordenados por codigo de alumno
	aCursadas = file of cursada; 		//Ordenados por codigo de alumno y de materia y puede haber 0, 1 o mas registros por alumno
	aFinales = file of finale;				//Ordenados por codigo de alumno y de materia y puede haber 0, 1 o mas registros por alumno


procedure leerCursada(var archivo: aCursadas; var reg: cursada);
begin
	if(not eof(archivo))
		read(archivo, reg);
	else
		reg.cod:= valor_alto;
end;

procedure leerFinal(var archivo: aFinales; var reg: finale);
begin
	if(not eof(archivo))
		read(archivo, reg);
	else
		reg.cod:= valor_alto;
end;

procedure leerAlumno(var archivo: aMaestro; var reg: alumnos);
begin
	if(not eof(archivo))
		read(archivo, reg);
	else
		reg.cod:= valor_alto;
end;

procedure actualizarMaestro(var maestro: aMaestro; var cursadas: aCursadas;var finales: aFinales);
var
	fin: finale;
	cursa: cursada;
	alumno: alumnos;
begin
	reset(maestro);
	reset(cursadas);
	reset(finales);
	leerCursada(cursadas, cursa);
	leerFinal(finales, fin);
	leerAlumno(maestro, alumno);
	while(not eof(cursadas)) do begin
		







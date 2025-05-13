{
	Como actualizar un archivo maestro con un archivo detalle.
	- Se denomina maestro al archivo que resume un determinado conjunto de datos.
	-Se denomina detalle al que agrupa informacion que se utilizara para modificar el contenido del archivo maestro.
	-En general:
		.Un maestro.
		.N detalles.
	
	*Ejemplo usando un registro de empleados.
		-Precondiciones: 
			-Ambos archivos estan ordenados por el mismo criterio.
			-En el archivo detalle solo aparecen empleados que existen en el archivo maestro.
			-Cada empleado del archivo maestro a lo sumo puede aparecer una vez en el archivo detalle.
}

program actualizarMaestro;

type
	emp = record
		nombre: string[30];
		direccion: string[30];
		cht: integer;		//cantidad de horas trabajadas
	end;
	
	e_diario = record
		nombre: string[30];
		cht: integer;
	end;
	
	detalle = file of e_diario;
	maestro = file of emp;
	
var regm: emp;	regd: e_diario; mae1: maestro;	det1: detalle;

begin
	assign(mae1, 'maestro');
	assign(det1, 'detalle');
	reset(mae1); reset(det1);
	while(not eof(det1)) do begin
		read(mae1, regm);
		read(det1, regd);
		while(regm.nombre <> regd.nombre) do 
			read(mae1, regm);
		regm.cht := regm.cht + regd.cht;
		seek(mae1, filepos(mae1)-1);
		write(mae1, regm);
	end;
end.

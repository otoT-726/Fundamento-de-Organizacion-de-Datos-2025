program archivosTeoria1;

type
	empleado = record
		nombre: string;
		edad: integer;
	end;
	
	empleados = file of empleado;



procedure agregar(var emp: empleados);
var e: empleado;
begin
	reset(emp);
	seek(emp, filesize(emp));
	leer(e);
	while e.nombre <> ' ' do begin
		write(emp, e);
		leer(e);
	end;
	close(emp);
end;




BEGIN
	
	
END.



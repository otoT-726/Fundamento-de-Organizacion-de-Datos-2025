{
BORRADOR
}
program borrador;

type
	Empleado = record
		num: integer;
		apellido: string;
		nombre: string;
		edad: integer;
		dni: integer;
	end;
	archivo_empleados = file of empleado;


procedure buscarEmpleado(var archivo: archivo_empleados);
var dato: string; e: empleado;
begin
	writeln('Ingrese el nombre o apellido del empleado al que busca');
	readln(dato);
	reset(archivo);
	while(not eof(archivo)) do begin
		read(archivo, e);
		if(e.nombre = dato) or (e.apellido = dato) then
			writeln(e.nombre, ' ', e.apellido, ' ',e.edad, ' Años', ', numero de empleado: ', e.num, ' DNI: ',e.dni);
	end;
	close(archivo);
end;


var
	a: archivo_empleados;

BEGIN
	assign(a, 'JuegoEmpleados.dat');
	reset(a);
	buscarEmpleado(a);
END.


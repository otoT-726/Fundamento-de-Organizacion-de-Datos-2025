{
	Dada la siguiente estructura:
	
	type
	reg_flor = record
		nombre: String[45];
		codigo: integer;
	end;
	tArchFlores = file of reg_flor;
	
	Las bajas se realizan apilando registros borrados y las altas reutilizando registros
	borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el
	número 0 en el campo código implica que no hay registros borrados y -N indica que el
	próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido.
	a. Implemente el siguiente módulo:
		Abre el archivo y agrega una flor, recibida como parámetro
		manteniendo la política descrita anteriormente
		procedure agregarFlor (var a: tArchFlores ; nombre: string;
		codigo:integer);
	b. Liste el contenido del archivo omitiendo las flores eliminadas. Modifique lo que
		considere necesario para obtener el listado.
}
program ejercicio4;

const valor_alto = 'ZZZZ';

type

	reg_flor = record
		nombre: String[45];
		codigo: integer;
	end;

	archivoFlores= file of reg_flor;

procedure agregarFlor(var archivo: archivoFlores; nombre: string; codigo: integer);
var 	
	florBorrada, cabecera, florNueva: reg_flor;
	codigoEliminado: integer;
	
begin
	leer(archivo, cabecera);
	florNueva.nombre:= nombre;
	florNueva.codigo:= codigo;
	if(cabecera.codigo = 0) then begin
		seek(archivo, filesize(archivo));
		write(archivo, florNueva);
	end
	else begin
		codigoEliminado:= -cabecera.codigo;
		
		seek(archivo, codigoEliminado);
		read(archivo, florBorrada);
		
		seek(archivo, codigoEliminado);
		write(archivo, florNueva);
		
		seek(archivo, 0);
		cabecera.codigo:= florBorrada.codigo;
		write(archivo, cabecera);
	end;
end;

procedure imprimirFlor(flor: reg_flor);
begin
	if flor.codigo > 0 then begin
		writeln('Código: ', flor.codigo);
		writeln('Nombre: ', flor.nombre);
		writeln('--------------------');
	end;
end;


procedure imprimirFlores(var archivo: archivo_flores);
var f: reg_flor;
begin
	leer(archivo, f);
	while(f.codigo <> valor_alto) do begin
		imprimirFlor(f);
		leer(archivo, f);
	end;
end;

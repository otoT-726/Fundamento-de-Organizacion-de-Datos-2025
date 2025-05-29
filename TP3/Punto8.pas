{
	Se cuenta con un archivo con información de las diferentes distribuciones de linux 
	existentes. De cada distribución se conoce: nombre, año de lanzamiento, número de 
	versión del kernel, cantidad de desarrolladores y descripción. El nombre de las 
	distribuciones no puede repetirse. Este archivo debe ser mantenido realizando bajas 
	lógicas y utilizando la técnica de reutilización de espacio libre llamada lista invertida. 
	Escriba la definición de las estructuras de datos necesarias y los siguientes 
	procedimientos: 
	a. BuscarDistribucion: módulo que recibe por parámetro el archivo, un 
		nombre de distribución y devuelve la posición dentro del archivo donde se 
		encuentra el registro correspondiente a la distribución dada (si existe) o 
		devuelve -1 en caso de que no exista.. 
	b. AltaDistribucion: módulo que recibe como parámetro el archivo y el registro 
		que contiene los datos de una nueva distribución, y se encarga de agregar 
		la distribución  al archivo reutilizando espacio disponible en caso de que 
		exista. (El control de unicidad lo debe realizar utilizando el módulo anterior). 
		En caso de que la distribución que se quiere agregar ya exista se debe 
		informar “ya existe la distribución”. 
	c. BajaDistribucion: módulo que recibe como parámetro el archivo y el 
		nombre de una distribución, y se encarga de dar de baja lógicamente la 
		distribución dada. Para marcar una distribución como borrada se debe 
		utilizar el campo cantidad de desarrolladores para mantener actualizada 
		la lista invertida. Para verificar que la distribución a borrar exista debe utilizar 
		el módulo BuscarDistribucion. En caso de no existir se debe informar 
		“Distribución no existente”
}
program ejercicio8;

const valor_alto = 'ZZZZ';

type
	
	distribucion = record
		nombre: string[20];
		anio: integer;
		num: integer;
		cant: integer;
		descripcion: string;
	end;
	
	archivo_distribuciones = file of distribucion;
	
	
procedure leer(var archivo: archivo_distribuciones; var d : distribucion);
begin
	if(not eof(archivo)) then
		read(archivo, d)
	else
		d.nombre:= valor_alto;
end;

procedure leerDistribuion(var d: distribucion);
begin
	write('Ingrese el nombre de la distribucion Linux(',valor_alto,' para finalizar):');
	read(d.nombre);
	if(d.nombre <> valor_alto) then begin
		write('Ingrese el año de lanzamiento de la distribucion Linux:');
		read(d.anio);
		write('Ingrese el numero de version del kernel:');
		read(d.num);
		write('Ingrese la cantidad de desarrolladores de la distribucion Linux:');
		read(d.cant);
		write('Ingrese una descripcion de la distribucion Linux:');
		read(d.descripcion);
	end;
end;

procedure crearArchivo(var archivo: archivo_distribuciones);
var d: distribucion; nombre: string;
begin
	write('Ingrese el nombre del archivo nuevo');
	read(nombre);
	assign(archivo, nombre);
	rewrite(archivo);
	d.nombre:= '';
	d.anio:= 0;
	d.num:= 0;
	d.cant:= 0;
	d.descripcion:= '';
	write(archivo, d);
	leerDistribuion(d);
	while(d.nombre <> valor_alto) do begin
		write(archivo, d);
		leerDistribuion(d);
	end;
	close(archivo);
end;

procedure buscarDistribucion(var archivo: archivo_distribuidores; nombre: string; var pos: integer);
var d: distribucion;
begin
	pos:= -1;
	leer(archivo, d);
	while(d.cod<>valor_alto) and (d.nombre <> nombre) do
		leer(archivo, d);
	if(d.nombre = nombre) then 
		pos:= filepos(archivo)-1;
end;

procedure altaDistribucion(var archivo: archivo_distribuciones; distri:distribucion);
var d, cabecera: distribucion;
begin	
	reset(archivo);
	read(archivo, cabecera);
	if(cabecera.num=0) then begin
		seek(archivo, filesize(archivo));
		write(archivo, distri);
	end
	else begin
		seek(archivo, cabecera.num);
		read(archivo, aux);
		seek(archivo, cabecera.num);
		write(archivo, distri);
		seek(archivo, 0);
		cabecera.num:= aux.num;
		write(archivo, cabecera);
	end;
end;

procedure bajaDistribucion(var archivo: archivo_distribuciones; nombre: string);
var cabecera, d, aux: distribucion;
begin
	leer(archivo, cabecera);
	leer(archivo, d);
	while(d.nombre<> valor_alto) and (d.nombre <> nombre) do
		leer(archivo, d);
	if(d.nombre = nombre) then begin
		pos:= -(filepos(archivo)-1);
		seek(archivo, -pos);
		d.num:= cabecera.num;
		write(archivo, d);
		seek(archivo, 0);
		cabecera.num:= pos;
		write(archivo, cabecera);
	end
	else
		writeln('La distribucion que esta intentando eliminar no existe');
end;








begin


end.

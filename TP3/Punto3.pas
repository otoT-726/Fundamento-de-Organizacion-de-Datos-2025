{
	Realizar un programa que genere un archivo de novelas filmadas durante el presente
	año. De cada novela se registra: código, género, nombre, duración, director y precio.
	El programa debe presentar un menú con las siguientes opciones:
	
	a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se
		utiliza la técnica de lista invertida para recuperar espacio libre en el
		archivo. Para ello, durante la creación del archivo, en el primer registro del
		mismo se debe almacenar la cabecera de la lista. Es decir un registro
		ficticio, inicializando con el valor cero (0) el campo correspondiente al
		código de novela, el cual indica que no hay espacio libre dentro del
		archivo.
	b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el
		inciso a), se utiliza lista invertida para recuperación de espacio. En
		particular, para el campo de “enlace” de la lista (utilice el código de
		novela como enlace), se debe especificar los números de registro
		referenciados con signo negativo, . Una vez abierto el archivo, brindar
		operaciones para:
		i. Dar de alta una novela leyendo la información desde teclado. Para
			esta operación, en caso de ser posible, deberá recuperarse el
			espacio libre. Es decir, si en el campo correspondiente al código de
			novela del registro cabecera hay un valor negativo, por ejemplo -5,
			se debe leer el registro en la posición 5, copiarlo en la posición 0
			(actualizar la lista de espacio libre) y grabar el nuevo registro en la
			posición 5. Con el valor 0 (cero) en el registro cabecera se indica
			que no hay espacio libre.
		ii. Modificar los datos de una novela leyendo la información desde
			teclado. El código de novela no puede ser modificado.
		iii. Eliminar una novela cuyo código es ingresado por teclado. Por
			ejemplo, si se da de baja un registro en la posición 8, en el campo
			código de novela del registro cabecera deberá figurar -8, y en el
			registro en la posición 8 debe copiarse el antiguo registro cabecera.
	c. Listar en un archivo de texto todas las novelas, incluyendo las borradas, que
		representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”.
	
	NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser
			   proporcionado por el usuario.
}
program ejercicio3;

uses crt;

const
	valor_alto = 9999;
	
type

	novela = record
		cod : integer;
		genero: string[20];
		nombre: string[30];
		duracion: real;
		director: string[30];
		precio: real;
	end;
	
	archivo_novelas = file of novela;
	

procedure leer(var archivo: archivo_novelas; var n: novela);
begin
	if(not eof(archivo)) then
		read(archivo, n)
	else
		n.cod:= valor_alto;
end;	


procedure leerNovela(var n: novela);
begin
	with n do begin
		write('Ingrese código de novela (0 para finalizar): ');
		readln(cod);
		if cod <> 0 then begin
			write('Ingrese género: ');
			readln(genero);
			write('Ingrese nombre: ');
			readln(nombre);
			write('Ingrese duración (en minutos): ');
			readln(duracion);
			write('Ingrese director: ');
			readln(director);
			write('Ingrese precio: ');
			readln(precio);
		end;
	end;
end;

procedure imprimirNovela(n: novela);
begin
	if n.cod > 0 then 
		with n do begin
			lowvideo;
			writeln('Código: ', cod);
			writeln('Género: ', genero);
			writeln('Nombre: ', nombre);
			writeln('Duración: ', duracion:0:2, ' minutos');
			writeln('Director: ', director);
			writeln('Precio: $', precio:0:2);
			writeln('--------------------');
		end;
end;

procedure imprimirArchivoNovelas(var archivo : archivo_novelas);
var
	n: novela;
begin
	clrscr;
	reset(archivo);
	leer(archivo, n);
	while(n.cod <> valor_alto) do begin
		delay(500);
		imprimirNovela(n);
		leer(archivo, n);
	end;
	readkey;
end;

procedure crearArchivo(var archivo: archivo_novelas);
var n: novela; nombre: string;
begin
	writeln('Ingrese el nombre del archivo que desea crear.');
	readln(nombre);
	assign(archivo, nombre);
	rewrite(archivo);
	with n do begin
		cod := 0;
		genero := '';
		nombre := '';
		duracion := 0.0;
		director := '';
		precio := 0.0;
	end;
	write(archivo, n);
	leerNovela(n);
	while(n.cod<>0) do begin
		write(archivo, n);
		leerNovela(n);
	end;
	close(archivo);
end;


procedure agregarNovela(var archivo: archivo_novelas);
var n, cabecera, aux: novela;
begin
	leerNovela(n);
	leer(archivo, cabecera);
	if(cabecera.cod = 0) then begin
		seek(archivo, filesize(archivo));
		write(archivo, n);
	end
	else begin
		
		seek(archivo, (0 - cabecera.cod));
		read(archivo, aux);
		seek(archivo, (0 - cabecera.cod));
		write(archivo, n);
		
		seek(archivo, 0);
		cabecera.cod := 0 - aux.cod;
		write(archivo, cabecera);
	end;
end;

procedure modificarNovela(var archivo: archivo_novelas);
var
	busca: integer;
	n:novela;
begin
	writeln('Ingrese el codigo de la novela que desea modificar');
	readln(busca);
	leer(archivo, n);
	while((n.cod <> valor_alto) and (n.cod<> busca)) do
		leer(archivo, n);
	if(n.cod = busca) then begin
		writeln('Datos actuales de la novela:');
		imprimirNovela(n);
		writeln('Ingrese la nueva informacion para la novela con codigo ', busca);
		leerNovela(n);
		seek(archivo, filepos(archivo) -1);
		write(archivo, n);
	end
	else
		writeln('El codigo ingresado no se encuentra en el archivo');
end;
		

procedure eliminarNovela(var archivo: archivo_novelas);
var
	n,cabecera: novela;
	aux, cod: integer;
	
begin
	writeln('Ingrese el codigo de novela que desea eliminar');
	readln(cod);
	leer(archivo, cabecera);
	leer(archivo, n);
	while((n.cod <> cod) and (n.cod<> valor_alto)) do
		leer(archivo, n);
	if(n.cod = cod) then begin
		aux:= filepos(archivo) - 1;
		n.cod := cabecera.cod;;
		seek(archivo, filepos(archivo)-1);
		write(archivo, n);
		seek(archivo, 0);
		cabecera.cod:= 0 - aux;
		write(archivo, cabecera);
	end
	else
		writeln('La novela que desea eliminar no se encuentra en la lista');
end;

procedure imprimirNovelaEnTexto(var t: text; n: novela);
begin
	with n do begin
			if(n.cod <= 0) then
				writeln(t, '  DISCLAIMER: Novela Eliminada ');
			writeln(t, '  Código: ', cod);
			writeln(t, '  Género: ', genero);
			writeln(t, '  Nombre: ', nombre);
			writeln(t, '  Duración: ', duracion:0:2, ' minutos');
			writeln(t, '  Director: ', director);
			writeln(t, '  Precio: $', precio:0:2);
			writeln(t, '  --------------------');
	end;
end;

procedure exportarATexto(var archivo: archivo_novelas);
var texto: text;
	n:novela;
begin
	assign(texto, 'novelas.txt');
	rewrite(texto);
	leer(archivo, n);
	while(n.cod <> valor_alto) do begin
		imprimirNovelaEnTexto(texto, n);
		leer(archivo, n);
	end;
	close(texto);
end;

procedure manipularArchivo(var archivo: archivo_novelas);
var
	nombre: string;
	opcion: integer;
begin
	clrscr;
	writeln('Ingrese el nombre del archivo al que desea acceder.');
	readln(nombre);
	assign(archivo, nombre);
	reset(archivo);
	writeln('-------------------------------------------------------');
	writeln('Ingrese 1 para dar de alta una novela');
	writeln('Ingrese 2 para modificar la informacion de una novela (menos el codigo)');
	writeln('Ingrese 3 para eliminar una novela');
	writeln('Ingrese 4 para imprimir todas las novelas');
	writeln('Ingrese 5 para listar todas las novelas en un archivo de texto');
	writeln('-------------------------------------------------------');
	readln(opcion);
	case opcion of
		1: agregarNovela(archivo);
		2: modificarNovela(archivo);
		3: eliminarNovela(archivo);
		4: imprimirArchivoNovelas(archivo);
		5: exportarATexto(archivo)
	end;
	close(archivo);
end;


var
	archivo: archivo_novelas;
	opcionMenu: integer;

begin
	
	textbackground(magenta);
	textcolor(cyan);
	SetTextCodePage(Output, 65001);  // 65001 = UTF-8

	repeat
		clrscr;
		writeln('-------------------------------------------------------');
		writeln('--- Menú Principal ---');
		writeln('1. Crear archivo y cargar novelas');
		writeln('2. Abrir archivo existente y realizar mantenimiento');
		writeln('0. Salir');
		write('Ingrese una opción: ');
		readln(opcionMenu);

		case opcionMenu of
			1: crearArchivo(archivo);
			2: manipularArchivo(archivo);
			0: writeln('Saliendo del programa.');
		end;
	until opcionMenu = 0;

	close(archivo);
end.

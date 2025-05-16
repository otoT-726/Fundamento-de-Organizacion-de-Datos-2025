{
	Se cuenta con un archivo que almacena información sobre especies de aves en vía
	de extinción, para ello se almacena: código, nombre de la especie, familia de ave,
	descripción y zona geográfica. El archivo no está ordenado por ningún criterio. Realice
	un programa que permita borrar especies de aves extintas. Este programa debe
	disponer de dos procedimientos:
	a. Un procedimiento que dada una especie de ave (su código) marque la misma
		como borrada (en caso de querer borrar múltiples especies de aves, se podría
		invocar este procedimiento repetidamente).
	b. Un procedimiento que compacte el archivo, quitando definitivamente las
		especies de aves marcadas como borradas. Para quitar los registros se deberá
		copiar el último registro del archivo en la posición del registro a borrar y luego
		eliminar del archivo el último registro de forma tal de evitar registros duplicados.
		i.  Implemente una variante de este procedimiento de compactación del
			archivo (baja física) donde el archivo se trunque una sola vez.
}

program ejercicio7;

const valor_alto= 9999;

type
	ave = record
		cod: integer;
		especie: string[50];
		familia: string[30];
		descripcion: string[200];
		zona: string[50];
	end;

	archivo_aves = file of ave;

procedure leer(var archivo: archivo_aves; var a: ave);
begin
	if(not eof(archivo)) then
		read(archivo, a)
	else
		a.cod:= valor_alto;
end;

procedure leerAve(var a: ave);
begin
	with a do begin
		writeln('Ingrese el código del ave(finaliza con ',valor_alto, '):');
		readln(cod);
		if (cod <> valor_alto) then begin
			writeln('Ingrese el nombre de la especie:');
			readln(especie);
			writeln('Ingrese la familia del ave:');
			readln(familia);
			writeln('Ingrese la descripción del ave:');
			readln(descripcion);
			writeln('Ingrese la zona geográfica del ave:');
			readln(zona);
		end;
	end;
end;

procedure imprimirAve(a: ave);
begin
	with a do begin 
	  writeln('Código: ', cod);
	  writeln('Nombre de la especie: ', especie);
	  writeln('Familia del ave: ', familia);
	  writeln('Descripción: ', descripcion);
	  writeln('Zona geográfica: ', zona);
	end;
  writeln('----------------------------');
end;

procedure borrarAve(var archivo: archivo_aves; ave_extinta: ave);
var a: ave;
begin
	leer(archivo, a);
	while(a.cod <> ave_extinta.cod) and (a.cod<>valor_alto) do
		leer(archivo, a);
	if(a.cod = ave_extinta.cod) then begin
		a.especie := ('-' + a.especie);
		seek(archivo, filepos(archivo) -1);
		write(archivo, a);
	end;
end;

procedure compactarArchivo1(var archivo: archivo_aves);
var a, aux: ave; pos: integer;
begin
	leer(archivo, a);
	while(a.cod<>valor_alto) do begin
		if(a.especie[1] = '-') then begin
			pos:= filepos(archivo) -1;
			seek(archivo, filesize(archivo)-1);
			read(archivo, aux);
			seek(archivo, pos);
			write(archivo, aux);
			seek(archivo, filesize(archivo)-1);
			truncate(archivo);
			seek(archivo, pos);
		end;
		leer(archivo, a);
	end;
end;


procedure compactarArchivo2(var archivo: archivo_aves);
var
	cant, pos: integer;
	a,aux: ave;
begin
	pos:= 0;
	cant:= 0;
	leer(archivo, a);
	while(pos < (filesize(archivo)-cant)) and (a.cod <> valor_alto) do begin
		pos:= filepos(archivo) -1;
		if(a.especie[1] = '-') then begin
			seek(archivo, filesize(archivo)- cant- 1);
			read(archivo, aux);
			seek(archivo, pos);
			write(archivo, aux);
			seek(archivo, pos);
			cant:= cant +1;
		end;
		leer(archivo, a);
	end;
	seek(archivo, filesize(archivo)- cant);
	truncate(archivo);
end;

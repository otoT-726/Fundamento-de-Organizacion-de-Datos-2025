{
	Como actualizar un maestro con un detalle. Segundo caso:
	Precondiciones:
	-ambos archivos estan ordenados por codigo del producto
	-En el archivo detalle solo aparecen productos que existen en el archivo maestro
	-Cada producto del maestro puede ser, a lo largo del dia, vendido mas de una vez, por lo tanto, en el archivo detalle 
	pueden existir varios registros correspondientes al mismo producto
}
program actualizar;
	const valoralto='9999';
type str4 = string[4];
	prod = record
		cod: str4;
		descripcion: string[30];
		pu: real;
		cant: integer;
	end;
	v_prod = record
		cod: str4;
		cv: integer;	{cantidad vendida}
	end;
	detalle = file of v_prod;
	maestro = file of prod;


procedure leer(var archivo: detalle; var dato:v_prod);
begin
	if(not eof(archivo)) then
		read(archivo, dato)
	else
		dato.cod := valoralto;
end;


var
	regm: prod;
	regd: v_prod;
	mae1: maestro;
	det1: detalle;

begin
	assign (mae1, 'maestro');
	assign (det1, 'detalle');
	{proceso principal}
	reset (mae1); reset (det1);
	leer(det1, regd);
	while (regd.cod <> valoralto) do begin
		read(mae1, regm);
		while (regm.cod <> regd.cod) do
			read (mae1,regm);
		while  (regm.cod = regd.cod) do begin
			regm.cant := regm.cant - regd.cv;
			leer(det1, regd);
		end;
		seek (mae1, filepos(mae1)-1);
		write(mae1,regm);
	end;
end.

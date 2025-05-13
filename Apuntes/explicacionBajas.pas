{
	Fundamentos de Organizacion de Datos
	--Bajas--
	
	Baja fisica: Consiste en borrar efectivamente la informacion del archivo, recuperando el espacio fisico
	Decrementa en uno la cantidad de elementos. 
	Ventaja: En todo momento se administra un archivo de datos que ocupa el lugar minimo necesario
	Desventaja: Performance de los algoritmos que implementan esta solucion
	
	Tecnicas de Baja Fisica -> Generar un archivo nuevo con los elementos validos.(sin copiar los que se desea eliminar)
							-> Utilizar el mismo archivo de datos, generando los reacomodamientos que sean necesarios. (Solo para archivos sin ordenar)
	
	
	
	
	Baja logica: Consiste en borrar la informacion el archivo, pero sin recuperar el espacio fisico respectivo
	
	
	
	(truncate: Pone la marca de fin donde está el puntero en el archivo. Se usa para borrar datos.)

	Tecnicas
	->Recuperacion de espacio: Se utiliza el proceso de naja fisica periodicamente para realizar un proceso de compactacion del archivo.
	
	->Reasignacion de espacio: Recupera el espacio utilizando....

}


program explicacion_bajas;


//Primera solucion de baja fisica:
begin 	// se sabe que existe Carlos Garcia y hay uno solo
	assign(archivo, 'arch_empleados');
	assign(archivo_nuevo, 'arch_nuevo');
	reset(archivo);
	rewrite(archivo_nuevo);
	leer(archivo, reg);
	while(reg.nombre <> 'Carlos Garcia') do begin
		write(archivo_nuevo, reg);
		leer(archivo, reg);
	end;
	leer(archivo, reg);
	while(reg.nombre<> valor_alto) do begin
		write(archivo_nuevo, reg);
		leer(archivo, reg);
	end;
	close(archivo);
	close(archivo_nuevo);
	//Renombrar el archivo original para dejarlo como respaldo
	rename(archivo, 'arch_empleados_viejo');
	//Renombrar el archivo temporal con el nombre del original
	rename(archivo_nuevo, 'arch_empleados');

end.
	
//Ejemplo baja logica:

begin // Se sabe que existe Carlos Garcia y hay uno solo.
	assign(archivo, 'arch_empleados');
	reset(archivo);
	leer(archivo, reg);
	//Se avanza hasta Carlos Garcia
	while(reg.nombre <> 'Carlos Garcia') do
		leer(archivo, reg);
	//Se genera una marca de borrado
	reg.nombre:='***';
	//Se borra logicamente a Carlos Garcia
	seek(archivo, filepos(archivo)-1);
	write(archivo, reg);
	close(archivo);
end.

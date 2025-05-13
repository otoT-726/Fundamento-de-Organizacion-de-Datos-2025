program archivos1;

// FOD clase 1: Archivos. Un archivo es un conjunto de datos que se guardan en memoria secundaria (un disco).
// Archivos Binarios o de Texto
// Archivo Binario(File of tipo_dato): Registros de longitud fija o tipados (File of <tipo_dato>)

// Archivos de texto(Text): Caracteres estructurados en lineas. Lectura/escritura con conversion automatica de tipos.
// 					  El acceso es exclusivamente secuencial. Utiles para importar y exportar datos.

// Bloques de bytes (File). Cada elemento del archivo puede tener un tamaño variable
// EJ: A: File of string(20). Cada elemento de la lista ocupa 20 bytes, sin importar el tamaño del string
// B: File. Cada elemento ocupa su tamaño.
// A = "Juan", "Laura".. etc. Cada nombre ocupa 20 bytes
// B = "Juan", "Laura".. etc. Cada nombre ocupa los bytes que corresponde a su tamaño.
// 
// Como declarar un archivo tipado. Hay dos formas:
// 1- var arcihvo_logico: file of tipo_de_dato;
// 2- type
//		archivo = file of tipo_de_datos;
//	  var archivo_logico: archivo;


//EJEMPLO

type
	persona = record
		dni: integer;
		apellido: string[25];
		nombre: string[25];
		direccion: string[25];
		genero: char;
	end;
	archivo_enteros = file of integer;
	archivo_string = file of string;
	archivo_personas = file of persona;

var
	enteros: archivo_enteros;
	strings: archivo_string;
	personas: archivo_personas;
	nombre_fisico: string;
	per: persona;

//logico: se ve en el programa. Fisico: se ve en las carpetas(SO)

BEGIN
	//								Operaciones basicas
	
	//assign(nombre_logico, nombre_fisico);		//Realiza una correspondencia entre el archivo logio y el archivo fisico
	assign(enteros, 'enteros.dat');
	// Apertura y creacion de archivos.
	//rewrite(nombre_logico); Crea el archivo. Si se hace cuando ya existe el archivo, se sobreescribe. Error de desaprobar.
	rewrite(enteros);
	
	//reset(nombre_logico); Abre un archivo existente.
	
	//Cierre de archivos
	//close(nombre_logico); transfiere la informacion del buffer al disco.
	close(enteros);
	
	//							Lectura y escritura de archivos:
	//read(nombre_logico, var_dato);
	//write(nombre_logico, var_dato);
	// El tipo de dato de la variable var_dato es igual al tipo de datos de los elementos del archivo.

	// 							Operaciones Adicionales:
	//EOF(nombre_logico); End Of File. Indica si estoy en el final del archivo. Devuelve un booleano.
	//fileSize(nombre_logico); devuelve el tamaño del archivo. Cantidad de datos del archivo.
	//filePos(nombre_logico); Devuelve la posicion actual del puntero en el archivo. En longitud fija, los registros se numeran de 0 a N-1
	//seek(nombre_logico, pos); Posiciona al puntero donde indica 'pos'.
	
	
	writeln('Ingrese el nombre del archivo: ');
	read(nombre_fisico);
	
	
	
	
END.











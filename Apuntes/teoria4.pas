{
	Formas de acceso: Serie, secuencial y directo.
	Los series los vimos hasta ahora y no los vamos a usar mas.
	
	Archivo estatico: Tiene pocos cambios. Puede actualizarse en procesamiento por lotes. No necesito de estructuras adeicionals para agilizar cambios.
	Archivos Volatiles: Sometida a operaciones frecuentes. Agregar/Borar/Actualizar. Su organizacion debe facilitar cambios rapidos. 
						Necesita estructuras adicionales para mejorar los tiempos de acceso.
	
	OPERACIONES: Altas, Bajas, Modificaciones y Consultas.
	
	-Eliminar registros de un archivo:
		Baja logica
		Baja fisica
		Cuales son las diferencias? 		Borra logicamente el dato. Dice que no está pero en algun lugar si que está. La baja física lo borra definitivamente
		Cuales las ventajas y desvantajas?  La baja logica es más rápida. La ventaja del fisico es que recupera espacio
		
	(truncate: Pone la marca de fin donde está el puntero en el archivo. Se usa para borrar datos.)
	
	-Registro de longitud fisica: agregar o modificar, sin inconvenientes.
	
	-Registros de longitud variables: problemas.
			-Ej: intentar modificar un registro, tal que el modificado quede de mayor tamaño
			-Soluciones posibles:
				-Agregar los datos adicionales al final del archivo (con un vinculo al regitro original) -> complica el procesamiento del registro.
				-Reescribir el registro completo al final del archivo -> queda un espacio vacio (desperdiciado) en el lugar de origen
			-La operación agregar no genera inconvenientes.
	
	--Nos centralizaremos en la eliminación--
		
				
																--BAJA LOGICA--
						
	-Cualquier estrategia de eliminacion de registros debe proveer alguna forma para reconocerlos una vez eliminados 
																  (ej: poner una marca especial en el reg. eliminado)
	-Con este criterio se puede anular la eliminacion facilmente
	-Cómo reutilizar el espacio de registros eliminados?
	-Los progamas que usan archivos deben incluir cierta lógica para ignorar los registros eliminados
	
	
																--BAJA FISICA--
																 
																 -COMPACTACIÓN-
	-Recuperar el archivo.
	-La forma mas simple es copiar todo en un nuevo archivo a excepcion de los registros eliminados. -> Baja fisica
	-Frecuencia:
		-Tiempo(depende del dominio de aplicación)
		-Ante la necesidad de espacio
	-Veremos el analisis de recuperación dinamico del almacenamiento
	
				Aprovachamiento de espacio
	-Reg longitud fisica -> es necesario garantizar:
		-Marcas especiales para los registros borrados -> Baja logica
	Reg de longitud variables-> los nuevos elementos deben caber en el lugar
	
				Recuperacion de espacio para su reutilizacion cuando se agreguen registros:
	-Busqueda secuencial -> Usa las marcas de borrado.
	-Para agrega, se busca el primer registr borrado
	---sigue, copiar---
	
	
	
	-Aprovechamiento de espacio con listas o pilas(header):
	-Lista encadenada de reg. disponibles.
	-Al insertar un reg nuevo en un archivo de reg con long fija, cualquier registro disponible es bueno
	-La lista NO necesita tener un orden particular, ya que todos los registros son de long fija y todos los espacios libres son iguales
	
				Recuperacion de espacio con reg de longitud variables:
	-Marca de borrado al igual que en reg de long fija.
	-El problema de los registros de longitud variable está en que no se puede colocar en culquier lugar, para poder ponerlo debe caber, necesariamente
	-Lista. No se puede usar NPR como enlace. Se utiliza un campo binario que explicitamente indica en enlace (conviene que indique el tamaño)
	-Cada registro indica en su inicio la cant de bytes.
	
	-Estrategias e colocacion de registros en longitud variable:
		-Primer ajuste: Voy al primer lugar de la lista, veo si cabe, si es asi lo agrego.
		-Mejor ajuste: Busca el lugar donde desperdicie menos espacio. Debe recorrer todo y elegir el lugar mas eficiente.
		-Peor ajuste: Ocupa el lugar mas grande, pero solo lo que necesita, entonces el resto puede usarse para guardar otro.
		
		
	Aprovechamiento de espacio: 								-FRAGMENTACIÓN-
	
	-Interna: ocurre cuando se desperdicia epacio en un registro, se le asigna el lugar pero no lo ocupa totalmente. (Primer ajuste y mejor ajuste usan este tipo)
		-Generalmente ocurre con reg longitud fija.
		-Reg long variable evitan el problema.
		Espacio asignado -> no ocupado
	-Externa: ocurre cuando se desperdicia 
	
	
	
	Conclusiones: 
		-Las estrategias de colocacion tienen sentido con registros de longitud variable
		-Primer ajuste es mas rapido. Pude generar fragmentacion interna (porque se le asigna todo el espacio, por definicion)
		-Mejor ajute puede generar fragmentacion interna(porque se le asigna todo el espacio, por definicion)
		-Pero ajuste genera fragmentacion externa. No genera fragmentacion interna por deinicion.
	
	--Archivos-Operaciones--.
		
		Modificaciones, consideraciones iniciales. Si lps registros son de longitud variable, se altera el tamaño.
		
		
		-Otros problemas: 
		-Agregar claves duplicadas, y luego se modifica.
		-Cambiar la clave del registro(que pasa con el orden).
	
	Fin clase 3
	
	Clase 4:
	
	Busqueda de informacion: Secuencial		Directa
	
	Busquda binaria:		 
	
	
	
	
}


program teoria4;

uses crt;
var i : byte;

BEGIN
	
	
END.


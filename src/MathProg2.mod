#Agrupaciones del problema

set AVIONES; #Conjunto de AVIONES
set PISTAS; #Conjunto de PISTAS
set SLOTS; #Conjunto de franjas de tiempo


#Parámetros

param hora_programada{i in AVIONES}, symbolic; #Hora de llegada programada para cada avión
param hora_limite{i in AVIONES}, symbolic; #Hora máxima de aterrizaque para cada avión
param hora_llegada{k in SLOTS}, symbolic; #Tiempo de inicio del SLOT
param costes{a in AVIONES}, >= 0; #Coste de cada avión por minuto en el aterrizaque
param slot_disponible_en_pista{j in PISTAS, k in SLOTS}, binary; #Indica si el SLOT k de la PISTA j está disponible con 1 o no con 0

param M; #Valor muy grande

#Variables de decisión

var disponible{i in AVIONES, j in PISTAS, k in SLOTS}, binary; #Indica si el avión i está disponible para aterrizar en el SLOT k de la PISTA j con 1 o no con 0

#Función objetivo

minimize Coste: sum{i in AVIONES, j in PISTAS, k in SLOTS} costes[i] * disponible[i,j,k] * (hora_llegada[k] - hora_programada[i]);

#Restricciones

s.t. Restriccion_1_slot_por_avion {i in AVIONES}: sum{j in PISTAS, k in SLOTS} disponible[i,j,k] = 1; #Un avión debe de poder aterrizar en un SLOT
s.t. Restriccion_1_avion_por_slot {j in PISTAS, k in SLOTS}: sum{i in AVIONES} disponible[i,j,k] <= 1; #Un SLOT solo puede ser ocupado por un avión
s.t. Restriccion_slot_libre {i in AVIONES, j in PISTAS, k in SLOTS}: disponible[i,j,k] <= slot_disponible_en_pista[j,k]; #Un avión solo puede aterrizar en un SLOT si la pista está disponible
s.t. Restriccion_hora_minimo {i in AVIONES, j in PISTAS, k in SLOTS}: hora_llegada[k] >= hora_programada[i] - M * (1 - disponible[i,j,k]); # Un avión no puede aterrizar antes de su hora programada
s.t. Restriccion_hora_maximo {i in AVIONES, j in PISTAS, k in SLOTS}: hora_llegada[k] <= hora_limite[i] + M * (1 - disponible[i,j,k]); # Un avión no puede aterrizar después de su hora límite
s.t. Restriccion_slots_consecutivos {i in AVIONES, j in PISTAS, k in 1..6}: disponible[i, j, k] + disponible[i, j, k+1] <= 1; #Un avión no puede aterrizar en un slot consecutivo a otro previamente ocupado

end;
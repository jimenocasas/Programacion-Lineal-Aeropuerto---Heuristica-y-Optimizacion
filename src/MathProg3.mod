#Agrupaciones del problema  

set AVIONES; #Conjunto de aviones
set TARIFAS; #Conjunto de tarifas
set PISTAS; #Conjunto de PISTAS
set SLOTS; #Conjunto de franjas de tiempo

#Parámetros

#Paremetros de los aviones
param asientos{AVIONES}, >= 0; #Asientos de cada avión
param capacidad{AVIONES}, >= 0; #Capacidad de cada avión (kg)
param hora_programada{i in AVIONES}, symbolic; #Hora de llegada programada para cada avión
param hora_limite{i in AVIONES}, symbolic; #Hora máxima de aterrizaque para cada avión
param hora_llegada{k in SLOTS}, symbolic; #Tiempo de inicio del SLOT
param costes{a in AVIONES}, >= 0; #Coste de cada avión por minuto en el aterrizaque
param slot_disponible_en_pista{j in PISTAS, k in SLOTS}, binary; #Indica si el SLOT k de la PISTA j está disponible con 1 o no con 0

param M; #Valor muy grande

#Parámetros de las tarifas
param precio{TARIFAS}, >= 0; #Precio de cada tarifa
param equipaje{TARIFAS}, >= 0; #Equipaje permitido de cada tarifa

param billetes_minimos_Leisure; #Número minimo de billetes de la tarifa Leisure
param billetes_minimos_Business; #Número minimo de billetes de la tarifa Business

param porcentaje_minimo_Estandar; #Porcentaje mínimo de billetes de la tarifa Estandar por la compañía


#Variables de decisión
var disponible{i in AVIONES, j in PISTAS, k in SLOTS}, binary; #Indica si el avión i está disponible para aterrizar en el SLOT k de la PISTA j con 1 o no con 0
var x{AVIONES, TARIFAS} >= 0, integer; #Unidades de billete de cada tarifa por avión


#Función objetivo

maximize Beneficio: sum{i in AVIONES, l in TARIFAS}  x[i,l] * precio[l] - sum{i in AVIONES, j in PISTAS, k in SLOTS} costes[i] * disponible[i,j,k] * (hora_llegada[k] - hora_programada[i]);


#Restricciones

s.t. Restriccion_Asientos{i in AVIONES}: sum{l in TARIFAS} x[i,l] <= asientos[i]; #No superar asientos disponibles
s.t. Restriccion_Capacidad{i in AVIONES}: sum{l in TARIFAS} x[i,l] * equipaje[l] <= capacidad[i]; #No superar capacidad de equipaje
s.t. Restriccion_Billetes_Leisure {i in AVIONES}: x[i,'LEISURE'] >= billetes_minimos_Leisure; #Número minimo de billetes de la tarifa Leisure
s.t. Restriccion_Billetes_Business {i in AVIONES}: x[i,'BUSINESS'] >= billetes_minimos_Business; #Número minimo de billetes de la tarifa Business
s.t. Rstriccion_Billetes_Estandar: sum{i in AVIONES} x[i,'ESTANDAR'] >= porcentaje_minimo_Estandar * sum{i in AVIONES, l in TARIFAS} x[i,l]; #Porcentaje mínimo de billetes de la tarifa Estandar de la compañía
s.t. Restriccion_1_slot_por_avion {i in AVIONES}: sum{j in PISTAS, k in SLOTS} disponible[i,j,k] = 1; #Un avión debe de poder aterrizar en un SLOT
s.t. Restriccion_1_avion_por_slot {j in PISTAS, k in SLOTS}: sum{i in AVIONES} disponible[i,j,k] <= 1; #Un SLOT solo puede ser ocupado por un avión
s.t. Restriccion_slot_libre {i in AVIONES, j in PISTAS, k in SLOTS}: disponible[i,j,k] <= slot_disponible_en_pista[j,k]; #Un avión solo puede aterrizar en un SLOT si la pista está disponible
s.t. Restriccion_hora_minimo {i in AVIONES, j in PISTAS, k in SLOTS}: hora_llegada[k] >= hora_programada[i] - M * (1 - disponible[i,j,k]); # Un avión no puede aterrizar antes de su hora programada
s.t. Restriccion_hora_maximo {i in AVIONES, j in PISTAS, k in SLOTS}: hora_llegada[k] <= hora_limite[i] + M * (1 - disponible[i,j,k]); # Un avión no puede aterrizar después de su hora límite
s.t. Restriccion_slots_consecutivos {i in AVIONES, j in PISTAS, k in 1..6}: disponible[i, j, k] + disponible[i, j, k+1] <= 1; #Un avión no puede aterrizar en un slot consecutivo a otro previamente ocupado

end;
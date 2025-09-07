#Agrupaciones del problema  

set AVIONES; #Conjunto de aviones
set TARIFAS; #Conjunto de tarifasç

#Parámetros

#Paremetros de los aviones
param asientos{AVIONES}, >= 0; #Asientos de cada avión
param capacidad{AVIONES}, >= 0; #Capacidad de cada avión (kg)

#Parámetros de las tarifas
param precio{TARIFAS}, >= 0; #Precio de cada tarifa
param equipaje{TARIFAS}, >= 0; #Equipaje permitido de cada tarifa

param billetes_minimos_Leisure; #Número minimo de billetes de la tarifa Leisure
param billetes_minimos_Business; #Número minimo de billetes de la tarifa Business

param porcentaje_minimo_Estandar; #Porcentaje mínimo de billetes de la tarifa Estandar por la compañía


#Variables de decisión

var x{AVIONES, TARIFAS} >= 0, integer; #Unidades de billete de cada tarifa por avión


#Función objetivo

maximize Beneficio: sum{i in AVIONES, j in TARIFAS}  x[i,j] * precio[j];


#Restricciones

s.t. Restriccion_Asientos{i in AVIONES}: sum{j in TARIFAS} x[i,j] <= asientos[i]; #No superar asientos disponibles
s.t. Restriccion_Capacidad{i in AVIONES}: sum{j in TARIFAS} x[i,j] * equipaje[j] <= capacidad[i]; #No superar capacidad de equipaje
s.t. Restriccion_Billetes_Leisure {i in AVIONES}: x[i,'LEISURE'] >= billetes_minimos_Leisure; #Número minimo de billetes de la tarifa Leisure
s.t. Restriccion_Billetes_Business {i in AVIONES}: x[i,'BUSINESS'] >= billetes_minimos_Business; #Número minimo de billetes de la tarifa Business
s.t. Rstriccion_Billetes_Estandar: sum{i in AVIONES} x[i,'ESTANDAR'] >= porcentaje_minimo_Estandar * sum{i in AVIONES, j in TARIFAS} x[i,j]; #Porcentaje mínimo de billetes de la tarifa Estandar de la compañía

end;

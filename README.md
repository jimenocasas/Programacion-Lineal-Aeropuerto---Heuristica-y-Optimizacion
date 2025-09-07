# Optimización en el Transporte Aéreo mediante Programación Lineal  

## Descripción
Este proyecto aplica técnicas de programación lineal para resolver problemas de optimización en el ámbito del transporte aéreo.  
Se desarrollaron dos modelos principales y posteriormente se integraron en una formulación conjunta:  

- Asignación óptima de billetes por tipo de tarifa para maximizar beneficios de una aerolínea.  
- Asignación de slots de aterrizaje en diferentes pistas y horarios, minimizando los costes de retraso de los aviones.  

El modelo integrado consiguió un **beneficio neto de 21.690 €**, demostrando la aplicabilidad de la optimización matemática a problemas reales de negocio y logística.  

## Funcionalidades implementadas
- Modelo de maximización de ingresos por venta de billetes (restricciones de asientos, carga y mínimos por tarifa).  
- Modelo de minimización de costes de retrasos en aterrizajes (slots, tiempos límite, seguridad en pistas).  
- Integración en un modelo global multiobjetivo (beneficio = ingresos – costes).  
- Validación de resultados y análisis de restricciones más limitantes.  
- Escenarios de prueba con cambios en número de aviones, pistas y horarios.

## Tecnologías y herramientas utilizadas
- MathProg (GLPK) → Modelado y resolución de problemas de optimización.  
- LibreOffice Calc (Solver) → Prototipado inicial y resolución de modelos básicos.  
- Programación lineal con variables continuas y binarias.  
- Análisis de restricciones y sensibilidad para validar el modelo. 

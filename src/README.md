# Plagas

Se trata de desarrollar un modelo que permita estudiar los efectos que se producen cuando una **plaga** ataca a un **elemento**.

Vamos a armarlo por partes.


## Elementos que pueden ser atacados.

El modelo incluye los posibles blancos de un ataque, a los que llamamos **elementos**. De cada elemento, nos interesa aber si es bueno o no para la vida de los humanos.
Debemos contemplar estos elementos

- **Hogar**  
	De cada hogar se manejan dos parámetros: el _nivel de mugre_ y el _confort que ofrece_. Estos valores, los dos numéricos varían de hogar en hogar.  
	Se considera que un hogar _es bueno_ si su nivel de mugre es la mitad del confort que ofrece, o menos. 
	
- **Huerta**  
	De cada huerta se conoce la _capacidad de producción_ medida en kilos por mes; a efectos de este modelo es un simple número.  
	Se considera que una huerta _es buena_ si su capacidad de producción supera un nivel que no es fijo, pero es el mismo para todas las huertas.
	
- **Mascota**    
	De cada mascota se conoce el _nivel de salud_, un número. Cuanto más alto es este número, se considera que la mascota es más saludable.  
	Se considera que una mascota _es buena_ si su nivel de salud supera las 250 unidades.
	
A su vez, los elementos se agrupan en **barrios**; en cada barrio hay varios elementos.

<br>

**Requerimientos**  
- Saber si un elemento es, o no, bueno.
- Saber si un barrio es _copado_, la condición es que tenga más elementos buenos que no-buenos. P.ej. si un barrio tiene 7 elementos, 5 son buenos y 2 no, entonces es copado, pero si 3 son buenos y 4 no, entonces el barrio no es copado.

<br>

## Plagas
Como ya indicamos, el propósito de este modelo es estudiar el _ataque_ de una plaga a un elemento.  
Este modelo incluye **cuatro tipos de plaga**: de _cucarachas_, de _mosquitos_, de _pulgas_ y de _garrapatas.  
De cada plaga, sea del tipo que sea, se conoce la _población_, esto es, la cantidad de bichos que la integran.

Está claro que puede haber varias plagas del mismo tipo, que pueden (o no) variar en la población: puede haber tres plagas de mosquitos dando vueltas, dos de 50 mosquitos cada uno y una de 70.

El objetivo de esta parte es modelar las plagas y calcular, para cada una: el _nivel de daño_ que producen al atacar, y si _transmiten enfermedades_ o no, de acuerdo a lo que se indica a continuación.

Para que **cualquier plaga** transmita enfermedades, su población debe ser de al menos 10 bichos. Lo que se indica para cada tipo de plaga es una condición **adicional**.

- Plaga de **cucarachas**:  
	De estas plagas se conoce, además, el _peso promedio_ de cada bicho. P.ej. podemos tener una plaga de 30 cucarachas que pesan, en promedio, 8 gramos.  
	El _nivel de daño_ que produce una plaga de cucarachas equivale a la mitad de su población.  
	Para _transmitir enfermedades_, el peso promedio debe ser de 10 gramos o más (además de la condición común para todas las plagas).  
	
- Plaga de **pulgas**:  
	El _nivel de daño_ que produce una plaga de pulgas equivale al doble de su población.   
	Las plagas de pulgas no agregan ninguna condición adicional para _transmitir enfermedades_.  
	
- Plaga de **garrapatas**:  
	El _nivel de daño_ que producen, y el criterio para determinar si _transmiten enfermedades_, son iguales a los de la plaga de pulgas. Más adelante va a aparecer una diferencia entre pulgas y garrapatas. 

- Plaga de **mosquitos**:  
	El _nivel de daño_ que producen las plagas de este tipo equivale a la población.  
	Para _transmitir enfermedades_, la población debe ser un número múltiplo de 3 (además de la condición común para todas las plagas); la cuenta es `poblacion % 3 == 0`.
	
<br>

**Requerimientos**  
- obtener el _nivel de daño_ de una plaga cualquiera.
- saber si una plaga _transmite enfermedades_ o no.

<br>

## Efectos de un ataque sobre los elementos
En esta etapa, agregamos al modelo el efecto que produce, sobre un elemento, el ataque de una plaga.  
Este efecto se calcula a partir del nivel de daño de la plaga, y de si transmite o no enfermedades, de acuerdo a la siguiente especificación _para cada tipo de elemento_.

- **Hogar**  
	El nivel de mugre aumenta en la misma cantidad del nivel de daño de la plaga.
	 
- **Huerta**  
	La huerta baja su capacidad de producción, en una cantidad que equivale al 10% del nivel de daño de la plaga.
	Si la plaga transmite enfermedades, la capacidad de producción baja 10 puntos adicionales.  
	P.ej. una huerta que recibe un ataque de una plaga con nivel de daño 80 que no transmite enfermedades, baja su capacidad de producción en 8 unidades. Para una plaga igual pero que sí transmite enfermedades, la capacidad de producción baja en 18 unidades.
	
- **Mascota**    
	Si la plaga que ataca transmite enfermedades, entonces el nivel de salud de la mascota disminuye en una cantidad igual al nivel de daño de la plaga. Si la plaga **no** transmite enermedades, a la mascota no le pasa nada.
	
<br>

**Requerimientos**  
- poder simular que un elemento _recibe el ataque_ de una plaga, generándose los efectos indicados en el elemento.

<br>

## Efectos de un ataque sobre las plagas

Cuando una plaga ataca a un elemento, también se produce un efecto _sobre la plaga_.

Este efecto consiste en que la población de la plaga aumenta un 10%.
Hay dos casos particulares
- para las _plagas de cucarachas_: **además** del aumento de población, el peso promedio aumenta en 2 gramos.
- para las _plagas de garrapatas_: la población aumenta un 20%, **en lugar del** aumento de 10%. Este es el aspecto en el que las plagas de garrapatas se distinguen de las de pulgas.

<br>

**Requerimiento**  
Agregar al modelo los efectos descriptos.


<br>

**Consejo**  
Agregar un método en las plagas que implemente el ataque a un elemento, que haga dos cosas: 
1. aplicar los efectos sobre la plaga, y 
2. decirle al elemento que recibe un ataque usando lo que se agregó en la etapa anterior.

# Darth In-Vaders

**Darth In-Vaders** es una réplica del videojuego clásico de arcade **Space Invaders**, desarrollada en **Processing**, pero con temática inspirada en **Star Wars**.
En este juego el jugador controla una nave que debe derrotar a los stormtroopers y enfrentarse a Darth Vader antes de que se acabe el tiempo o pierda todas sus vidas.

## 🎮 Descripción

El juego mantiene la mecánica clásica de Space Invaders:

* El jugador puede moverse a izquierda y derecha.
* Puede disparar para eliminar enemigos.
* Los enemigos avanzan progresivamente hacia el jugador.
* Al derrotar a todos los enemigos, aparece **Darth Vader** como jefe final.

El juego tiene las siguientes condiciones de derrota:

* El jugador tiene **3 vidas**.
* Se pierde si:

  * Se queda sin vidas.
  * Los aliens alcanzan al jugador.
  * Se acaba el tiempo límite de **90 segundos**.

## 🛠 Tecnologías usadas

* Lenguaje: Java (Processing)
* Entorno: Processing IDE
* Librería de audio: Minim

## 📦 Requisitos

Para poder ejecutar el juego es necesario:

1. Tener instalado **Processing**
2. Instalar la librería **Minim** para audio

### Cómo instalar Minim

En Processing:

Sketch → Import Library → Add Library
Buscar: **Minim**
Instalar: **Minim – Audio library for Processing**

Si la librería no está instalada, aparecerá el error:

No library found for ddf.minim

## ▶️ Cómo ejecutar

1. Abrir el archivo `.pde` en Processing
2. Asegurarse de que Minim esté instalada
3. Ejecutar el sketch

## 🎯 Controles

* Flecha izquierda → mover a la izquierda
* Flecha derecha → mover a la derecha
* Tecla **S** → disparar
* Click del mouse → iniciar juego

## ⏱ Reglas del juego

* Tienes 3 vidas.
* El juego termina si:

  * Pierdes todas las vidas.
  * Los enemigos llegan hasta tu nave.
  * Se acaba el tiempo límite de 90 segundos.
* Si derrotas a todos los enemigos, aparece Darth Vader.
* Si derrotas a Darth Vader, ganas.

## 👨‍💻 Autores

Proyecto realizado por:

* Julio Cesar Albadan Sarmiento
* Jay Alvarez Baez
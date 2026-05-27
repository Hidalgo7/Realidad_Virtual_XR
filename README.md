# DeliveryVR

Proyecto de realidad virtual desarrollado para la asignatura de **Realidad Virtual y Aumentada** de la **EHU/UPV**.

## Descripción

**DeliveryVR** es una experiencia VR creada en **Godot** en la que el jugador se sitúa sobre la parte trasera de un camión en movimiento y debe lanzar cajas hacia zonas de entrega repartidas por una ciudad de estilo _low-poly_.

El prototipo utiliza **OpenXR** y **Godot XR Tools** para la interacción con controladores VR. La lógica de generación de cajas, agarre, físicas, puntuación, movimiento del camión y retroalimentación visual está implementada en GDScript.

## Características

- Interacción VR mediante controladores XR.
- Generación y lanzamiento físico de cajas.
- Sistema de agarre con ambas manos.
- Movimiento automático del camión sobre rutas predefinidas.
- Sistema de puntuación dinámico.
- Zonas de entrega iluminadas y animadas.
- Entorno urbano _low-poly_ optimizado para VR.
- Compatibilidad con OpenXR.

## Requisitos

- Godot Engine 4.5.
- Visor compatible con OpenXR.
- Controladores VR.
- Godot XR Tools (incluido en `addons/godot-xr-tools/`).
- Godot OpenXR Vendors (incluido en `addons/godotopenxrvendors/`).

## Ejecución

1. Clonar o descargar el repositorio.
2. Abrir `project.godot` desde Godot 4.5.
3. Activar el plugin **Godot XR Tools** (en caso de que no lo esté).
4. Conectar el visor VR y asegurarse de que el runtime OpenXR está activo.
5. Ejecutar la escena principal del proyecto (`scenes/main.tscn`).

## Jugabilidad

El jugador permanece en el interior del maletero de un camión mientras atraviesa una ciudad. Durante el recorrido aparecen zonas de entrega marcadas visualmente en el suelo.

Objetivo:

1. Generar cajas con el controlador derecho.
2. Agarrarlas con las manos virtuales.
3. Lanzarlas físicamente hacia las zonas objetivo.
4. Conseguir la máxima puntuación posible antes de abandonar cada zona.

Cada zona requiere un número aleatorio de entregas para completarse.

## Controles

| Acción         | Control                                                |
| -------------- | ------------------------------------------------------ |
| Generar caja   | Gatillo del controlador derecho                        |
| Agarrar objeto | Grip del controlador izquierdo o derecho               |
| Soltar objeto  | Liberar grip                                           |
| Lanzar caja    | Soltar la caja aplicando movimiento físico con la mano |

## Entorno

El escenario está compuesto por una ciudad _low-poly_ diseñada para mantener un rendimiento fluido en VR. Incluye edificios, carreteras, mobiliario urbano, señales de tráfico, vehículos y zonas de entrega.

Para reducir la cinetosis:

- El camión mantiene movimientos suaves.
- Se evitan aceleraciones bruscas.
- El entorno utiliza baja complejidad geométrica.
- Las zonas objetivo tienen una señalización visual clara.

## Tecnologías

- Godot Engine 4.5.
- OpenXR.
- Godot XR Tools.
- Godot OpenXR Vendors.
- GDScript.

## Estructura del proyecto

```text
.
├── addons/      # Plugins y herramientas XR
├── assets/      # Modelos 3D, texturas y recursos visuales
├── scenes/      # Escenas principales y prefabs del juego
├── scripts/     # Scripts de lógica e interacción
├── project.godot
└── openxr_action_map.tres
```

## Scripts principales

| Script                     | Función                                                |
| -------------------------- | ------------------------------------------------------ |
| `right_hand_controller.gd` | Generación y manipulación de cajas con la mano derecha |
| `left_hand_controller.gd`  | Agarre secundario con la mano izquierda                |
| `score_area.gd`            | Detección de entregas y suma de puntos                 |
| `score_zone.gd`            | Configuración visual y lógica de cada zona de entrega  |
| `GameManager.gd`           | Gestión global de la puntuación                        |
| `path_follow_3d.gd`        | Movimiento automático del camión                       |
| `floor_glow.gd`            | Brillo pulsante de las zonas de entrega                |
| `border_lines.gd`          | Generación procedural de bordes punteados              |

## Posibles mejoras futuras

- Sonido espacial.
- Diferentes tipos de cajas.
- Sistema de tiempo límite.
- Obstáculos dinámicos.
- Mayor variedad de escenarios.
- Exportación final para dispositivo VR concreto.

## Autores

- Iker Hidalgo.
- Adriana Bernal.

EHU/UPV - Curso 2025-2026.

## Referencias

- https://godotengine.org/
- https://www.khronos.org/openxr/
- https://github.com/GodotVR/godot-xr-tools

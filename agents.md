# agents.md – Hoja de ruta para la app móvil de codificación FT8/FT4/FT2 (Flutter)

## Visión general
- Aplicación **multiplataforma** (Android + iOS) desarrollada con **Flutter**.
- Código **reutilizable y bien estructurado**, con **pruebas exhaustivas** antes de cualquier commit.
- Utiliza **Hot Reload** siempre que sea posible para acelerar el desarrollo.
- **Seguridad**: datos sensibles encriptados u ofuscados, la app **no guarda datos fuera del dispositivo** salvo sincronización opcional cifrada.
- **Rendimiento**: bajo consumo de batería, latencia adecuada sin límites estrictos.
- **Extensibilidad**: preparada para futuras integraciones (p.ej., RTTY, otros modos).

## Reglas operativas (Rules)
- **Código reutilizable y bien estructurado**: seguir arquitectura limpia (layers) con separación clara entre UI, dominio y datos.
- **Pruebas**: todo el código debe estar **bien probado** (unit, integration y UI) antes de subir al repositorio.
- **Hot Reload**: usar siempre que sea posible para acelerar iteraciones.
- **Commits en inglés**: mensajes claros siguiendo Conventional Commits (`feat:`, `fix:`, `refactor:`).
- **Privacidad de datos**: la app **no guarda datos fuera del dispositivo**; cualquier dato sensible se almacena **encriptado o ofuscado**.
- **Consumo de batería**: la app **no debe drenar batería** (optimizar procesos en background, uso de audio y señal). No se establecen límites estrictos, pero se busca eficiencia.
- **Futuras integraciones**: diseño abierto para añadir modos como **RTTY** u otros.
- **Investigación**: si surge una duda, **consultar en internet**; no asumir conocimiento sin verificar.
- **Commits por bloques**: los cambios se agruparán en **bloques de código importante**; el asistente preguntará al usuario antes de realizar cada commit.

## Agentes y responsibilities
| Agente | Responsabilidad | Skills / Dependencias |
|--------|----------------|-----------------------|
| **SignalAgent** | Generar/decodificar FT8/FT4/FT2 (FFT, LDPC, sincronización) | libft8 (C/C++) vía FFI, FFT, LDPC, temporización, Dart FFI
| **AudioAgent** | Captura y reproducción de audio, filtrado y ganancia | audio_record, audio_player, DSP (filtros), manejo de streams
| **StorageAgent** | Persistir logs y contactos, exportar/importar (CSV, ADIF, JSON) | Drift + sqlcipher, exportadores, importadores
| **SyncAgent** | Sincronización opcional con nube (Firebase/Firestore) | Firestore offline‑first, conflict resolution, workmanager
| **UIAgent** | UI/UX (tema oscuro, accesibilidad, hot‑reload) | Flutter theming, responsive layout, accessibility
| **IntegrationAgent** | Consumir APIs externas (QRZ, HamQTH, DXCluster, predicción) | dio, web_socket_channel, OAuth/ApiKey, JSON parsing
| **SecurityAgent** | Gestión de permisos, encriptación, validación de datos | permission_handler, flutter_secure_storage, TLS pinning
| **TestAgent** | Ejecutar suite de pruebas (unit, integration, UI) | flutter_test, integration_test, mockito, coverage
| **CICDAgent** | Pipeline CI/CD (lint, tests, builds) | GitHub Actions, fastlane, dart lint, codecov

## Skills reutilizables
- **libft8 (C/C++)** – algoritmo de referencia WSJT‑X.
- **Drift + sqlcipher** – ORM SQLite con cifrado.
- **dio** – cliente HTTP con interceptores y retries.
- **web_socket_channel** – comunicación WebSocket.
- **flutter_bloc / provider** – gestión de estado.
- **workmanager** – tareas en background.
- **fastlane** – automatización de builds.
- **flutter_test, integration_test, mockito** – pruebas.
- **flutter_secure_storage** – almacenamiento seguro de credenciales.
- **cloud_firestore** – base de datos en la nube con modo offline.
- **intl** – formateo de fechas/horas.
- **url_launcher** – compartir resultados.

## Roadmap y hitos (tentativo)
| Fase | Duración | Objetivo |
|------|-----------|----------|
| **Setup** | 1 semana | Configuración de repo, CI, arquitectura base. |
| **MVP (Core)** | 4 semanas | Implementar SignalAgent + AudioAgent, UI básica, almacenamiento local. |
| **Sync & Export** | 3 semanas | Añadir SyncAgent (Firestore) y export/import ADIF/CSV. |
| **Integraciones externas** | 3 semanas | Conectar a QRZ, HamQTH, DXCluster y compartir resultados. |
| **UI/UX avanzada** | 2 semanas | Tema oscuro, accesibilidad, hot‑reload continuo. |
| **Beta pública** | 2 semanas | Release a TestFlight / Google Play Internal Testing, feedback. |
| **Lanzamiento oficial** | 1 semana | Publicación en App Store y Play Store (v1.0.0). |

> **Notas**: Los commits se harán por bloques de código importante; se preguntará al usuario antes de cada commit.

---
*Generado por Claude Code.*

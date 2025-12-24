# 🐱 Cat Breeds App

Aplicación iOS desarrollada en **Swift (UIKit)** que permite a los usuarios **explorar razas de gatos**, ver sus detalles, registrarse e iniciar sesión usando **Firebase**, y consumir datos desde **TheCatAPI**.

---

## 📱 Características principales

- 🔐 **Autenticación de usuarios**
  - Inicio de sesión
  - Registro de usuarios
  - Recuperación de contraseña
  - Cierre de sesión
- ☁️ **Firebase**
  - Firebase Authentication
  - Firebase Firestore para datos de usuario
- 🐈 **Listado de razas de gatos**
  - Consumo de API REST (TheCatAPI)
  - Búsqueda por nombre u origen
  - Pull to refresh
  - Manejo de estados (loading / error / success)
- 📄 **Detalle de raza**
  - Imagen
  - Origen
  - Temperamento
  - Descripción
  - Peso y esperanza de vida
- 👤 **Perfil de usuario**
  - Nombre
  - Email
  - Teléfono
- 🎨 **UI/UX cuidada**
  - Loader
  - Empty states
  - Animaciones sutiles
  - Componentes reutilizables mediante Extensions

---

## 🧱 Arquitectura utilizada

- **MVC + Services**
- Separación clara de responsabilidades:
  - `ViewControllers` → UI y navegación
  - `Services` → Lógica de red y Firebase
  - `Models` → Entidades (`Breed`, `Weight`, etc.)
  - `Extensions` → Reutilización de estilos y utilidades
- Manejo de estado mediante `FetchState`

---

## 📂 Estructura del proyecto


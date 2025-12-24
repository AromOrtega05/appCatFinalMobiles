# 🐱 Cat Breeds App

Aplicación iOS desarrollada en **Swift (UIKit)** que permite a los usuarios **explorar razas de gatos**, ver información detallada de cada una y gestionar su cuenta mediante **Firebase Authentication**, consumiendo datos desde **TheCatAPI**.

Proyecto enfocado en buenas prácticas, arquitectura clara y una experiencia de usuario cuidada.

---

## 📱 Funcionalidades principales

### 🔐 Autenticación de usuarios
- Inicio de sesión
- Registro de nuevos usuarios
- Recuperación de contraseña
- Cierre de sesión
- Persistencia de sesión

### ☁️ Firebase
- **Firebase Authentication** para gestión de usuarios
- **Firebase Firestore** para almacenar información del perfil:
  - Nombre
  - Email
  - Teléfono

### 🐈 Razas de gatos
- Consumo de API REST (**TheCatAPI**)
- Listado de razas
- Búsqueda por:
  - Nombre
  - País de origen
- Pull to refresh
- Manejo de estados:
  - Loading
  - Error
  - Success
  - Empty state

### 📄 Detalle de raza
- Imagen de la raza
- Origen
- Temperamento
- Descripción
- Peso
- Esperanza de vida

### 🎨 UI / UX
- Indicadores de carga (Loader)
- Estados vacíos y mensajes de error
- Animaciones sutiles
- Componentes reutilizables mediante **Extensions**
- Diseño limpio y consistente con UIKit

---

## 🧱 Arquitectura

La aplicación utiliza una arquitectura **MVC + Services**, manteniendo una clara separación de responsabilidades.

### 📐 Organización
- **ViewControllers**
  - Manejo de vistas y navegación
- **Models**
  - Entidades de dominio (`Breed`, `Weight`, etc.)
- **Services**
  - Consumo de API
  - Firebase Authentication
  - Firebase Firestore
- **Extensions**
  - Estilos reutilizables
  - Utilidades para UIKit
- **Helpers / Utils**
  - Manejo de estados (`FetchState`)
  - Constantes

---

## 📂 Estructura del proyecto

```text
CatBreedsApp
│
├── Models
│   ├── Breed.swift
│   ├── Weight.swift
│
├── Services
│   ├── APICaller.swift
│   ├── CatService.swift
│   ├── AuthService.swift
│   ├── BreedFetcher.swift
│
├── ViewControllers
│   ├── LoginViewController.swift
│   ├── RegisterViewController.swift
│   ├── BreedsViewController.swift
│   ├── BreedDetailViewController.swift
│   ├── ProfileViewController.swift
│
├── Extensions
│   ├── UIView+Extensions.swift
│   ├── UILabel+Extensions.swift
│   ├── UIButton+Extensions.swift
│
├── Helpers
│   ├── FetchState.swift
│   ├── Constants.swift
│
└── Resources
    ├── Assets.xcassets
    └── LaunchScreen.storyboard

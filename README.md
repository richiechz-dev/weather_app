# Weather App 🌦️

Aplicación móvil desarrollada con Flutter que muestra información meteorológica en tiempo real basada en la ubicación actual del usuario.

## 📋 Descripción

Esta aplicación obtiene automáticamente la ubicación del dispositivo y muestra las condiciones climáticas actuales, incluyendo la temperatura y animaciones según el estado del clima. Utiliza la API de OpenWeatherMap para obtener datos meteorológicos precisos.

## Características

- Detección automática de ubicación del usuario
- Visualización de temperatura en tiempo real
- Animaciones Lottie según las condiciones climáticas
- Muestra el nombre de la ciudad actual
- Interfaz de usuario limpia y moderna

## 🚀 Tecnologías y Dependencias

### Dependencias principales:
- **flutter**: Framework principal
- **http** (^1.6.0): Realizar peticiones HTTP a la API
- **geolocator** (^14.0.2): Obtener la ubicación GPS del dispositivo
- **geocoding** (^4.0.0): Convertir coordenadas en nombres de ciudades
- **lottie** (^3.3.2): Animaciones JSON para las condiciones climáticas

## 🏗️ Estructura del Proyecto

```
lib/
├── main.dart                    # Punto de entrada de la aplicación
├── model/
│   └── weather_model.dart      # Modelo de datos del clima
├── pages/
│   └── weather_page.dart       # Pantalla principal de la app
└── services/
    └── weather_service.dart    # Servicio para consultar el API
```

## 📚 Conceptos Fundamentales de Dart Utilizados

### 1. **Clases y Constructores**
Las clases son los bloques de construcción fundamentales en Dart. En este proyecto se definen clases para organizar el código:

```dart
class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather({required this.cityName, required this.temperature, required this.mainCondition});
}
```

- **Propiedades `final`**: Variables inmutables una vez asignadas
- **Constructor con parámetros nombrados**: Usa `{}` y `required` para parámetros obligatorios

### 2. **Factory Constructors**
Patrón usado para crear instancias con lógica adicional, útil para parsear JSON:

```dart
factory Weather.fromJson(Map<String, dynamic> json) {
  return Weather(
    cityName: json['name'], 
    temperature: json['main']['temp'].toDouble(), 
    mainCondition: json['weather'][0]['main']
  );
}
```

### 3. **Async/Await y Futures**
Programación asíncrona para operaciones que toman tiempo (peticiones HTTP, GPS):

```dart
Future<Weather> getWeather(String cityName) async {
  final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey'));
  return Weather.fromJson(jsonDecode(response.body));
}
```

- **`Future<T>`**: Representa un valor que estará disponible en el futuro
- **`async`**: Marca una función como asíncrona
- **`await`**: Espera a que se complete una operación asíncrona

### 4. **Null Safety**
Dart 3 requiere manejo explícito de valores nulos:

```dart
String? city = placemark[0].locality;  // ? indica que puede ser null
return city ?? '';  // ?? operador de coalescencia nula (default)
```

- **`Type?`**: El tipo puede contener `null`
- **`??`**: Operador que proporciona un valor por defecto si es `null`

### 5. **Variables `final` y `const`**
```dart
final _weatherService = WeatherService('api_key');  // Valor en tiempo de ejecución
static const BASE_URL = "https://api...";  // Constante en tiempo de compilación
```

### 6. **String Interpolation**
Insertar variables en strings de forma elegante:

```dart
Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric')
Text('${_weather?.temperature.round()}°C')
```

### 7. **Map<String, dynamic>**
Estructura de datos clave-valor usada para JSON:

```dart
Map<String, dynamic> json = jsonDecode(response.body);
```

### 8. **Manejo de Excepciones**
```dart
try {
  final weather = await _weatherService.getWeather(cityName);
} catch(e) {
  print(e);
}
```

### 9. **Funciones Flecha (Arrow Functions)**
Sintaxis concisa para funciones de una línea (heredado de los widgets):

```dart
@override
Widget build(BuildContext context) => Scaffold(...);
```

### 10. **Operador de Acceso Condicional (?. y ??)**
```dart
Text(_weather?.cityName ?? 'loading city ... ')
```
- **`?.`**: Accede a propiedades solo si el objeto no es null
- **`??`**: Proporciona valor alternativo si es null

## ⚙️ Configuración

### 1. Clonar el repositorio
```bash
git clone <url-del-repositorio>
cd weather_app
```

### 2. Instalar dependencias
```bash
flutter pub get
```

### 3. Configurar API Key
Obtén tu API key de [OpenWeatherMap](https://openweathermap.org/api) y reemplázala en [weather_page.dart](lib/pages/weather_page.dart):

```dart
final _weatherService = WeatherService('TU_API_KEY_AQUI');
```

### 4. Configurar permisos de ubicación

**Android** ([android/app/src/main/AndroidManifest.xml](android/app/src/main/AndroidManifest.xml)):
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

**iOS** ([ios/Runner/Info.plist](ios/Runner/Info.plist)):
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Esta app necesita acceso a tu ubicación para mostrar el clima local</string>
```

### 5. Ejecutar la aplicación
```bash
flutter run
```

## Capturas de Pantalla

La aplicación muestra:
- Nombre de la ciudad detectada
- Animación del clima (nubes, lluvia, sol, etc.)
- Temperatura actual en grados Celsius

## Desarrollo

### Requisitos previos
- Flutter SDK (3.10.3 o superior)
- Dart SDK
- Android Studio / VS Code
- Emulador o dispositivo físico

### Comandos útiles
```bash
# Instalar dependencias
flutter pub get

# Ejecutar en modo debug
flutter run

# Construir para producción
flutter build apk  # Android
flutter build ios  # iOS

# Analizar código
flutter analyze
```

## 📝 Notas

- La API key está visible en el código por simplicidad. En producción, usa variables de entorno o archivos de configuración seguros.
- Los assets de animaciones Lottie están en la carpeta `assets/`

---

Desarrollado usando Flutter y Dart


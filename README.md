# PE03 - Infraestructura de Clúster Web con Balanceo de Carga y Base de Datos

## 📝 Descripción del Proyecto

Este proyecto implementa una infraestructura escalable y de alta
disponibilidad utilizando **Vagrant** y **VirtualBox**.

El objetivo es simular un entorno de producción profesional donde el
tráfico de los usuarios es gestionado por un balanceador de carga que
reparte las peticiones entre tres servidores web, los cuales comparten
una base de datos centralizada para mantener la persistencia de la
información.

------------------------------------------------------------------------

## 🏗️ Arquitectura del Sistema

La infraestructura se compone de **5 máquinas virtuales** basadas en
**Ubuntu 20.04 LTS**:

1.  **Balanceador (lb):**\
    Servidor Nginx que actúa como punto de entrada único.\
    IP: `192.168.56.10`

2.  **Servidores Web (web1, web2, web3):**\
    Servidores Apache2 con PHP que procesan la lógica de la aplicación.\
    IPs:

    -   `192.168.56.11`\
    -   `192.168.56.12`\
    -   `192.168.56.13`

3.  **Base de Datos (db):**\
    Servidor MySQL centralizado para todo el clúster.\
    IP: `192.168.56.20`

------------------------------------------------------------------------

## 📂 Estructura de Archivos del Repositorio

``` text
.
├── Vagrantfile              # Configuración y aprovisionamiento de las 5 VMs
├── .gitignore               # Exclusión de la carpeta .vagrant/ y archivos temporales
├── scripts/                 # Automatización del despliegue (Bash)
│   ├── common.sh            # Actualización de paquetes común a todas las VMs
│   ├── lb.sh                # Instalación y configuración de Nginx
│   ├── web.sh               # Instalación de Apache+PHP y limpieza de archivos por defecto
│   └── db.sh                # Configuración de MySQL, creación de DB, usuario y tablas
└── config-files/            # Archivos de configuración y código fuente
    ├── nginx.conf           # Configuración del clúster (Upstream) para el balanceo
    └── index.php            # Aplicación PHP que conecta a la base de datos remota
```

------------------------------------------------------------------------

## ⚙️ Configuración y Servicios

### 1️⃣ Balanceador de Carga (Nginx)

Configurado como **Proxy Inverso**.

Utiliza un bloque `upstream` para definir el grupo de servidores web.\
El tráfico se distribuye mediante el algoritmo **Round Robin**,
asegurando que ningún servidor se sature.

------------------------------------------------------------------------

### 2️⃣ Nodos Web (Apache + PHP)

Cada nodo ejecuta un servidor Apache optimizado para procesar el archivo
`index.php`.

El script de aprovisionamiento:

-   Elimina el archivo `index.html` original de Ubuntu.
-   Evita conflictos de prioridad.
-   Garantiza que se cargue la aplicación dinámica en PHP.

------------------------------------------------------------------------

### 3️⃣ Base de Datos (MySQL)

Configurada para aceptar conexiones externas desde la red privada
modificando:

    bind-address = 0.0.0.0

Existe una base de datos llamada `proyecto` con una tabla `visitas` que
registra:

-   **ID:** Autoincremental
-   **Fecha:** Marca de tiempo automática
-   **Servidor:** Hostname del servidor web que procesó la entrada

------------------------------------------------------------------------

## 🚀 Cómo ponerlo en marcha

1.  Clonar este repositorio.
2.  Asegurarse de tener instalados **Vagrant** y **VirtualBox**.
3.  Desde la raíz del proyecto, ejecutar:

``` bash
vagrant up
```

4.  Acceder desde el navegador en la máquina anfitriona a:

```{=html}
<!-- -->
```
    http://localhost:8080

(O la IP del balanceador configurada).

------------------------------------------------------------------------
### ⚖️ Balanceador funcionando

(images/web.png)

-------------------------------------------------------------------------
## 👨‍💻 Autor

**Héctor Martínez Márquez**

**Curso:** 2º ASIR
**Centro:** IES Gregorio Prieto
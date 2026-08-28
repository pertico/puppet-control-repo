Como Ingeniero de Sistemas/Administrador de Sistemas Senior estoy comenzado un proyecto de gestión de configuración en Puppet

Incialmente estoy trabajando sobre la versión 7.34.0 de la versión Open Source pero quiero compatibilidad tanto con las 
versiones 8 Open Source (incluídas las de paquetes propios de sistema operativo como Debian) como con la nueva versión OpenVox 8.
Por ahora no me interesa evolucionar a la versión 9.

Igualmente, como la plataforma a gestionar es muy pequeña voy a usar una arquitectura masterless sin servidor central.
La platarforma consta de varias instancias WSL (Debian/Ubuntu) en distintos equipos Windows 10/11, instancias físicas de Debian 13 (d270) e 
instancias físicas de Raspbian 13 (pi).

Hasta ahora tengo la siguiente estructura básica con algunas configuraciones iniciales de prueba en mi puppet-control-repo

.
├── data
├── manifests
├── modules
│   ├── apt
│   │   ├── data
│   │   │   └── os
│   │   │       └── Debian
│   │   ├── examples
│   │   ├── files
│   │   ├── lib
│   │   │   ├── facter
│   │   │   └── puppet
│   │   │       ├── provider
│   │   │       │   └── apt_key
│   │   │       └── type
│   │   ├── manifests
│   │   ├── tasks
│   │   ├── templates
│   │   └── types
│   ├── debconf
│   │   ├── data
│   │   └── lib
│   │       └── puppet
│   │           ├── provider
│   │           │   └── debconf
│   │           └── type
│   ├── inifile
│   │   ├── data
│   │   ├── examples
│   │   └── lib
│   │       └── puppet
│   │           ├── functions
│   │           │   └── inifile
│   │           ├── provider
│   │           │   ├── ini_setting
│   │           │   └── ini_subsetting
│   │           ├── type
│   │           └── util
│   │               └── ini_file
│   ├── stdlib
│   │   ├── data
│   │   ├── examples
│   │   ├── functions
│   │   ├── lib
│   │   │   ├── facter
│   │   │   │   └── util
│   │   │   ├── puppet
│   │   │   │   ├── functions
│   │   │   │   │   └── stdlib
│   │   │   │   ├── parser
│   │   │   │   │   └── functions
│   │   │   │   ├── provider
│   │   │   │   │   └── file_line
│   │   │   │   └── type
│   │   │   └── puppet_x
│   │   │       └── stdlib
│   │   ├── manifests
│   │   ├── readmes
│   │   └── types
│   │       ├── dns
│   │       ├── ensure
│   │       │   └── file
│   │       ├── http
│   │       ├── ip
│   │       │   └── address
│   │       │       ├── v4
│   │       │       └── v6
│   │       │           └── nosubnet
│   │       ├── objectstore
│   │       └── port
│   ├── timezone
│   │   ├── data
│   │   │   └── family
│   │   │       ├── RedHat
│   │   │       └── Suse
│   │   ├── manifests
│   │   └── templates
│   └── tools
│       └── manifests
└── site-modules
    ├── profiles
    │   ├── lib
    │   │   └── facter
    │   └── manifests
    │       ├── base
    │       ├── sdk
    │       └── tools
    └── roles
        └── manifests
            └── sdk

El primer paso que quiero dar pasar a gestionar este repositorio con r10k pero incialmente sin una copia remota, 
solo con el repositorio git en local. Mas adelante se creará un repositorio remoto en github.

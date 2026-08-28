# site-modules/profiles/manifests/sdk.pp
#
# SDK configuration
# 
class profiles::sdk {
  # 1. Forzamos la activación de las herramientas deseadas
  class { 'profiles::tools::kind':
    enabled => true,
  }

  class { 'profiles::tools::minikube':
    enabled => true,
  }

  # 2. El resto (como cfssl) se queda apagado automáticamente
  # Invocamos el orquestador principal para asegurar que el orden y las dependencias se mantengan
  include profiles::tools
}

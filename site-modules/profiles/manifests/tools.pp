# modules/profiles/manifests/tools.pp
class profiles::tools {
  # Incluimos las subclases individuales que acabamos de crear
  include profiles::tools::cfssl
  include profiles::tools::minikube
  include profiles::tools::kind
}

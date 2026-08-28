# modules/tools/manifests/init.pp
class tools (
  Hash $apps = {},
) {
  # Instancia dinámicamente cada herramienta del hash
  $apps.each |$app_name, $app_data| {
    tools::tool { $app_name:
      enabled       => $app_data['enabled'],
      version       => $app_data['version'],
      repo          => $app_data['repo'],
      binaries      => $app_data['binaries'],
      binary_suffix => $app_data['binary_suffix'],
    }
  }
}

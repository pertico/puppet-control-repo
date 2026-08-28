Facter.add(:cfssl_version) do
  # Restringe la ejecución a sistemas Linux
  confine :kernel => 'Linux'

  setcode do
    # Verifica si el binario existe en la ruta habitual o en el PATH
    cfssl_path = Facter::Core::Execution.which('cfssl') || '/usr/local/bin/cfssl'

    if File.executable?(cfssl_path)
      # Ejecuta el binario y captura stdout descartando errores
      output = Facter::Core::Execution.execute("#{cfssl_path} version 2>/dev/null")

      # Extrae la versión limpia (ej. "1.6.4") usando Expresiones Regulares
      match = output.match(/Version:\s+([0-9\.]+)/)
      match ? match[1] : nil
    else
      # Si no está instalado, retorna nil (Puppet lo interpretará como undef)
      nil
    end
  end
end
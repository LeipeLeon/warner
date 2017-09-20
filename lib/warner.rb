require_relative "warner/version"

class Warner

  def self.colored_warning(message)
    warn "\e[41;37;1m#{message}\e[0m"
  end

  def self.rails_version_warning(version, message)
    if Object.const_defined?('Rails')
      if Gem::Version.new(Rails.version) > Gem::Version.new(version)
        colored_warning "[RAILS] %s > %s : %s" % [Rails.version, version, message]
      end
    else
      raise "Rails not loaded"
    end
  end

  def self.gem_version_warning(gem_name, version, message)
    if Gem.loaded_specs[gem_name].version > Gem::Version.new(version)
      colored_warning "[%s] %s > %s : %s" % [gem_name.upcase, Gem.loaded_specs[gem_name].version, version, message]
    end
  end

end

require_relative "warner/version"

class Warner

  def self.colored_warning(message, callstack = nil)
    if Object.const_defined?('ActiveSupport')
      ActiveSupport::Deprecation.warn message, callstack
    else
      warn "\e[41;37;1m[DEPRECATION WARNING]: #{message}\e[0m"
    end
  end

  def self.rails_version_warning(version, message)
    if Object.const_defined?('Rails')
      if Gem::Version.new(Rails.version) > Gem::Version.new(version)
        colored_warning "[RAILS] %s > %s : %s" % [Rails.version, version, message], caller
      end
    else
      raise "Rails not loaded"
    end
  end

  def self.gem_version_warning(gem_name, version, message)
    if Gem.loaded_specs[gem_name].version > Gem::Version.new(version)
      colored_warning "[gem:%s] %s > %s : %s" % [gem_name, Gem.loaded_specs[gem_name].version, version, message], caller
    end
  end

end

require "set"
require "yaml"

require "safe_yaml/tag_verifier"
require "safe_yaml/version"
require "safe_yaml/whitelist"

module SafeYAML
  MULTI_ARGUMENT_YAML_LOAD = YAML.method(:load).arity != 1
  YAML_ENGINE = defined?(YAML::ENGINE) ? YAML::ENGINE.yamler : "syck"

  OPTIONS = {
    :enable_symbol_parsing => false,
    :enable_arbitrary_object_deserialization => false,
    :suppress_warnings => false
  }

  class UnsafeTagError < RuntimeError; end
end

module YAML
  def self.load_with_options(yaml, *filename_and_options)
    options   = filename_and_options.last || {}
    safe_mode = safe_mode_from_options("load", options)
    arguments = [yaml]
    arguments << filename_and_options.first if SafeYAML::MULTI_ARGUMENT_YAML_LOAD
    safe_mode ? safe_load(*arguments) : unsafe_load(*arguments)
  end

  def self.load_file_with_options(file, options={})
    safe_mode = safe_mode_from_options("load_file", options)
    safe_mode ? safe_load_file(file) : unsafe_load_file(file)
  end

  def self.read_for_safe_load(yaml)
    # since we're going to do two passes, we need to read out the file here
    # into a string
    if yaml.respond_to?(:read)
      yaml = yaml.read
    end
    yaml
  end

  if SafeYAML::YAML_ENGINE == "psych"
    require "safe_yaml/psych_tag_verifier"
    def self.safe_load(yaml, filename=nil)
      yaml = read_for_safe_load(yaml)
      verifier = SafeYAML::PsychTagVerifier.new(whitelist)
      parser = Psych::Parser.new(verifier)
      if SafeYAML::MULTI_ARGUMENT_YAML_LOAD
        parser.parse(yaml, filename)
      else
        parser.parse(yaml)
      end
      return unsafe_load(yaml)
    end

    def self.safe_load_file(filename)
      File.open(filename, 'r:bom|utf-8') { |f| self.safe_load f, filename }
    end

    def self.unsafe_load_file(filename)
      if SafeYAML::MULTI_ARGUMENT_YAML_LOAD
        # https://github.com/tenderlove/psych/blob/v1.3.2/lib/psych.rb#L296-298
        File.open(filename, 'r:bom|utf-8') { |f| self.unsafe_load f, filename }
      else
        # https://github.com/tenderlove/psych/blob/v1.2.2/lib/psych.rb#L231-233
        self.unsafe_load File.open(filename)
      end
    end

  else
    require "safe_yaml/syck_tag_verifier"
    def self.safe_load(yaml)
      yaml = read_for_safe_load(yaml)
      tree = YAML.parse(yaml)
      verifier = SafeYAML::SyckTagVerifier.new(whitelist)
      verifier.verify(tree)
      return unsafe_load(yaml)
    end

    def self.safe_load_file(filename)
      File.open(filename) { |f| self.safe_load f }
    end

    def self.unsafe_load_file(filename)
      # https://github.com/indeyets/syck/blob/master/ext/ruby/lib/yaml.rb#L133-135
      File.open(filename) { |f| self.unsafe_load f }
    end
  end

  class << self
    alias_method :unsafe_load, :load
    alias_method :load, :load_with_options
    alias_method :load_file, :load_file_with_options

    def enable_symbol_parsing?
      SafeYAML::OPTIONS[:enable_symbol_parsing]
    end

    def enable_symbol_parsing!
      SafeYAML::OPTIONS[:enable_symbol_parsing] = true
    end

    def disable_symbol_parsing!
      SafeYAML::OPTIONS[:enable_symbol_parsing] = false
    end

    def enable_arbitrary_object_deserialization?
      SafeYAML::OPTIONS[:enable_arbitrary_object_deserialization]
    end

    def enable_arbitrary_object_deserialization!
      SafeYAML::OPTIONS[:enable_arbitrary_object_deserialization] = true
    end

    def disable_arbitrary_object_deserialization!
      SafeYAML::OPTIONS[:enable_arbitrary_object_deserialization] = false
    end

    def whitelist
      @whitelist ||= SafeYAML::Whitelist.new
    end

    SYMBOL_REGEX = /\A:\w+\Z/.freeze
    def check_string_for_symbol!(string)
      if !YAML.enable_symbol_parsing? && string.match(SYMBOL_REGEX)
        raise SafeYAML::UnsafeTagError.new("Symbol parsing is disabled")
      end
    end

    private
    def safe_mode_from_options(method, options={})
      safe_mode = options[:safe]

      if safe_mode.nil?
        mode = SafeYAML::OPTIONS[:enable_arbitrary_object_deserialization] ? "unsafe" : "safe"
        Kernel.warn "Called '#{method}' without the :safe option -- defaulting to #{mode} mode." unless SafeYAML::OPTIONS[:suppress_warnings]
        safe_mode = !SafeYAML::OPTIONS[:enable_arbitrary_object_deserialization]
      end

      safe_mode
    end
  end
end

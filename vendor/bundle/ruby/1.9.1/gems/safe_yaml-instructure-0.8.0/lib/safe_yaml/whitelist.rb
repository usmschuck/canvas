module SafeYAML
  class Whitelist
    attr_reader :allowed

    def initialize
      reset!
    end

    def check(tag, value)
      @allowed.each do |ok, checker|
        if ok === tag
          check = check_value(ok, checker, value)
          return check if check
        end
      end
      nil
    end

    def check_value(tag, checker, value)
      if checker == true
        return :cacheable
      end

      if @cached[tag][value]
        return :cacheable
      end

      result = checker.call(value)
      if result == :cacheable
        @cached[tag][value] = true
        return :cacheable
      elsif result
        return :allowed
      else
        return nil
      end
    end

    def reset!
      @allowed = {}
      @cached = {}
      if SafeYAML::YAML_ENGINE == "psych"
        # psych doesn't tag the default types, except for binary
        add("!binary",
            "tag:yaml.org,2002:binary")
      else
        add("tag:yaml.org,2002:str",
            "tag:yaml.org,2002:int",
            "tag:yaml.org,2002:float",
            "tag:yaml.org,2002:binary",
            "tag:yaml.org,2002:merge",
            "tag:yaml.org,2002:null",
            %r{^tag:yaml.org,2002:bool#},
            %r{^tag:yaml.org,2002:float#},
            %r{^tag:yaml.org,2002:timestamp#},
            "tag:ruby.yaml.org,2002:object:YAML::Syck::BadAlias")
      end
    end

    def add(*tags, &block)
      tags.each do |tag|
        @cached[tag] = {} if block
        @allowed[tag] = block || true
      end
    end

    def remove(*tags)
      tags.each do |tag|
        @cached.delete(tag)
        @allowed.delete(tag)
      end
    end
  end
end

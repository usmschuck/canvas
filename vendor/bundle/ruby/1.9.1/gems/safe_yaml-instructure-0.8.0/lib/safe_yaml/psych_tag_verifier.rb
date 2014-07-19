module SafeYAML
  class PsychTagVerifier < Psych::Handler
    attr_reader :tags

    def initialize(whitelist)
      @tags = Set.new
      @verifier = SafeYAML::TagVerifier.new(whitelist)
    end

    def streaming?
      false
    end

    def alias(anchor)
    end

    def scalar(value, anchor, tag, plain, quoted, style)
      if !quoted && value.is_a?(String)
        YAML.check_string_for_symbol!(value)
      end
      @verifier.verify_tag!(tag, value)
    end

    def start_mapping(anchor, tag, implicit, style)
      @verifier.verify_tag!(tag, nil)
    end

    def end_mapping
    end

    def start_sequence(anchor, tag, implicit, style)
      @verifier.verify_tag!(tag, nil)
    end

    def end_sequence
    end
  end
end

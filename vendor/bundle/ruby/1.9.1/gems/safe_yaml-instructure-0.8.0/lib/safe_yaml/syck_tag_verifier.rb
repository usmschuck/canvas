module SafeYAML
  class SyckTagVerifier
    QUOTE_STYLES = [:quote1, :quote2]

    attr_reader :tags

    def initialize(whitelist)
      @tags = Set.new
      @verifier = SafeYAML::TagVerifier.new(whitelist)
    end

    def verify(node)
      return unless node.respond_to?(:type_id)
      if !QUOTE_STYLES.include?(node.instance_variable_get(:@style)) && node.value.is_a?(String)
        YAML.check_string_for_symbol!(node.value)
      end
      @verifier.verify_tag!(node.type_id, node.value)

      case node.value
      when Hash
        node.value.each { |k,v| verify(k); verify(v) }
      when Array
        node.value.each { |i| verify(i) }
      end
    end
  end
end

require 'set'

module SafeYAML
  class TagVerifier
    def initialize(whitelist)
      @whitelist = whitelist
      @seen = Set.new
    end

    def verify_tag!(tag, value)
      return if !tag || @seen.include?(tag)

      case @whitelist.check(tag, value)
      when :cacheable
        @seen << tag
      when :allowed
        # in the whitelist, but can't be cached (because it called a proc for yes/no)
      else
        raise SafeYAML::UnsafeTagError.new("YAML tag is not whitelisted: #{tag} #{value.inspect}")
      end
    end
  end
end

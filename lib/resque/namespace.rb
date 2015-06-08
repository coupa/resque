require 'redis/namespace'

class Redis
  class Namespace
    # Monkey-patch to allow keys starting with ':' to be treated as is
    def add_namespace(key)
      return key unless key && @namespace
      return key[1..-1] if key[0] == ':'

      case key
      when Array
        key.map {|k| add_namespace k}
      when Hash
        Hash[*key.map {|k, v| [ add_namespace(k), v ]}.flatten]
      else
        "#{@namespace}:#{key}"
      end
    end
  end
end
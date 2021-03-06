module Merb::Template

  class Haml
    def self.compile_template(path, name, mod)
      path = File.expand_path(path)
      config = (Merb::Plugins.config[:haml] || {}).inject({}) do |c, (k, v)|
        c[k.to_sym] = v
        c
      end.merge :filename => path
      template = ::Haml::Engine.new(File.read(path), config)
      template.def_method(mod, name)
      name    
    end
  
    module Mixin    
      def _haml_buffer( binding )
        @_buffer = eval( "buffer.buffer", binding )
      end
      
      def _concat_haml(string, binding)
        _haml_buffer << string
      end
      
    end
    Merb::Template.register_extensions(self, %w[haml])  
  end
end

module Haml
  class Engine

    def def_method(object, name, *local_names)
      method = object.is_a?(Module) ? :module_eval : :instance_eval

      setup = "@_engine = 'haml'"

      object.send(method, "def #{name}(_haml_locals = {}); #{setup}; #{precompiled_with_ambles(local_names)}; end",
                  @options[:filename], 0)
    end
 
  end
end
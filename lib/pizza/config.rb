require 'yaml'

module Pizza
  class Config
    class << self
      
      def load_from_file(file_path)
        config = YAML::load_file(file_path)
        
        config.each do |bank, params|
          params.each do |param, value|
            begin
              self.send(:"#{bank}_#{param}=", value)
            rescue NoMethodError; end
          end
        end
      end
      
      def configure
        yield self
      end
      
      def method_missing(m, *args)
        if /^(swedbank|seb|sampo|nordea)_(.*)=$/ =~ m.to_s
          clz = Pizza::Provider.const_get($1.capitalize)
          if clz.respond_to?(:"#{$2}=")
            return clz.send(:"#{$2}=", *args)
          end
        end

        super
      end
    end
  end
end
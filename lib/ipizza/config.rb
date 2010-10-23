require 'yaml'

module Ipizza
  class Config
    class << self

      def load_from_file(yaml_path)
        config = YAML::load_file(yaml_path)
        
        config.each do |bank, params|
          params.each do |param, value|
            value = normalize_file_location(yaml_path, value) if /^file_(cert|key)/ =~ param
            
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
          clz = Ipizza::Provider.const_get($1.capitalize)
          if clz.respond_to?(:"#{$2}=")
            return clz.send(:"#{$2}=", *args)
          end
        end

        super
      end
      
      private
      
      def normalize_file_location(yaml_path, file_path)
        if File.exists?(file_path)
          file_path
        else
          file_path = File.expand_path(File.join(File.dirname(yaml_path), file_path))
        end
        
        if File.exists?(file_path)
          file_path
        else
          raise "Could not load certificate from file '#{file_path}'"
        end
      end
      
    end
  end
end

require 'yaml'

module Ipizza
  class Config
    class << self

      attr_accessor :certs_root

      def load_from_file(yaml_path)
        @certs_root = File.dirname(yaml_path)
        
        load_from_hash(YAML::load_file(yaml_path))
      end
      
      def load_from_hash(config)
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
        if /^(lhv|swedbank|seb|sampo|krediidipank|nordea)_(.*)=$/ =~ m.to_s
          clz = Ipizza::Provider.const_get($1.capitalize)
          key = $2
          value = args.first
          
          value = load_certificate(value) if /^file_(cert|key)/ =~ key
          
          if clz.respond_to?(:"#{key}=")
            return clz.send(:"#{key}=", *[value])
          end
        end

        super
      end
      
      private
      
      def load_certificate(file_path)
        if File.exist?(file_path)
          file_path
        else
          file_path = File.expand_path(File.join(certs_root, file_path))
        end
        
        if File.exist?(file_path)
          file_path
        else
          raise "Could not load certificate from file '#{file_path}'"
        end
      end
      
    end
  end
end

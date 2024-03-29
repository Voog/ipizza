require 'base64'
require 'openssl'

module Ipizza
  class Util

    DEFAULT_HASH_ALGORITHM = 'sha1'

    class << self

      def verify_signature(certificate_path, signature, data, hash_algorithm = DEFAULT_HASH_ALGORITHM)
        if !certificate_path.to_s.empty? && !signature.to_s.empty? && File.file?(certificate_path)
          certificate = OpenSSL::X509::Certificate.new(File.read(certificate_path).gsub(/  /, '')).public_key
          certificate.verify(
            digest_class(hash_algorithm).new,
            Base64.decode64(signature),
            data
          )
        else
          false
        end
      end

      def sign(privkey_path, privkey_secret, data, hash_algorithm = DEFAULT_HASH_ALGORITHM)
        privkey = File.open(privkey_path, 'r') { |f| f.read }
        privkey = OpenSSL::PKey::RSA.new(privkey.gsub(/  /, ''), privkey_secret)

        signature = privkey.sign(
          digest_class(hash_algorithm).new,
          data
        )
        Base64.encode64(signature).gsub(/\n/, '')
      end

      # Calculates and adds control number using 7-3-1 algoritm for Estonian banking account and reference numbers.
      def sign_731(ref_num)
        arr = ref_num.to_s.reverse.split('')
        m = 0
        r = 0

        arr.each do |e|
          m = case m
          when 7
            3
          when 3
            1
          else
            7
          end
          r = r + (e.to_i * m)
        end
        c = ((r + 9) / 10).to_f.truncate * 10 - r
        arr.reverse! << c
        arr.join
      end

      # Produces string to be signed out of service message parameters.
      #
      #   p(x1)||x1||p(x2)||x2||...||p(xn)||xn
      #
      # Where || is string concatenation, p(x) is length of the (stripped) field x represented by three digits.
      #
      # Parameters val1, val2, value3 would be turned into "003val1003val2006value3".
      def mac_data_string(params, sign_param_order)
        (sign_param_order || []).inject('') do |memo, param|
          val = params[param].to_s.strip
          memo << func_p(val) << val
          memo
        end
      end

      def time_to_iso8601(time)
        time.strftime('%Y-%m-%dT%H:%M:%S%z')
      end

      private

      # p(x) is length of the field x represented by three digits. When request encoding is in UTF-8 then characters count is calculated otherwise characters byte size is used.
      def func_p(val)
        if RUBY_VERSION < '1.9' || val.encoding.name == 'UTF-8'
          sprintf('%03i', val.size)
        else
          sprintf('%03i', val.bytesize)
        end
      end

      def digest_class(hash_algorithm)
        algorithm = (hash_algorithm || '').upcase

        if OpenSSL::Digest.const_defined?(algorithm)
          OpenSSL::Digest.const_get(algorithm)
        else
          raise ArgumentError, "Unknown hash algorithm OpenSSL::Digest::#{algorithm}"
        end
      end
    end
  end
end

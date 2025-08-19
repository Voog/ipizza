Implements iPizza protocol to communicate with Estonian Banks.

Gem implements support for iPizza services (`1011`, `1012`, `4011` and `4012`) that are supported by members of the Estonian Banking Association [since October 2014](https://pangaliit.ee/arveldused/pangalingi-spetsifikatsioon).

If you need to use this gem with old iPizza services implementations (`1001`, `1002`, `4001` and `4002`), use 1.0.0 version of this gem (NB! support for these services will end on 31 December 2015).

# Usage

Add gem dependency in your `Gemfile` and install the gem:

    gem 'ipizza'

## Ruby 1.8 support

Since ipizza gem version 1.0.0, Ruby 1.8 support has been dropped. If you need to use this gem with older versions of Ruby, use 0.7.1 version of this gem.

# Configuration

Configuration can be made in two different ways, using `Ipizza::Config.configure` block or loading configuration properties from YAML file.

Loading from YAML file:

    Ipizza::Config.load_from_file('config.yml')

Configuration values should be set in YAML file in **provider.attribute_value** format. See example YAML file below in "Configuration parameters" section.

At any time, configuration can be modified with `Ipizza::Config.configure` block:

    Ipizza::Config.configure do |c|
      c.certs_root            = '/path/to/certificates'
      c.swedbank_service_url  = 'http://foo.bar/swedbank'
    end

## Configuration parameters

    swedbank:
      service_url: http://foo.bar/swedbank
      return_url: http://mycompany.com/store
      cancel_url: http://mycompany.com/cancel

      # Your private key file path. Can be specified relatively
      # to YAML file
      file_key: ./certificates/my_private.key

      # If your private key is protected with password,
      # provide it here
      key_secret: private_key_password

      # Path to bank's public key file. Can be specified
      # relatively to YAML file
      file_cert: ./certificates/bank_public.crt
      login: dealer
      snd_id: dealer
      encoding: UTF-8
      sign_algorithm: sha256 # default is sha1
      verification_algorithm: sha256 # default is sha1
      vk_version: "009" # VK_VERSION. Default is "008"

## Payment requests

### Building request

    payment = Ipizza::Payment.new(
      :stamp => 1, :amount => '123.34', :refnum => 1,
      :message => 'Payment message', :currency => 'EUR'
    )
    request = Ipizza::Provider::Swedbank.new.payment_request(@payment)

## Authentication requests

### Building request

    request = Ipizza::Provider::Swedbank.new.authentication_request

### Validating response

    response = Ipizza::Provider::Swedbank.new.authentication_response({'VK_PARAM_1' => 'VALUE 1', ...})
    response.valid?

# Gateway specifications

This library currently works with four Estonian Banks. Here are their respective interface specifications:

* [Swedbank](https://www.swedbank.ee/business/cash/ecommerce/support)
* [SEB](https://www.seb.ee/en/business/daily-banking/bank-link)
* [LHV Bank](https://partners.lhv.ee/en/banklink)

# Helpful links

* [pangalink.net](https://pangalink.net/et/info)
* [Repository](https://github.com/Voog/ipizza)
* [Issue tracker](https://github.com/Voog/ipizza/issues)

# Authors

* Thanks to [all contributors](https://github.com/Voog/ipizza/graphs/contributors)!
* Tarmo Talu (Thanks for the 7-3-1 algorithm)

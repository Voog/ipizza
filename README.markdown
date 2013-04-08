Implements iPizza protocol to communicate with Estonian Banks.

# Usage

Add gem dependency in your `Gemfile` and install the gem:

    gem 'ipizza'

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
      snd_id: dealer
      encoding: ISO-8859-4

Please note that currently only ISO-8859-4 encoding is supported with Swedbank. UTF-8 works well with other payment providers.

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

* [Swedbank](https://www.swedbank.ee/static/pdf/business/d2d/paymentcollection/info_banklink_techspec_est.pdf)
* [SEB](http://www.seb.ee/ari/maksete-kogumine/maksete-kogumine-internetis/tehniline-spetsifikatsioon)
* [Sampo](http://www.sampopank.ee/et/14732.html)
* [Krediidipank](http://www.krediidipank.ee/business/settlements/bank-link/tehniline_kirjeldus.pdf)
* [Nordea](http://www.nordea.ee/Teenused+ärikliendile/E-lahendused/787802.html)

# Helpful links

* [Repository](http://github.com/priithaamer/ipizza)
* [Issue tracker](http://github.com/priithaamer/ipizza/issues)

# Authors

* Thanks to [all contributors](https://github.com/priithaamer/ipizza/graphs/contributors)!
* Tarmo Talu (Thanks for the 7-3-1 algorithm)

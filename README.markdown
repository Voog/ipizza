Implements iPizza protocol to communicate with Estonian Banks

Usage
=====

Add gem dependency in your `Gemfile` and install the gem:

    gem 'ipizza', :git => 'git://github.com/priithaamer/ipizza.git'

Building payment request
------------------------

    payment = Ipizza::Payment.new(:stamp => 1, :amount => '123.34', :refnum => 1, :message => 'Payment message', :currency => 'EUR')
    request = Ipizza::Provider::Swedbank.new.payment_request(@payment)

Gateway specifications
======================

This library currently works with four Estonian Banks. Here are their respective interface specifications:

* [Swedbank](https://www.swedbank.ee/static/pdf/business/d2d/paymentcollection/info_banklink_techspec_est.pdf)
* [SEB](http://www.seb.ee/index/1302)
* [Sampo](http://www.sampopank.ee/et/14732.html)
* [Nordea](http://www.nordea.ee/Teenused+ärikliendile/E-lahendused/787802.html)

Helpful links
=============

* [Repository](http://github.com/priith/ipizza/tree/master)
* [Issue tracker](http://github.com/priith/ipizza/issues)

Todo
====

* Add usage examples
* Proper Rails initialization
* Write Rails controller and model generator
* Implement authorization services
* Rails helper to generate iPizza request forms
* Raise reasonable exception during configuration when certificates or keys cannot be loaded

Authors
=======

* Priit Haamer
* Tarmo Talu (Thanks for the 7-3-1 algorithm)
* *Add yourself here*
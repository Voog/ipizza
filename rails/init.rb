require 'pizza'

config = YAML::load_file(RAILS_ROOT + '/config/ipizza.yml')

if config[RAILS_ENV]
  config = config[RAILS_ENV]
  
  if config['seb']
    seb = config['seb']
    Pizza::Provider::SEB.service_url = seb['service_url']
    Pizza::Provider::SEB.return_url = seb['return_url']
    Pizza::Provider::SEB.cancel_url = seb['cancel_url']
    Pizza::Provider::SEB.key = seb['key']
    Pizza::Provider::SEB.key_secret = seb['key_secret']
    Pizza::Provider::SEB.cert = seb['cert']
    Pizza::Provider::SEB.snd_id = seb['login']
    Pizza::Provider::SEB.rec_acc = seb['rec_acc']
    Pizza::Provider::SEB.rec_name = seb['rec_name']
    Pizza::Provider::SEB.encoding = 'UTF-8'
  end
  
  if config['swedbank']
    swedbank = config['swedbank']
    Pizza::Provider::Swedbank.service_url = swedbank['service_url']
    Pizza::Provider::Swedbank.return_url = swedbank['return_url']
    Pizza::Provider::Swedbank.cancel_url = swedbank['cancel_url']
    Pizza::Provider::Swedbank.key = swedbank['key']
    Pizza::Provider::Swedbank.key_secret = swedbank['key_secret']
    Pizza::Provider::Swedbank.cert = swedbank['cert']
    Pizza::Provider::Swedbank.snd_id = swedbank['login']
    Pizza::Provider::Swedbank.encoding = 'ISO-8859-4'
  end
  
  if config['sampo']
    sampo = config['sampo']
    Pizza::Provider::Sampo.service_url = sampo['service_url']
    Pizza::Provider::Sampo.return_url = sampo['return_url']
    Pizza::Provider::Sampo.key = sampo['key']
    Pizza::Provider::Sampo.key_secret = sampo['key_secret']
    Pizza::Provider::Sampo.cert = sampo['cert']
    Pizza::Provider::Sampo.snd_id = sampo['login']
    Pizza::Provider::Sampo.lang = sampo['lang']
    Pizza::Provider::Sampo.rec_acc = sampo['rec_acc']
    Pizza::Provider::Sampo.rec_name = sampo['rec_name']
  end
  
  if config['nordea']
    nordea = config['nordea']
    Pizza::Provider::Nordea.service_url = nordea['service_url']
    Pizza::Provider::Nordea.return_url = nordea['return_url']
    Pizza::Provider::Nordea.reject_url = nordea['reject_url']
    Pizza::Provider::Nordea.cancel_url = nordea['cancel_url']
    Pizza::Provider::Nordea.key = nordea['key']
    Pizza::Provider::Nordea.rcv_id = nordea['rcv_id']
    Pizza::Provider::Nordea.language = nordea['language']
    Pizza::Provider::Nordea.confirm = nordea['confirm']
    Pizza::Provider::Nordea.keyvers = nordea['keyvers']
  end
end

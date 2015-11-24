require_relative '../lib/bcapiruby'
require_relative '../spec/helpers/example_helper'

BCAPIRuby::Requestor.credentials ({
    sellerId: <seller_id>,
    privateKey: <private_key>,
    sandbox: true
})

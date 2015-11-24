module Twocheckout

  class Address

    attr_reader :state, :name, :country, :postal_code, :address_1, :address_2, :country_code, :city

    def initialize(hash)
      @name = hash['name']
      @address_1 = hash['address_1']
      @address_2 = hash['address_2']
      @city = hash['city']
      @state = hash['state']
      @country = hash['country']
      @country_code = hash['country_code']
      @postal_code = hash['postal_code']
    end
    
  end

end
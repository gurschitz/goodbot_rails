##
# This controller takes care of retrieving and rendering a single shop to the view.

class ShopsController < ApplicationController
  before_action :set_shop, only: [:show]

  ##
  # GET /shops/1
  #
  # We need to define this method, because we use it as action,
  # even though nothing happen sin the method
  def show
  end


  ##
  # GET /shops/test
  #
  # A test route that doesn't involve fetching the shop before but rather
  # uses a hardcoded one
  def test
    @shop = {
      "id"=>41,
      "name"=>"Theehandel Schönbichler",
      "country_code"=>"AT",
      "geo_lat"=>"48.208942",
      "geo_lng"=>"16.374571",
      "city"=>"Wien",
      "postcode"=>"1010",
      "address"=>"Wollzeile 4",
      "website"=>"http://www.schoenbichler.at",
      "phone"=>nil,
      "discount_de"=>nil,
      "discount_en"=>nil,
      "description_de"=>nil,
      "description_en"=>nil,
      "category"=>"3",
      "opening_hours_de"=>"Mo. – Fr.: 09:00 - 18:30 Uhr,\\n Sa.: 09:00 - 17:00 Uhr,\\n So.: geschlossen",
      "opening_hours_en"=>"Mon - Fri: 09:00 - 18:30 \\n Sat: 09:00 - 17:00,\\n Sun: closed",
      "facebook"=>"https://www.facebook.com/theehandlung.schoenbichler",
      "twitter"=>nil,
      "instagram"=>nil,
      "snapchat"=>nil,
      "sponsored_trees_amount"=>15,
      "logo_url"=>{
        "url"=>"https://www.goodbag.io/uploads/logos/71/logo.png",
        "icon"=>{
          "url"=>"https://www.goodbag.io/uploads/logos/71/icon_logo.png"
        }
      },
      "is_visible"=>true,
      "country"=>"Österreich",
      "t_updated"=>"2017-11-25T15:42:31Z"
    }
    render 'shops/show'
  end

  private

  ##
  # We use the private method set_shop to retrieve the shop via the Goodbag api
  # This method is actually generated when using the rails scaffold generator
  # and can be reused for other actions later, i.e. when editing a shop
  def set_shop
    @shop = Goodbot::Apis::Goodbag::Branches.get_one(params[:id])
  end
end

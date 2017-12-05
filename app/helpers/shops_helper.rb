##
# This view helper defines simple extraction logic
# In such a helper, usually one can find more complex logic

module ShopsHelper

  ##
  # Extracting the name of the shop
  def name
    @shop.dig('name')
  end

  ##
  # Extracting the url of the logo_url of the shop
  def logo_url
    @shop.dig('logo_url','url')
  end

  ##
  # Extracting the discount of the shop in german language.
  def discount
    @shop.dig('discount_de')
  end
end

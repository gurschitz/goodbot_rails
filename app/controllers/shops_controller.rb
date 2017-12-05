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

  private

  ##
  # We use the private method set_shop to retrieve the shop via the Goodbag api
  # This method is actually generated when using the rails scaffold generator
  # and can be reused for other actions later, i.e. when editing a shop
  def set_shop
    @shop = Goodbot::Apis::Goodbag::Branches.get_one(params[:id])
  end
end

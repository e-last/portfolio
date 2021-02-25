class Public::SearchController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @value = params["search"]["value"]
    @users = User.where("name LIKE ?", "%#{@value}%")
  end
end

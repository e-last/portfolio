class Public::SearchController < ApplicationController
  def search
    value = params["search"]["value"]
    @users = User.where("name LIKE ?", "%#{value}%")
  end
end

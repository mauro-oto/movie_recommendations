class HomeController < ApplicationController
  def index
    redirect_to recommendations_path if current_user
  end
end

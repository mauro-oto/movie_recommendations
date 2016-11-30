class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_ratings!

  def ratings
    @ratings = current_user.ratings.reverse
  end
end

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home
    @dogs = Dog.all.order('created_at DESC').limit(6)
  end

  def about
  end

end

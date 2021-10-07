class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home
    @dogs = Dog.all.where.not(user: current_user).order('created_at DESC').limit(6)
  end

  def about
  end

end

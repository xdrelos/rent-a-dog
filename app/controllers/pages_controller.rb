class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home
    @dogs = Dog.all.where.not(user: current_user).order('created_at DESC').limit(6)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def about
  end

end

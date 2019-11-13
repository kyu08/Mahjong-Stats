class HomeController < ApplicationController
  def top
    if @current_user
      redirect_to("/date/input")
    end
  end

  def about
  end
end

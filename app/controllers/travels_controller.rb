class TravelsController < ApplicationController

  def index
    @travels = Travel.all
  end

end

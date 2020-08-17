class PagesController < ApplicationController
  skip_before_action :authenticate_user!, raise: false, only: :home

  def home
  end
end

class StaticPagesController < ApplicationController

  def index
  end

  def route_not_found
    render 'static_pages/route_not_found', status: :not_found
  end

end

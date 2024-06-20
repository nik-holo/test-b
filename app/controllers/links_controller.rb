class LinksController < ApplicationController
  before_action :set_link, only: [:show]

  # POST /links
  def create
    @link = Link.new(link_params)
    @link.code = SecureRandom.hex(5)
    @link.counter = 0

    if @link.save
      render json: { code: @link.code, redirect_url: @link.redirect_url }, status: :created
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  # GET /links/:id
  def show
    @link.increment!(:counter)
    redirect_to @link.redirect_url, allow_other_host: true
  end

  private

  def set_link
    code = params[:id]

    @link = Rails.cache.fetch(code, expires_in: 1.hour) do  
      Link.find_by(code:)
    end
  end

  def link_params
    params.require(:link).permit(:redirect_url)
  end
end

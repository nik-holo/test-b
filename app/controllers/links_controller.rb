# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :set_link, only: %i[show redirect]

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
    render json: { tracking_code: @link.code, store_url: @link.redirect_url, visit_count: stats_for_code }
  end

  # GET /linbks/:id/redirect/
  def redirect
    # i've had an inspiration to overengineer something :)
    # for simplicity of local dev setup sirvice is disabled inside
    ::StatsService.save_hit(@code, request.user_agent + request.ip)

    redirect_to @link.redirect_url, allow_other_host: true
  end

  private

  def stats_for_code
    ::StatsService.stats_for_code(@code)
  end

  def set_link
    @code = params[:id]

    @link = Rails.cache.fetch(@code, expires_in: 1.hour) do
      Link.find_by(code: @code)
    end
  end

  def link_params
    params.require(:link).permit(:redirect_url)
  end
end

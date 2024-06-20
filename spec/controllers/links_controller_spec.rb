# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Link and returns the tracking code and store URL' do
        post :create, params: { link: { redirect_url: 'http://example.com/discount' } }
        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response['new_link']).to eq("http://localhost:3000/links/#{Link.last.code}/redirect")
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Link and returns errors' do
        post :create, params: { link: { redirect_url: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('redirect_url')
      end
    end
  end

  describe 'GET #show' do
    let!(:link) { ::FactoryBot.create(:link) }

    it 'returns the tracking link data' do
      get :show, params: { id: link.code }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['tracking_code']).to eq(link.code)
      expect(json_response['store_url']).to eq(link.redirect_url)
      expect(json_response['visit_count']).to eq(::StatsService.stats_for_code(link.code))
    end
  end

  describe 'GET #redirect' do
    let!(:link) { ::FactoryBot.create(:link) }

    it 'increments the visit count and redirects to the store URL' do
      expect do
        get :redirect, params: { id: link.code }
      end.to change { ::StatsService.stats_for_code(link.code) }.by(1)

      expect(response).to redirect_to(link.redirect_url)
    end
  end
end

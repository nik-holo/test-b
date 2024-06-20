# frozen_string_literal: true

# spec/factories/links.rb
FactoryBot.define do
  factory :link do
    code { SecureRandom.hex(5) }
    redirect_url { 'http://example.com/discount' }
  end
end

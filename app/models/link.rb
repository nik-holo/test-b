# frozen_string_literal: true

class Link < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :redirect_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
end

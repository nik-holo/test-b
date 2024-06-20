class Link < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :redirect_url, presence: true, format: { with: URI::regexp(%w[http https]) }
end

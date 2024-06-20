# frozen_string_literal: true

class AddLinksIndex < ActiveRecord::Migration[7.1]
  def change
    add_index :links, :code, unique: true
  end
end

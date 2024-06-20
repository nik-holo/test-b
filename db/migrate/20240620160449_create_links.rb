# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :code
      t.string :redirect_url
      t.integer :counter

      t.timestamps
    end
  end
end

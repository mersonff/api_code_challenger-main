# frozen_string_literal: true

class CreateHostnames < ActiveRecord::Migration[6.1]
  def change
    create_table :hostnames do |t|
      t.string :hostname

      t.timestamps
    end
  end
end

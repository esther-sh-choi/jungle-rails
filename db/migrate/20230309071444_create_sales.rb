class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :percent_off

      t.timestamps
    end
  end
end

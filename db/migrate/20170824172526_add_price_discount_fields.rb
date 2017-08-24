class AddPriceDiscountFields < ActiveRecord::Migration[5.1]
  def change
    add_column :prices, :discount_value_in_cents, :integer
    add_column :prices, :discount_datetime_start, :datetime
    add_column :prices, :discount_datetime_end, :datetime
  end
end

class Sale < ApplicationRecord
  belongs_to :account
  
  before_validation :set_sale_date

  private

  def set_sale_date
    # Assuming month and year are already set
    self.sale_date = Date.new(year, month, 1)
  end
end

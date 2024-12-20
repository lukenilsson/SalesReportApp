# app/models/account.rb
class Account < ApplicationRecord
  has_many :sales
  has_one :threshold

  # Monthly total for a given month and year
  def monthly_total(month, year)
    sales.where(month: month, year: year).sum(:quantity)
  end

  # Quarterly total for a given quarter and year
  def quarterly_total(quarter, year)
    # quarter ranges from 1 to 4
    start_month = (quarter - 1) * 3 + 1
    end_month = start_month + 2
    sales.where(year: year, month: start_month..end_month).sum(:quantity)
  end

  # Yearly total
  def yearly_total(year)
    sales.where(year: year).sum(:quantity)
  end

  # Average monthly purchase quantity
  def average_monthly
    # returns a hash of [year, month] => average
    grouped = sales.group(:year, :month).average(:quantity)
    # Or return a simplified hash keyed by Date for convenience
    grouped.transform_keys { |(y,m)| Date.new(y,m,1) }
  end

  def flagged?
    return false unless threshold
    total = sales.sum(:quantity)
    total > threshold.quantity_threshold
  end
  
end

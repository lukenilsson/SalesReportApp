# app/controllers/sales_controller.rb
require 'roo'

class SalesController < ApplicationController
  def upload
  end

  def process_upload
    file = params[:file]
    if file.nil?
      redirect_to root_path, alert: "Please select a file."
      return
    end

    # Assume current month/year for now or let user specify
    current_month = Date.today.month
    current_year = Date.today.year

    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    
    Rails.logger.info "Starting file processing for #{file.original_filename}"

    Sale.transaction do
      (2..spreadsheet.last_row).each do |i|
        row = spreadsheet.row(i)
        account_name = row[0]
        upc = row[1]
        item = row[2]
        quantity = row[3].to_i

        account = Account.find_or_create_by(name: account_name)
        Sale.create!(
          account: account,
          upc: upc,
          item: item,
          quantity: quantity,
          month: current_month,
          year: current_year
        )
        Rails.logger.info "Processed row #{i}: #{account_name}, #{upc}, #{item}, #{quantity}"
      end
    end

    Rails.logger.info "Completed file processing"
    redirect_to root_path, notice: "Data imported successfully"
  end
end

Rails.application.routes.draw do
  root 'sales#upload'
  post 'sales/process_upload', to: 'sales#process_upload', as: 'sales_process_upload'
end

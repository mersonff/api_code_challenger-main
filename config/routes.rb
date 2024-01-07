Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :dns_records, only: %i[create index]
    end
  end

  get 'dns_records', to: 'api/v1/dns_records#index'

  root to: 'api/v1/dns_records#index'
end

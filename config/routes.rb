Rails.application.routes.draw do
  devise_for :users
  
  # Solo necesitas resources :posts para generar todas las rutas RESTful
  resources :posts do
    resources :comments, only: [:create]
    resources :reactions, only: [:create]
  end

  # Ruta para el estado de salud de la aplicación
  get "up" => "rails/health#show", as: :rails_health_check

  # Renderizar archivos dinámicos de PWA
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Define la ruta raíz
  root "posts#index"
end
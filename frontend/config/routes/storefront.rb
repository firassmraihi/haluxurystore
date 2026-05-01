root to: 'home#index'

resources :products, only: [:index, :show]

resources :autocomplete_results, only: :index

resources :cart_line_items, only: :create

get '/locale/set', to: 'locale#set'
post '/locale/set', to: 'locale#set', as: :select_locale

# non-restful checkout stuff
patch '/checkout/update/:state', to: 'checkouts#update', as: :update_checkout
get '/checkout/:state', to: 'checkouts#edit', as: :checkout_state
get '/checkout', to: 'checkouts#edit', as: :checkout

get '/orders/:id/token/:token' => 'orders#show', as: :token_order

resources :orders, only: :show do
  resources :coupon_codes, only: :create
end

resource :cart, only: [:show, :update] do
  put 'empty'
end

# route globbing for pretty nested taxon and product paths
get '/t/*id', to: 'taxons#show', as: :nested_taxons

get '/unauthorized', to: 'home#unauthorized', as: :unauthorized
get '/cart_link', to: 'store#cart_link', as: :cart_link

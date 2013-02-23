LanguageMemo::Application.routes.draw do
  # resouce
  resources :memos do
    resources :documents, :only => [:index, :show, :create]
  end
  resources :tags, :only => [:index, :show, :new, :create] do
    resources :tag_relations, :only => [:create]
  end

  get 'login' => 'accounts#login'
  post 'login' => 'accounts#authenticate'

  root :to => 'accounts#login'
end

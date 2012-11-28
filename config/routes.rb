LanguageMemo::Application.routes.draw do
  resources :memos do
    resources :documents, :only => [:index, :show, :create]
  end

  root :to => 'welcome#index'
end

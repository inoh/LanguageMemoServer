LanguageMemo::Application.routes.draw do
  resources :memos do
    resources :documents, :only => [:index, :show, :create]
  end
  resources :tags, :only => [:index, :show, :new, :create] do
    resources :tag_relations, :only => [:create]
  end

  root :to => 'welcome#index'
end

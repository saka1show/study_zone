Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :admin, skip: [:passwords], controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }
  devise_for :learners, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  namespace :admin do
    get "/" => 'homes#top'
    get "/admin/unsubscribe" => 'admins#unsubscribe'
    patch "/admin/withdraw" => 'admins#withdraw'
    resources :admins, only: [:show, :edit, :update]
    resources :learners, only: [:index, :show, :edit, :update, :destroy]
    resources :points, only: [:index, :show, :edit, :update]
    resources :createdproblems, only: [:index, :show, :edit, :update, :destroy]
  end

  scope module: :public do
    get "/learners" => 'homes#top'
    get "/learners/unsubscribe" => 'learners#unsubscribe'
    patch "/learners/withdraw" => 'learners#withdraw'
    get "/createdproblems/all" => 'createdproblems#index_all'
    post "/solvedproblems/answer" => 'learners#answer'
    get "/solvedproblems/answer_check" => 'learners#answer_check'
    get "/solvedproblems/correct" => '/learners#correct'
    get "/solvedproblems/incorrect" => '/learners#incorrect'

    resources :learners, only: [:show, :edit, :update]
    resources :points, only: [:index, :show]
    resources :createdproblems, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :solvedproblems, only: [:new, :create, :index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

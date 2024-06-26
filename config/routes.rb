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
    resources :subjects, only: [:new, :create, :index, :edit, :update]
    resources :points, only: [:index]
    resources :created_problems, only: [:index, :show, :edit, :update, :destroy]
    resources :comments, only: [:destroy]
  end

  scope module: :public do
    get "/learners" => 'homes#top'
    get "/learners/unsubscribe" => 'learners#unsubscribe'
    patch "/learners/withdraw" => 'learners#withdraw'
    get "/created_problems/all" => 'created_problems#index_all'
    get "/solved_problems/answer" => 'solved_problems#answer'
    post "/solved_problems/answer" => 'solved_problems#answer'
    patch "/solved_problems/reanswer" => 'solved_problems#reanswer'
    post "/solved_problems/correct" => 'solved_problems#correct'
    patch "/solved_problems/re_correct" => 'solved_problems#re_correct'
    get "/solved_problems/correct_page" => 'solved_problems#correct_page'
    post "/solved_problems/incorrect" => 'solved_problems#incorrect'
    patch "/solved_problems/re_incorrect" => 'solved_problems#re_incorrect'
    get "/solved_problems/incorrect_page" => 'solved_problems#incorrect_page'
    get "/points/ranking" => 'points#ranking'

    resources :learners, only: [:show, :edit, :update]
    resources :points, only: [:index]
    resources :created_problems, only: [:new, :create, :index, :show, :edit, :update] do
      resource :favorites, only: [:create, :destroy]
    end
    resources :solved_problems, only: [:new, :index, :update]
    resources :comments, only: [:create, :index, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users,
             controllers: {
               confirmations: 'users/confirmations',
               registrations: 'users/registrations',
               sessions: 'users/sessions'
             },
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout'
             }

  root to: 'home#index'

  resources :transfers, only: %i[new create]
end

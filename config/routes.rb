Rails.application.routes.draw do
  #get 'touan/new'

  #Rails7でDeviseを導入される方へ
  #https://kobacchi.com/rails7-devise-responded-to-turbo/
  devise_for :users , controllers: {
    sessions: 'users/sessions'
  }


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  
  
  #post 'touans/test_save' => 'touans#test_save',      as: 'test_save_touan'
  get 'touans/index' => 'touans#index',                 as: 'index_touan' # IATF要求事項説明ページ
  #get 'touans/test' => 'touans#test',                 as: 'test_touan' # IATF要求事項説明ページ
  #get 'touans/new' => 'touans#new',                 as: 'new_touan' # IATF要求事項説明ページ
  
  #resources :touans

  
Rails.application.routes.draw do
  resources :touans, only: [:index, :new, :create]
  
end


  get 'products/iot' => 'products#iot',                   as: 'iot_product' # IATF要求事項説明ページ
  get 'products/graph' => 'products#graph',               as: 'graph_product'
  get 'products/calendar' => 'products#calendar',         as: 'calendar_product'
  get 'products/training' => 'products#training',         as: 'training_product'
  get 'products/index2' => 'products#index2',             as: 'index2_product'
  get 'products/index3' => 'products#index3',             as: 'index3_product' # 全Itemのステイタス一覧
  get 'products/index4' => 'products#index4',             as: 'index4_product' # IATF要求事項説明ページ
  get 'products/index8' => 'products#index8',             as: 'index8_product' # 製品の達成度
  get 'products/index9' => 'products#index9',             as: 'index9_product' # 全アイテムの日付一覧

  get 'products/xlsx' => 'products#xlsx',                 as: 'xlsx_product'
  get 'products/download' => 'products#download',         as: 'download_product'
  get 'products/process_design_download' => 'products#process_design_download', as: 'process_design_download'

  #post 'products/iot_import' => 'products#iot_import',     as: 'iot_import_product' # IATF要求事項説明ページ

  root to: 'products#index'
  #root to: 'users#sign_in'

  #【Ruby on Rails】CSVインポート
  #https://qiita.com/seitarooodayo/items/c9d6955a12ca0b1fd1d4

  resources :products do
    collection { post :import }
   end

  #resources :iots do
  #  collection { post :iot_import,:iot_import1,:test }
  #
  #end

  
end

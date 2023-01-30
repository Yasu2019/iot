Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'products/graph' => 'products#graph',               as: 'graph_product'
  get 'products/calendar' => 'products#calendar',         as: 'calendar_product'
  get 'products/video' => 'products#video',               as: 'video_product'
  get 'products/index2' => 'products#index2',             as: 'index2_product'
  get 'products/index3' => 'products#index3',             as: 'index3_product' # 全Itemのステイタス一覧
  get 'products/index4' => 'products#index4',             as: 'index4_product' # IATF要求事項説明ページ
  get 'products/index8' => 'products#index8',             as: 'index8_product' # 製品の達成度
  get 'products/index9' => 'products#index9',             as: 'index9_product' # 全アイテムの日付一覧

  get 'products/xlsx' => 'products#xlsx',                 as: 'xlsx_product'
  get 'products/download' => 'products#download',         as: 'download_product'
  get 'products/process_design_download' => 'products#process_design_download', as: 'process_design_download'

  

  root to: 'products#index'

  

  resources :products
  
end

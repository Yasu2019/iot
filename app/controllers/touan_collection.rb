class TouanCollection
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  USER_NUM = 2  # 同時にユーザーを作成する数
  attr_accessor :collection  # ここに作成したユーザーモデルが格納される

  # 初期化メソッド
  def initialize(attributes = [])
    if attributes.present?
      self.collection = attributes.map do |value|
        Touan.new(
          kaito: value['kaito'],
         
        )
      end
    else
      self.collection = USER_NUM.times.map{ Touan.new }
    end
  end

  # レコードが存在するか確認するメソッド
  def persisted?
    false
  end

  # 各Touanオブジェクトのsaveを呼び出す
  def save
    collection.all?(&:save)
  end
  
end
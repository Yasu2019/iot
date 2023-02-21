
class Product < ApplicationRecord
  has_many_attached :documents

 
  #【Ruby on Rails】CSVインポート
  #https://qiita.com/seitarooodayo/items/c9d6955a12ca0b1fd1d4

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
       # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      product = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      product.attributes = row.to_hash.slice(*updatable_attributes)
       # 保存する
       product.save
     end
   end
  
  # 更新を許可するカラムを定義
   def self.updatable_attributes
     ["id", "partnumber", "materialcode","documentname","description","category","phase","stage","start_time","deadline_at","end_at","goal_attainment_level","status"]
   end




 

end


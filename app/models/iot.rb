class Iot < ApplicationRecord
  require 'csv'

  def self.iot_import(file)
    #undefined method path for nil:NilClass　が解決できません
    #https://teratail.com/questions/224646
    unless file
       # CSVファイルからデータを読み込む
       CSV.foreach("/myapp/db/record/2023_02_18SHT31Temp.csv", headers: true) do |row|
       
        # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
        iot = find_by(id: row["id"]) || new
        # CSVからデータを取得し、設定する
        iot.attributes = row.to_hash.slice(*updatable_attributes1)
         # 保存する
         iot.save!(validate: false)
        end
     
     else
      CSV.foreach(file.path, headers: true) do |row|
        
        # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
       iot = find_by(id: row["id"]) || new
       # CSVからデータを取得し、設定する
       iot.attributes = row.to_hash.slice(*updatable_attributes1)
        # 保存する
        iot.save!(validate: false)

      end
     end
  end
  
  # 更新を許可するカラムを定義
   def self.updatable_attributes1
     ["id","date", "data"]
   end

#-----------------------------------------
def self.iot_import1(file)
  #undefined method path for nil:NilClass　が解決できません
  #https://teratail.com/questions/224646
  unless file
     # CSVファイルからデータを読み込む
     CSV.foreach("/myapp/db/record/2023_02_18SHT31Humi.csv", headers: true) do |row|
     
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      iot = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      iot.attributes = row.to_hash.slice(*updatable_attributes1)
       # 保存する
       iot.save!(validate: false)
      end
   
   else
    CSV.foreach(file.path, headers: true) do |row|
      
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
     iot = find_by(id: row["id"]) || new
     # CSVからデータを取得し、設定する
     iot.attributes = row.to_hash.slice(*updatable_attributes1)
      # 保存する
      iot.save!(validate: false)

    end
   end
end

  

end

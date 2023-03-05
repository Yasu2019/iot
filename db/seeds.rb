require "csv"

CSV.foreach('db/category.csv') do |row|
  Phase.create(:id => row[0], :name => row[1], :ancestry => row[2])
  
end

CSV.foreach('db/record/login.csv') do |row|
  User.create(:id => row[0], :email => row[1], :password => row[2], :name => row[3], :role => row[4])
end

#User.create!(id: 1, email: "yasuhiro-suzuki@mitsui-s.com", password: "password", name: "鈴木康弘"       , role: :staff)
#User.create!(id: 2, email: "y.suzuki.hk@gmail.com",        password: "password", name: "鈴木康弘・gmail", role: :staff)
#User.create!(id: 3, email: "y_suzuki_hk@yahoo.co.jp",      password: "password", name: "鈴木康弘・yahoo", role: :normal)
#User.create!(id: 4, email: "h-hirano@mitsui-s.com",        password: "password", name: "平野東之"       , role: :normal)
#User.create!(id: 5, email: "m-ishii@mitsui-s.com",         password: "password", name: "石井 三明"      , role: :normal)
#User.create!(id: 6, email: "k-seo@mitsui-s.com",           password: "password", name: "瀬尾健太"       , role: :normal)
#User.create!(id: 7, email: "t-hyogo@mitsui-s.com",         password: "password", name: "兵庫貴帆"       , role: :normal)
#User.create!(id: 8, email: "k-asano@mitsui-s.com",         password: "password", name: "浅野係長"       , role: :normal)
#User.create!(id: 9, email: "y-imamura@mitsui-s.com",       password: "password", name: "今村雄二"       , role: :normal)
#User.create!(id:10, email: "ngocanhnguyen@mitsui-s.com",   password: "password", name: "アイン"         , role: :normal)
#User.create!(id:11, email: "admin@iatf.co.jp",             password: "password", name: "ミツイ精密"     , role: :normal)


#rails c でカラムの確認
#https://qiita.com/littlekbt/items/48fa2b428147921db5a5

CSV.foreach('db/record/test_mondai.csv') do |row|
  Testmondai.create(
  :kajyou    => row[0], 
  :mondai_no => row[1], 
  :rev       => row[2],
  :mondai    => row[3],
  :mondai_a  => row[4],
  :mondai_b  => row[5],
  :mondai_c  => row[6],
  :seikai    => row[7],
  :kaisetsu  => row[8]  
  )
end

#下記では、モデルにCSVのデータを流し込めなかった。。。
#CSV.foreach('db/record/test_mondai.csv',headers: true) do |row|
#  Testmondai.create(
#  kajyou:    row['kajyou'], 
#  mondai_no: row['mondai_no'],
#  rev:       row['rev'],
#  mondai:    row['mondai'],
#  mondai_a:  row['mondai_a'], 
#  mondai_b:  row['mondai_b'], 
#  mondai_c:  row['mondai_c'],
#  seikai:    row['seikai'], 
#  kaisetsu:  row['kaisetsu']
#  )
#end



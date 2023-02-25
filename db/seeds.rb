require "csv"

CSV.foreach('db/category.csv') do |row|
  Phase.create(:id => row[0], :name => row[1], :ancestry => row[2])
  
end


User.create!(id: 1, email: "yasuhiro-suzuki@mitsui-s.com", password: "password", name: "鈴木康弘", role: :staff)
User.create!(id: 2, email: "y.suzuki.hk@gmail.com", password: "password", name: "鈴木康弘・gmail", role: :staff)
User.create!(id: 3, email: "y_suzuki_hk@yahoo.co.jp", password: "password", name: "鈴木康弘・yahoo", role: :normal)




require "csv"

CSV.foreach('db/category.csv') do |row|
  Phase.create(:id => row[0], :name => row[1], :ancestry => row[2])
  
end




class CreateIots < ActiveRecord::Migration[7.0]
  def change
    create_table :iots do |t|
      t.datetime :date
      t.float :data
      

      t.timestamps
    end
  end
end

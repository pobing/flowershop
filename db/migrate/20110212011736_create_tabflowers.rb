class CreateTabflowers < ActiveRecord::Migration
  def self.up
    create_table :tabflowers do |t|
      t.int :id
      t.varchar :fName
      t.varchar :fHanyi
      t.float :fSPrice
      t.varchar :fImg
      t.varchar :fDetails
      t.varchar :fCailiao
      t.varchar :fBaoZ
      t.float :fPprice

      t.timestamps
    end
  end

  def self.down
    drop_table :tabflowers
  end
end

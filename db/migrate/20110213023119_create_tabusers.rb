class CreateTabusers < ActiveRecord::Migration
  def self.up
    create_table :tabusers do |t|
      t.int :id
      t.varchar :uName
      t.varchar :uPass
      t.varchar :uTname
      t.varchar :uAddress
      t.varchar :uCode
      t.varchar :uPhone
      t.varchar :uEmail
      t.varchar :uAddressType
      t.timestamps
    end
  end

  def self.down
    drop_table :tabusers
  end
end

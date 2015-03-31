class CreateCrimeTable < ActiveRecord::Migration
  def change
    create_table :crimes do |t|
      t.string "time"
      t.string "category"
      t.string "pddistrict"
      t.string "pdid"
      t.string "address"
      t.string "descript"
      t.string "dayofweek"
      t.string "resolution"
      t.string "date"
      t.string "x"
      t.string "y"
      t.string "incidntnum"
      t.timestamps
    end
  end
end

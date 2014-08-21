class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.date :date
      t.references :post
      t.references :tag

      t.timestamps
    end
  end
end

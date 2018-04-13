class AddH2ColumnToPages < ActiveRecord::Migration
  def change
    add_column :spree_pages, :h2, :text
  end
end

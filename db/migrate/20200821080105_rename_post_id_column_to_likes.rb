class RenamePostIdColumnToLikes < ActiveRecord::Migration[6.0]
  def change
    rename_column :likes, :post_id, :book_id
  end
end

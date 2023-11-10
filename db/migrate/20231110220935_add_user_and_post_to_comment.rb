class AddUserAndPostToComment < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :user, null: false, foriegn_key: true
    add_reference :comments, :post, null: false, foriegn_key: true
  end
end

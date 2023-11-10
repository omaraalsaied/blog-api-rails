class AddUserToPost < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :user, null: false, foriegn_key: true
  end
end

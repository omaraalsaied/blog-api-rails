class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post

    scope :by_user, lambda {|user|
            where("user_id" => user.id)
        }
end

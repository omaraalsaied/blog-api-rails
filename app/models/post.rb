class Post < ApplicationRecord
    def self.posts_list
        posts_list = []
            posts = Post.all
            posts.each do |post|
                post_info = post.attributes
                post_info[:author] = post.user.name
                posts_list << post_info
            end 
            posts_list
    end
        belongs_to :user
    
        scope :by_user, lambda {|user|
            where("user_id" => user.id)
        }
end

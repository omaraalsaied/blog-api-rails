class PostCleanupJob
  include Sidekiq::Job

  def perform(post_id)
    post = Post.find(post_id)
    puts "post with id #{post_id} has been deleted"
    post.destroy
  end
end

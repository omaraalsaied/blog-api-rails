class PostCleanupJob
  include Sidekiq::Job

  def perform(post_id)
    post = Post.find(post_id)

    if post.created_at < 1.hours.ago
      post.destroy
    end
  end
end

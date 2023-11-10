class Api::V1::PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :access_post, only: %i[update destroy]


    def index
       
        render json: Post.posts_list
    end

    def show
        @post = Post.find(params[:id])
        @post = @post.attributes.merge(author: @post.user.name, comments: @post.comments)
        render json: @post
    rescue ActiveRecord::RecordNotFound
        render json: {error: "Post not found"}, status: 404

    end

    def create
        @post = Post.new(valid_params)
        @post.user_id = current_user.id
        if @post.save
            render json: @post, status: 200
        else 
            render json: @post.errors, status: :unprocessable_entity
        end
    end


    def update
       
        if @post
            @post.update(valid_params)
            render json: {message: "Post Updated"}, status: 200
        else
            render json: {error: "unable to update post"}, status: 500
        end
    end

    def destroy 
     
        if @post
            @post.destroy
            render json: {message: "Post Deleted"}, status: 200
        else
            render json: {error: "unable to delete post"}, status: 500
        end
    end

    private 

    def valid_params 
        params.require(:post).permit(:title, :body, :tags)
    end

    def access_post
        @post = Post.by_user(current_user).find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: {error: "you can't edit or delete this post"}, status: 403
    end
end

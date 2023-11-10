class Api::V1::CommentsController < ApplicationController

    before_action :authenticate_user!
    before_action :access_comment, only: %i[update destroy]

    def show
        @comment = Comment.find(params[:id])
        @comment = @comment.attributes.merge(author: @comment.user.name)
        render json: @comment
    rescue ActiveRecord::RecordNotFound
        render json: {error: "Comment not found"}, status: 404
    end

    def create 
        @comment = Comment.new(valid_params)
        @comment.user_id = current_user.id
        if @comment.save
            render json: @comment, status: :ok
        else 
            render json: @comment.errors, status: :unprocessable_entity
        end
    end


    def update
        
        if @comment 
            @comment.update(valid_params)
            render json: {message: "Comment Updated"}, status: :ok
        else
            render json: {error: "unable to update comment"}, status: 500
        end
    end

    def destroy

        if @comment 
            @comment.destroy
            render json: {message: "Comment Deleted"}, status: :ok
        else
            render json: {error: "unable to update comment"}, status: 500
        end
    end


    private

    def valid_params 
        params.require(:comment).permit(:body, :post_id)
    end

    def access_comment
        @comment = Comment.by_user(current_user).find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: {error: "you can't edit or delete this comment"}, status: 403
    end


end

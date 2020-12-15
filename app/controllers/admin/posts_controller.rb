class Admin::PostsController < ApplicationController
  before_action :authorize_request

  def index
    page = params[:page] || 1
    per = params[:per] || 10
    posts = Post.page(page).per(per)
    render json: posts, status: :ok
  end

  def show
    @post = Product.find(params[:id])
    render json: @post, status: :ok
  end


  def create
    ActiveRecord::Base.transaction do
      post = Post.createPost(params)
      if post.present?
        response = {post: post}
        render json: response, status: :ok
      else
        response = {}
        render json: response, status: :not_found
      end

    end
  end

  def update
    post = Post.updatePost(params)
    response = {post: post}
    render json: response, status: :ok
  end

  def destroy
    post = Post.find(params[:id])
    if post.present?
      post.delete
      response = {delete_status: 'complete'}
      render json: response, status: :ok
    end
  end
  
end

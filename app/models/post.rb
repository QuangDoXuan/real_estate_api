class Post < ApplicationRecord
  mount_uploader :thumnail, ThumbnailUploader

  def self.createPost params
    post = Post.create(
      name: params[:name].presence,
      description: params[:description].presence,
      title: params[:title].presence,
      thumnail: params[:thumnail].presence,
      content: params[:content].presence,
      is_hot: params[:is_hot].presence,
      is_present: params[:is_present].presence
    )
    post.save
    post
  end

  def self.updatePost params
    post = Post.update(
      name: params[:name].presence,
      description: params[:description].presence,
      title: params[:title].presence,
      thumnail: params[:thumnail].presence,
      content: params[:content].presence,
      is_hot: params[:is_hot].presence,
      is_present: params[:is_present].presence
    )
    post
  end

end
  
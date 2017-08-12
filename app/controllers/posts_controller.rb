class PostsController < ApplicationController
	before_action :find_post, only: [:edit, :update, :show, :destroy]
	before_action :authenticate_admin!, except: [:index, :show, :about, :articulos, :contact, :instagram, :privacy, :video, :mailer_guest, :mailer_subscriber]

	def index
		@post = Post.find(7) #Post.where(title: "Por qué estás aquí?").first
	end

	def new
	    @post = Post.new
	    @category = Category.new
	    @categories = Category.all
	    @images_url = Cloudinary::Api.resources["resources"]
	    @our_data = Instagram.user_recent_media
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			flash[:notice] = "Successfully created post!"
			redirect_to post_path(@post)
		else
			flash[:alert] = "Error creating new post!"
			render :new
		end
  	end

  	def create_categories
  		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "Successfully created category!"
			redirect_to new_post_path
		else
			flash[:alert] = "Error creating new post!"
			render :new
		end
  	end

  	def destroy_category
  		@category_on = Category.find(params[:id])
		if @category_on.destroy
			flash[:notice] = "Successfully deleted category!"
			redirect_to new_post_path
		else
			flash[:alert] = "Error updating categories!"
		end
  	end

	def edit
	    @categories = Category.all
	    @images_url = Cloudinary::Api.resources["resources"]
	    @our_data = Instagram.user_recent_media
	end

	def update
		if @post.update_attributes(post_params)
			flash[:notice] = "Successfully updated post!"
			redirect_to post_path(@post)
		else
			flash[:alert] = "Error updating post!"
			render :edit
		end
	end

	def show
		@categories = @post.categories
	end

	def destroy
		if @post.destroy
			flash[:notice] = "Successfully deleted post!"
			redirect_to articulos_path
		else
			flash[:alert] = "Error updating post!"
		end
	end

	def delete_img
		Cloudinary::Uploader.destroy(params[:url])
		#Ckeditor::Picture.find(params[:url]).delete
		redirect_to new_post_path
	end

	def about
		@post_profile = Post.find(6) 
	end

	def articulos

		no_tags = [6, 7]

		if not params[:cat_id].nil?
			@category_true = true
			@category_on = Category.find(params[:cat_id])
			@posts = @category_on.posts
		elsif not params[:search].nil?
			@posts = Post.search(params[:search]).where('id NOT IN (SELECT id FROM posts WHERE id IN (?))', no_tags) #.not(id: 6)
		elsif params[:id]
			@posts = Post.where('id < ?', params[:id]).limit(5).where('id NOT IN (SELECT id FROM posts WHERE id IN (?))', no_tags) #.not(id: 6)
		else
			@posts = Post.limit(5).where('id NOT IN (SELECT id FROM posts WHERE id IN (?))', no_tags) #.not(id: 6)
		end


	    respond_to do |format|
	      format.html
	      format.js
	    end
	end

	def contact
	end

	def instagram
		# http://www.rubydoc.info/github/Instagram/instagram-ruby-gem/Instagram/Client
		# code = params[:code]
		# data = Instagram.get_access_token(code)
		# access_token = data.access_token	
		# @our_data = access_token
		# @our_data = Instagram.user_recent_media
	end

	def privacy
	end

	def video
		@links = Link.all
	end

	def add_link
		url = params[:url] #watch?v=  by embed
		url["watch?v="] = "embed/"
		Link.create(url: url)
		redirect_to video_path
	end

	def remove_link
		Link.find(params[:id]).delete
		redirect_to video_path
	end

	def mailer_guest
		@subject = params["subject"]
		@message = params["message"]
		@guest_mail = params["guest_mail"]
		GuestMailer.send_contact(@subject, @message, @guest_mail).deliver_now
		flash[:mail] = "Mail sent"
		redirect_to contact_path
	end

	def mailer_subscriber
		Subscriber.create(email: params[:subscriber][:email])
		flash[:subscribe] = "Listo para ser feliz !"
		redirect_to articulos_path
	end

	def remove_subscriber
		Subscriber.find(params[:id]).delete
		redirect_to new_post_path
	end

  private

	def post_params
		params.require(:post).permit(:title, :body, { category_ids: []})
	end

	def category_params
		params.require(:category).permit(:name)
	end

	def find_post
		@post = Post.find(params[:id])
	end

end

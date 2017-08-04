class PostsController < ApplicationController
	before_action :find_post, only: [:edit, :update, :show, :destroy]
	before_action :authenticate_admin!, except: [:index, :show, :about, :articulos, :contact, :instagram, :video]

	def index
		@post = Post.find(3) #Post.where(title: "Por qué estás aquí?").first
	end

	def new
	    @post = Post.new
	    @category = Category.new
	    @categories = Category.all
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

	def about
		@post_profile = Post.find(6) 
	end

	def articulos
		if not params[:cat_id].nil?
			@category_true = true
			@category_on = Category.find(params[:cat_id])
			@posts = @category_on.posts.where.not(id: 6)
		elsif not params[:search].nil?
			@posts = Post.search(params[:search]).where.not(id: 6)
		elsif params[:id]
			@posts = Post.where('id < ?', params[:id]).limit(5).where.not(id: 6)
		else
			@posts = Post.limit(5).where.not(id: 6)
		end

	    respond_to do |format|
	      format.html
	      format.js
	    end
	end

	def contact
	end

	def instagram
	end

	def video
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

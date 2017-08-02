class PostsController < ApplicationController
	before_action :find_post, only: [:edit, :update, :show, :destroy]
	before_action :authenticate_admin!, except: [:index, :show, :about, :category, :contact, :instagram, :video]

	def index
		@post = Post.where(title: "Por qué estás aquí?").first
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
	end

	def articulos
		@posts = Post.all
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

class PostsController < ApplicationController
  # before_action :set_post, only: [:show, :edit, :update, :destroy]

  #before_action :authenticate_user!, except: [:index, :show]
  #before_action :check_admin!, only: [:destroy]
  #before_action :check_editor!, only: [:edit, :update]

   load_and_authorize_resource

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @tags = Tag.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments.reverse
    @tags = Tag.all
    @post_tags = @post.tags
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user if user_signed_in?


    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

   def set_tag
    if params.key?(:tags_ids) && !params[:tags_ids].empty?
      @tags = Tag.find(params[:tags_ids])
      @post.tags = @tags
    else
      @post.tags.clear
    end
     redirect_to @post
  end

  def set_tags
    if params.key?(:tags_ids) && !params[:tags_ids].empty? && params.key?(:posts_ids) && !params[:posts_ids].empty?
      @posts = Post.find(params[:posts_ids])
      @tags = Tag.find(params[:tags_ids])
      @posts.each do |post|
        post.tags = @tags
      end
      redirect_to root_path, notice: 'Tag(s) asignado correctamente.'
    else
      redirect_to root_path, alert: 'Tienes que seleccionar al menos un Tag y un Post'
    end
  end

  def like
    @post = Post.find(params[:id])
    @like = @post.likes.build(user: current_user)

    if @post.liked_by? current_user
      @post.remove_like current_user
      redirect_to @post, notice: 'Ya no te gusta'
    elsif @post.save
      redirect_to @post, notice: 'Gracias por el me gusta'
    else
      redirect_to @post, notice: 'Ha ocurrido un error tu like no fue guardado'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name, :title, :content)
    end
end

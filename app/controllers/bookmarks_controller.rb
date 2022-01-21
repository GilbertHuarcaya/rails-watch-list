class BookmarksController < ApplicationController
  before_action :set_bookmark, only: :destroy
  before_action :set_list, only: [:new, :create]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @movie = Movie.find(@bookmark[:movie_id])
    @bookmark.list = @list
    @bookmark.movie = @movie
    @bookmark.save
    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to list_path(@list), notice: "bookmark was successfully created." }
        format.json { render :show, status: :ok, location: @bookmark }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # def create
  #   @bookmark = Bookmark.new(bookmark_params)
  #   @bookmark.list = @list
  #   flash[:notice] = @bookmark.errors.full_messages.to_sentence unless @bookmark.save
  #   redirect_to list_path(@list)
  # end

  def destroy
    @bookmark.destroy
    redirect_to list_path(@bookmark.list)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end

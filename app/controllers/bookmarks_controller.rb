class BookmarksController < ApplicationController
  before_action :set_bookmark, only: %i[ show edit update destroy ]

  # GET /bookmarks/1 or /bookmarks/1.json

  # GET /bookmarks/new
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  # GET /bookmarks/1/edit
  # POST /bookmarks or /bookmarks.json
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

  # PATCH/PUT /bookmarks/1 or /bookmarks/1.json
  # DELETE /bookmarks/1 or /bookmarks/1.json
  def destroy
    @bookmark.destroy
    @list = List.find(params[:id])
    respond_to do |format|
      format.html { redirect_to list_path(@list), notice: "List was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bookmark
    @bookmark = Bookmark.find(params[:list_id])
  end

  # Only allow a bookmark of trusted parameters through.
  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end

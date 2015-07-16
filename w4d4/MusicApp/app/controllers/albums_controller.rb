class AlbumsController < ApplicationController
  def new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    @tracks = @album.tracks
    render :show
  end

  def destroy
    @album = Album.find(params[:id]).destroy
    redirect_to band_url(@album.band)
  end

  private
  def album_params
    params.require(:album).permit(:name, :band_id)
  end
end

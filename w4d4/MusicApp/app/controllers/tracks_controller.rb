class TracksController < ApplicationController
  before_action :active_user?

  def new
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def destroy
    @track = Track.find(params[:id]).destroy!
    redirect_to album_url(@track.album)
  end

  private
  def track_params
    params.require(:track).permit(:name, :album_id, :checked, :lyrics)
  end
end

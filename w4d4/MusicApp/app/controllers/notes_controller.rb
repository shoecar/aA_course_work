class NotesController < ApplicationController
  before_action :owns_note?, only: :destroy

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    if @note.save
      redirect_to track_url(@note.track)
    else
      flash.now[:errors] = @note.errors.full_messages
      redirect_to track_url(@note.track)
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy!
    redirect_to track_url(@note.track)
  end

  private
  def note_params
    params.require(:note).permit(:text, :track_id)
  end

  def owns_note?
    current_user.id == Note.find(params[:id]).user_id
  end
end

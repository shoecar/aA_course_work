class CatRentalRequestsController < ApplicationController
  def new
    @cat_request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @cat_request = CatRentalRequest.new(rental_params)

    if @cat_request.save
      redirect_to cat_rental_request_url(@cat_request)
    else
      render :new
    end
  end

  def edit
    @cat_request = CatRentalRequest.find(params[:id])
    render :edit

  end

  def show
    @cat_request = CatRentalRequest.find(params[:id])
    render :show
  end

  def update
    @cat_request = CatRentalRequest.find(params[:id])

    if @cat_request.update(rental_params)
      redirect_to cat_rental_request_url(@cat_request)
    else
      render :edit
    end      
  end

  private

  def rental_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end
end

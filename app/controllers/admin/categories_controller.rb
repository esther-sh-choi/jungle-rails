class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.valid?
      if @category.save
        redirect_to [:admin, :categories], method: :get, notice: 'Category created!'
      else
        render :new
      end
    else
      redirect_to new_admin_category_path, flash: { error: @category }
      # .errors.full_messages.first
    end
  end


  private
    def category_params
      params.require(:category).permit(
        :name
      )
    end
end

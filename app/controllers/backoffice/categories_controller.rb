class Backoffice::CategoriesController < BackofficeController
  before_action :set_category, only: [:edit, :update]
  def index
  	@categories = Category.all
  end

  def new
  	@category = Category.new
  end

  def create
  	@category = Category.new(params_category)
    if @category.save
      redirect_to backoffice_categories_path, notice: "Categoria (#{@category.description}) fue creada con exito!"
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @category.update(params_category)
      redirect_to backoffice_categories_path, notice: "Categoria (#{@category.description}) fue actualizada con exito!"
    else
      render :edit
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def params_category
    params.require(:category).permit(:description)
  end
end

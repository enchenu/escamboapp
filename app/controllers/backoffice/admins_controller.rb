class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: [:edit, :update, :destroy]
  def index
  	#@admins = Admin.all
    @admins = Admin.with_full_access
  end

  def new
  	@admin = Admin.new
  end

  def create
  	@admin = Admin.new(params_admin)
    if @admin.save
      redirect_to backoffice_admins_path, notice: "El Administrador (#{@admin.email}) fue creado con exito!"
    else
      render :new
    end
  end

  def edit

  end

  def update
    passwd = params[:admin][:password]
    passwd_confirmation =  params[:admin][:password_confirmation]

    if passwd.blank? && passwd_confirmation.blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end

    if @admin.update(params_admin)
      redirect_to backoffice_admins_path, notice: "El Administrador (#{@admin.email}) fue actualizado con exito!"
    else
      render :edit
    end
  end

  def destroy
    admin_email = @admin.email
    if @admin.destroy
      redirect_to backoffice_admins_path, notice: "El Administrador (#{admin_email}) fue excluido con exito!"
    else
      render :index
    end
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def params_admin
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end

end

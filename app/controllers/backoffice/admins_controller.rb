class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: [:edit, :update, :destroy]
  after_action :verify_authorized, only: [:new, :destroy]
  after_action :verify_policy_scoped, only: :index

  def index
  	#@admins = Admin.all
    #@admins = Admin.with_restricted_access
    @admins = policy_scope(Admin)
  end

  def new
  	@admin = Admin.new
    authorize @admin
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
    if @admin.update(params_admin)
      redirect_to backoffice_admins_path, notice: "El Administrador (#{@admin.email}) fue actualizado con exito!"
    else
      render :edit
    end
  end

  def destroy
    authorize @admin
    admin_name = @admin.admin_name

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
    passwd = params[:admin][:password]
    passwd_confirmation =  params[:admin][:password_confirmation]

    if passwd.blank? && passwd_confirmation.blank?
      params[:admin].except!(:password, :password_confirmation)
    end
    params.require(:admin).permit(policy(@admin).permitted_attributes)
  end

end

class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, only: [:create, :update]

  def edit
    @cancel=true;
    @back=true;
  end

  def create
    super
    @uploaded_io = params[:user][:avatar]
    Dir.mkdir(user_dir_path, 0700) unless Dir.exist? user_dir_path
    if params[:user][:avatar]
      File.open user_dir_path.join('avatar.jpg'), 'wb' do |file|
        file.write(@uploaded_io.read)
      end
    end
  end

  def update
    super
    @uploaded_io = params[:user][:avatar]
    if params[:user][:avatar]
      File.open user_dir_path.join('avatar.jpg'), 'wb' do |file|
        file.write(@uploaded_io.read)
      end
    end
  end
  
  private
    def user_dir_path
      Rails.root.join('app', 'assets', 'images', params[:user][:username])
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :bio << :avatar
      devise_parameter_sanitizer.for(:account_update) << :bio << :avatar
    end
end

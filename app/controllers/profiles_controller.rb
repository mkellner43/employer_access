class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update]

  # GET /profiles/1 or /profiles/1.json
  def show
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles or /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html {
          redirect_to user_profile_path(current_user, @profile), notice: "Profile was successfully created."
        }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        @profile.user.avatar.purge if @profile.user.remove_avatar == '1'
        format.html {
          redirect_to user_profile_path(current_user, @profile), notice: "Profile was successfully updated."
        }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = current_user.profile
  end

  # Only allow a list of trusted parameters through.
  def profile_params
    params.require(:profile).permit(:id, :user_id, :city, :state, :zip_code, :street_address, :date_of_birth, :bio,
                                    :phone_number, user_attributes: [:id, :first_name, :last_name, :avatar,
                                                                     :remove_avatar])
  end
end

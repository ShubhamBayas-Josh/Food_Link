class DonationsController < ApplicationController
    # GET /admins or /admins.json
    def index
      @admins = Admin.all
      @users = User.all
      @users_count = @users.count

      # Fetching recent activities
      @recent_donors = User.where(role: "donor").order(created_at: :desc).limit(5)
      @recent_ngos = User.where(role: "ngo").order(created_at: :desc).limit(5)
      @recent_food_donations = FoodTransaction.all
      @recent_claims = FoodClaim.order(created_at: :desc).limit(5)
      @recent_feedbacks = Feedback.order(created_at: :desc).limit(5)

      # Fetching Dashboard Statistics
      @total_donations = FoodTransaction.count
      @pending_donations = FoodTransaction.where(status: "pending").count
      @accepted_donations = FoodTransaction.where(status: "accepted").count
      @rejected_donations = FoodTransaction.where(status: "rejected").count

      @total_claims = FoodClaim.count
      @pending_claims = FoodClaim.where(claim_status: "pending").count
      @accepted_claims = FoodClaim.where(claim_status: "accepted").count
      @rejected_claims = FoodClaim.where(claim_status: "rejected").count

      @feedback_count = Feedback.count
      @food_wastage_reduced = FoodTransaction.where(status: "accepted").sum(:quantity) # Assuming 'quantity' is a column
    end

    # GET /admins/1 or /admins/1.json
    def show
    end

    # GET /admins/new
    def new
      @admin = Admin.new
    end

    # GET /admins/1/edit
    def edit
    end

    # POST /admins or /admins.json
    def create
      @admin = Admin.new(admin_params)

      respond_to do |format|
        if @admin.save
          format.html { redirect_to @admin, notice: "Admin was successfully created." }
          format.json { render :show, status: :created, location: @admin }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @admin.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admins/1 or /admins/1.json
    def update
      respond_to do |format|
        if @admin.update(admin_params)
          format.html { redirect_to @admin, notice: "Admin was successfully updated." }
          format.json { render :show, status: :ok, location: @admin }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @admin.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admins/1 or /admins/1.json
    def destroy
      @admin.destroy!

      respond_to do |format|
        format.html { redirect_to admins_path, status: :see_other, notice: "Admin was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    def set_admin
      @admin = Admin.find_by(id: params[:id])
      redirect_to admins_path, alert: "Admin not found." if @admin.nil?
    end

    def admin_params
      params.require(:admin).permit(:name) # Add other fields as needed
    end
end

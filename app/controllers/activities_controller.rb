class ActivitiesController < ApplicationController
  def index
    # Fetch recent donors
    @recent_donors = Donor.order(created_at: :desc).limit(10)

    # Fetch recent NGOs
    @recent_ngos = Ngo.order(created_at: :desc).limit(10)

    # Fetch recent food donations
    @recent_food_donations = FoodDonation.order(created_at: :desc).limit(10)

    # Fetch recent food claims
    @recent_claims = FoodClaim.order(created_at: :desc).limit(10)

    # Fetch recent user feedbacks
    @recent_feedbacks = Feedback.order(created_at: :desc).limit(10)
  end
end

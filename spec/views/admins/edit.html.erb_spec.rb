require 'rails_helper'

RSpec.describe "admins/edit", type: :view do
  let(:admin) {
    Admin.create!()
  }

  before(:each) do
    assign(:admin, admin)
  end

  it "renders the edit admin form" do
    render

    assert_select "form[action=?][method=?]", admin_path(admin), "post" do
    end
  end
end

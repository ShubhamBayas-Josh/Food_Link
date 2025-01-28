require 'rails_helper'

RSpec.describe "admins/index", type: :view do
  before(:each) do
    assign(:admins, [
      Admin.create!(),
      Admin.create!()
    ])
  end

  it "renders a list of admins" do
    render
    cell_selector = 'div>p'
  end
end

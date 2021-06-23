require 'rails_helper'

RSpec.describe "hotels/show", type: :view do
  before(:each) do
    @hotel = assign(:hotel, Hotel.create!(
      name: "Name",
      city: "City",
      number_of_rooms: "Number Of Rooms",
      price: "Price"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Number Of Rooms/)
    expect(rendered).to match(/Price/)
  end
end

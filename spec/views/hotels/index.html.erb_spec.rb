require 'rails_helper'

RSpec.describe "hotels/index", type: :view do
  before(:each) do
    assign(:hotels, [
      Hotel.create!(
        name: "Name",
        city: "City",
        number_of_rooms: "Number Of Rooms",
        price: "Price"
      ),
      Hotel.create!(
        name: "Name",
        city: "City",
        number_of_rooms: "Number Of Rooms",
        price: "Price"
      )
    ])
  end

  it "renders a list of hotels" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "City".to_s, count: 2
    assert_select "tr>td", text: "Number Of Rooms".to_s, count: 2
    assert_select "tr>td", text: "Price".to_s, count: 2
  end
end

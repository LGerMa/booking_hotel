require 'rails_helper'

RSpec.describe "hotels/edit", type: :view do
  before(:each) do
    @hotel = assign(:hotel, Hotel.create!(
      name: "MyString",
      city: "MyString",
      number_of_rooms: "MyString",
      price: "MyString"
    ))
  end

  it "renders the edit hotel form" do
    render

    assert_select "form[action=?][method=?]", hotel_path(@hotel), "post" do

      assert_select "input[name=?]", "hotel[name]"

      assert_select "input[name=?]", "hotel[city]"

      assert_select "input[name=?]", "hotel[number_of_rooms]"

      assert_select "input[name=?]", "hotel[price]"
    end
  end
end

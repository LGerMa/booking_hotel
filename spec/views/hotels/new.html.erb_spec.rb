require 'rails_helper'

RSpec.describe "hotels/new", type: :view do
  before(:each) do
    assign(:hotel, Hotel.new(
      name: "MyString",
      city: "MyString",
      number_of_rooms: "MyString",
      price: "MyString"
    ))
  end

  it "renders new hotel form" do
    render

    assert_select "form[action=?][method=?]", hotels_path, "post" do

      assert_select "input[name=?]", "hotel[name]"

      assert_select "input[name=?]", "hotel[city]"

      assert_select "input[name=?]", "hotel[number_of_rooms]"

      assert_select "input[name=?]", "hotel[price]"
    end
  end
end

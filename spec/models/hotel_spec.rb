require 'rails_helper'

RSpec.describe Hotel, type: :model do
  it { should have_many :reservations}
end

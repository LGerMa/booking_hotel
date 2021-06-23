require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it { should belong_to :hotel}
end

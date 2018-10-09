require 'rails_helper'

RSpec.describe Rate, type: :model do
  it { should belong_to(:rateable) }

  it { should define_enum_for(:kind) }
end

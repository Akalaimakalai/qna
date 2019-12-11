require 'rails_helper'

RSpec.describe Medal, type: :model do
  it { should belong_to :question }
  it { should belong_to(:user).optional }
  it { should validate_presence_of :name }

  it 'have one attached imade' do
    expect(Medal.new.image).to be_an_instance_of(ActiveStorage::Attached::One)
  end
end

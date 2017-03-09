require 'rails_helper'

RSpec.describe User, type: :model do
  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved with unmatching password and confirmation" do
    user = User.create username:"Pekka", password: "Eka", password_confirmation: "toka"

    expect(user.valid?).to be (false)
    expect(User.count).to eq(0)
  end

  it "is saved with matching password and confirmation" do
    user = User.create username:"Pekka", password: "salasana", password_confirmation: "salasana"
    expect(user.valid?).to be(true)
    expect(User.count).to eq(1)
  end
end

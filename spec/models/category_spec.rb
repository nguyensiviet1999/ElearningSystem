require "rails_helper"
require "factories/categories"

RSpec.describe Category, type: :model do
  describe "Associations" do
    # it "has many course" do
    #   association = described_class.reflect_on_association(:courses)
    #   expect(association.macro).to eq :has_many
    # end
    it { is_expected.to have_many(:courses) }
  end
end

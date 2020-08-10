require "rails_helper"
require "factories/courses"

RSpec.describe Course, type: :model do
  describe "Associations" do
    # it "belongs to category" do
    #   association = described_class.reflect_on_association(:category)
    #   expect(association.macro).to eq :belongs_to
    # end
    it { is_expected.to belong_to(:category) }
  end
  describe "validations" do
    # let(:course) { FactoryBot.create :course }
    # it "is valid with valid attributes" do
    #   expect(course).to be_valid
    # end
    it { is_expected.to validate_presence_of(:course_name) }

    # it "is not valid without a course name" do
    #   course.course_name = nil
    #   expect(course).to_not be_valid
    # end

    # it "is not valid with too long description" do
    #   course.course_name = "a" * 51
    #   expect(course).to_not be_valid
    # end
    it { is_expected.to validate_length_of(:course_name).is_at_most(50) }
  end
end

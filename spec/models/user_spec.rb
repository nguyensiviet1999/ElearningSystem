require "rails_helper"

RSpec::Matchers.define :be_a_multiple_of do |expected|
  match do |actual|
    actual % expected == 0
  end
end
RSpec.describe 9 do
  it { expect(9).to be_a_multiple_of(3) }
end
RSpec.shared_examples "shared example" do |parameter|
  let(:something) { parameter }
  it "uses the given parameter" do
    expect(something).to eq(parameter)
  end
end
RSpec.shared_context "shared context" do |parameter|
  before { @some_var = :some_value }

  def shared_method
    "this is shared method"
  end

  let(:share_let) { "this shared let" }
  subject { "this is the subject" }
end
RSpec.describe User, type: :model do
  let(:foolet1) {
    puts "is test let"
    "test one"
  }
  let!(:foolet2) {
    puts "is test let!"
    "test two"
  }

  describe "User" do
    context "when create new user" do
      it "is valid with a  name , email and password" do
        user = User.new(
          name: "viet",
          email: "firdt_last@email.com",
          password: "123456",
          password_confirmation: "123456",
        )
        expect(subject).not_to be_nil #subject tu dong lay tat ca instance cua class
        # should be_nil = is_expected.to be_nil =  expect(subject).to be_nil
        expect(described_class).to eq(User)
      end
      it "is not valid with name, email and password is nil" do
        user = User.new
        expect(user).not_to be_valid
      end

      it "let 1" do
        expect(foolet1).to eq("test one")
      end
      it "let 2" do
        expect(foolet2).to eq("test two")
      end
    end
  end
  context "with first test case" do
    it_behaves_like "shared example", "parameter1"
  end
end
RSpec.describe "Test share_context" do
  include_context "shared context"
  it { expect(@some_var).to eq(:some_value) }
  it { expect(shared_method).to eq("this is shared method") }
  it { expect(share_let).to eq("this shared let") }
  it { is_expected.to eq("this is the subject") }
end

require "test_helper"

describe Work do
  before do
    @work = works(:toy_story)
  end

  it "passes validations with good data" do
    expect(@work).must_be :valid?
  end
end

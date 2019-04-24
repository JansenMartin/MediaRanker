require "test_helper"

describe Work do
  before do
    @work = works(:toy_story)
  end

  it "must be valid with good data" do
    result = @work.valid?
    expect(result).must_equal true
  end
end

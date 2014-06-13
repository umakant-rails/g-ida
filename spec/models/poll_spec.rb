require "spec_helper"

describe Poll do
  describe "should have mandatory fields" do
    it "validate title" do
      poll = Poll.new(title: "", has_multiple_answer: false)
      poll.save
      expect(poll.errors.keys).to include(:title)
      expect(poll.persisted?).to be_false
    end

    it "create new poll" do
      poll = Poll.new
      poll.title = "Poll creation is working proper or not"
      poll.has_multiple_answer = true
      poll.save 
      expect(poll.persisted?).to be_true
    end
  end

end

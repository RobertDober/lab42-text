require 'spec_helper'

describe Lab42::Text::SimpleBox do 
  context "simplest case" do 
    subject do
      described_class.new [
        "Line One",
        "   Line Two",
        " Line Three"
      ]
    end
    it "is constructed from lines" do
      expect( subject.render ).to eq [
          "+-------------+",
          "| Line One    |",
          "|    Line Two |",
          "|  Line Three |",
          "+-------------+"
      ]
    end

    it "is bordered with customizeable chars" do
      expect( subject.render( border: "*" ) ).to eq [
          "***************",
          "* Line One    *",
          "*    Line Two *",
          "*  Line Three *",
          "***************",
      ]
    end
  end # context "simplest case"
end # describe Lab42::Text::SimpleBox

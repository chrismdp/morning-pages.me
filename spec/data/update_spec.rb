require 'spec_helper'
require 'update'

module MorningPages
  describe Update do
    let(:params) {{ :count => 2, :average_length => 2.5 }}

    it "must have word count" do
      Update.new(params.except(:count)).should_not be_valid
    end

    it "has average length" do
      Update.new(params).average_length.should == 2.5
    end

    it "doesn't accept other params" do
      expect { Update.new(params.merge(:foo => 'bar')).foo }.to raise_error(NoMethodError)
    end
  end
end

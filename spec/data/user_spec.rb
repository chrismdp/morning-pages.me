require 'spec_helper'
require 'user'
require 'update'

module MorningPages
  describe User do

    let(:params) {{ :email => 'foo@example.com', :username => 'foo' }}

    context "creation" do
      it "must have an email and username" do
        user = User.new(params)
        user.email.should == params[:email]
        user.username.should == params[:username]

        User.new(params.except(:email)).should_not be_valid
        User.new(params.except(:username)).should_not be_valid
      end

      it "checks email is formatted" do
        user = User.new(params.merge(:email => 'foobar'))
        user.should_not be_valid
      end

      it "has unique username" do
        user = User.create(params)
        User.new(params).should_not be_valid
      end

      it "cannot be created with extra params" do
        user = User.new(:foo => 'bar')
        expect { user.foo }.to raise_error(NoMethodError)
      end

      it "generates a unique key on save" do
        User.create(params).key.should_not be_nil
      end
    end

    context "posting updates" do
      let(:user) { User.new(params) }

      it "has updates" do
        user.updates.count.should == 0
      end
    end
  end
end

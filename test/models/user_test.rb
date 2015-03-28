require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
	@user=User.new(name:"adfasf",email:"")
	end
	
	test "should be valid haha" do
		assert_not @user.valid?
	end
end

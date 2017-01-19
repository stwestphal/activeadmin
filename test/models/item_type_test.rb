require 'test_helper'

class ItemTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # testen ob objekt instanziert wird (Test Cases are 'describe' blocks (Classes)):
  describe ItemType do
    let(:item_type) { ItemType.new }

    # tests are 'it' blocks (methods)
    it "must be valid" do
      item.must_be :valid?
    end
  end
end

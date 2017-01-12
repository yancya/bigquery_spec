require_relative './helper.rb'

class ArrayTest < Test::Unit::TestCase
  test "Array equality" do
    msg = "invalidQuery: Equality is not defined for arguments of type ARRAY<INT64> at [2:8]"
    expected_error = Google::Cloud::InvalidArgumentError.new(msg)

    assert_raise(expected_error) do
      query <<~SQL
        SELECT [1] = [1]
      SQL
    end
  end
end

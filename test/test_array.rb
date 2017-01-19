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

  test "group by Array" do
    msg = "invalidQuery: Grouping by expressions of type ARRAY is not allowed at [9:10]"
    expected_error = Google::Cloud::InvalidArgumentError.new(msg)

    assert_raise(expected_error) do
      query <<~SQL
        WITH t AS (
      SELECT *
        FROM UNNEST(ARRAY<STRUCT<id INT64, messages ARRAY<STRING>>>
               [(1, ['a', 'b']), (2, ['c', 'd'])]))

      SELECT messages, COUNT(id)
        FROM t
    GROUP BY 1
      SQL
    end
  end
end

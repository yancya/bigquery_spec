require_relative './helper.rb'

class StructTest < Test::Unit::TestCase
  test "Count distinct with Struct" do
    msg = "invalidQuery: Aggregate functions with DISTINCT cannot be used with arguments of type STRUCT<INT64, STRING> at [7:8]"
    expected_error = Google::Cloud::InvalidArgumentError.new(msg)

    assert_raise(expected_error) do
      query <<~SQL
          WITH t AS (
        SELECT *
          FROM UNNEST(ARRAY<STRUCT<id INT64, name STRING>>
                 [(1, 'taro'), (2, 'jiro'), (1, 'taro')]))

        SELECT COUNT( distinct (id, name) ) FROM t
      SQL
    end
  end
end

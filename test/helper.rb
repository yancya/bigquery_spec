require 'test-unit'
require 'google/cloud/bigquery'

def query(sql)
  Google::Cloud.new(ENV['BIGQUERY_SPEC_PROJECT_ID']).bigquery.query(<<~SQL)
    #standardSQL
    #{sql}
  SQL
end

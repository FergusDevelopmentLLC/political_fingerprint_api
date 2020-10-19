class AddOptInToTestResults < ActiveRecord::Migration[6.0]
  def change
    add_column :test_results, :opt_in, :boolean
  end
end

class RemoveClientIpFromTestResults < ActiveRecord::Migration[6.0]
  def change
    remove_column :test_results, :client_ip, :string
  end
end

class CreateTestResults < ActiveRecord::Migration[6.0]
  def change
    create_table :test_results do |t|
      t.string :client_ip
      t.integer :question_version
      t.float :economic
      t.float :diplomatic
      t.float :civil
      t.float :societal

      t.timestamps
    end
  end
end

class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :home_team
      t.references :away_team
      t.integer :h_score
      t.integer :a_score
      t.references :group

      t.timestamps
    end
    add_index :scores, :home_team_id
    add_index :scores, :away_team_id
    add_index :scores, :group_id
  end
end

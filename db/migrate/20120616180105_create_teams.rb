class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.references :group
      t.timestamps
    end
    add_index :teams, :group_id
  end
end

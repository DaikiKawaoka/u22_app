class ChangeDataThingAssessmentToThings < ActiveRecord::Migration[6.0]
  def change
    change_column :things, :thing_assessment, :string
  end
end

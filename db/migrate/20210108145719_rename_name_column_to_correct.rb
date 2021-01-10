class RenameNameColumnToCorrect < ActiveRecord::Migration[4.2]
  def self.up
    rename_column :articles, :contnet, :content
  end

  def self.down
    rename_column :articles, :content, :contnet
  end
end

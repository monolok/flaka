class AddWasSentToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :was_sent, :boolean
  end
end

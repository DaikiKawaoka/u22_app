class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :visiter_id  #visiter_id : 通知を送ったユーザーのid
      t.integer :visited_id  #visited_id : 通知を送られたユーザーのid
      t.integer :thing_id  #thing_id : いいねされた物のid
      t.integer :comment_id  #comment_id : 投稿へのコメントのid
      t.string :action  #action : 通知の種類（フォロー、いいね、コメント）
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end

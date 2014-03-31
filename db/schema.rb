
ActiveRecord::Schema.define(version: 20140331153408) do
  enable_extension "plpgsql"
  create_table "activities", force: true do |t|
    t.integer  "user_id"
    t.string   "type"
    t.integer  "subject_id"
    t.string   "subject_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "actor_id"
    t.integer  "target_id"
    t.string   "target_type"
  end
  add_index "activities", ["subject_id", "subject_type"], name: "index_activities_on_subject_id_and_subject_type", using: :btree
  add_index "activities", ["target_id", "target_type"], name: "index_activities_on_target_id_and_target_type", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree
  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "image_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index "comments", ["image_id"], name: "index_comments_on_image_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree
  create_table "following_relationships", force: true do |t|
    t.integer  "followed_user_id"
    t.integer  "follower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index "following_relationships", ["followed_user_id"], name: "index_following_relationships_on_followed_user_id", using: :btree
  add_index "following_relationships", ["follower_id"], name: "index_following_relationships_on_follower_id", using: :btree
  create_table "galleries", force: true do |t|
    t.string  "name"
    t.integer "user_id"
  end
  add_index "galleries", ["user_id"], name: "index_galleries_on_user_id", using: :btree
  create_table "group_images", force: true do |t|
    t.integer  "image_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index "group_images", ["group_id"], name: "index_group_images_on_group_id", using: :btree
  add_index "group_images", ["image_id"], name: "index_group_images_on_image_id", using: :btree
  create_table "group_memberships", force: true do |t|
    t.integer  "group_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index "group_memberships", ["group_id"], name: "index_group_memberships_on_group_id", using: :btree
  add_index "group_memberships", ["member_id"], name: "index_group_memberships_on_member_id", using: :btree
  create_table "groups", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  create_table "images", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.integer  "gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  create_table "likes", force: true do |t|
    t.integer "user_id"
    t.integer "likable_id"
    t.string  "likable_type"
  end
  add_index "likes", ["likable_id", "likable_type"], name: "index_likes_on_likable_id_and_likable_type", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree
  create_table "users", force: true do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
  end
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
end

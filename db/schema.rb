# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130731194122) do

  create_table "actors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "actors_movies", :force => true do |t|
    t.integer  "movie_id"
    t.integer  "actor_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "directors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "directors_movies", :force => true do |t|
    t.integer "director_id"
    t.integer "movie_id"
  end

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "genres_movies", :force => true do |t|
    t.integer  "genre_id"
    t.integer  "movie_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.integer  "rt_id"
    t.integer  "tmdb_id"
    t.string   "imdb_ref"
    t.integer  "tmdb_rating"
    t.date     "release_date"
    t.string   "critic_consensus"
    t.integer  "rt_score"
    t.string   "poster_url"
    t.string   "trailer_url"
    t.string   "mpaa_rating"
    t.integer  "run_time"
    t.integer  "budget"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "demo_display"
  end

  create_table "pose_assignments", :force => true do |t|
    t.integer "word_id",                    :null => false
    t.integer "posable_id",                 :null => false
    t.string  "posable_type", :limit => 40, :null => false
  end

  add_index "pose_assignments", ["posable_id"], :name => "index_pose_assignments_on_posable_id"
  add_index "pose_assignments", ["word_id"], :name => "index_pose_assignments_on_word_id"

  create_table "pose_words", :force => true do |t|
    t.string "text", :limit => 80, :null => false
  end

  add_index "pose_words", ["text"], :name => "index_pose_words_on_text"

  create_table "ratings", :force => true do |t|
    t.integer  "movie_id"
    t.integer  "user_id"
    t.float    "rating_value"
    t.boolean  "viewable",     :default => true
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "ratings", ["movie_id"], :name => "index_ratings_on_movie_id"
  add_index "ratings", ["rating_value"], :name => "index_ratings_on_rating_value"
  add_index "ratings", ["user_id"], :name => "index_ratings_on_user_id"

  create_table "recommendations", :force => true do |t|
    t.integer "user_id"
    t.integer "movie_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end

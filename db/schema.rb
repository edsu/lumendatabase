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

ActiveRecord::Schema.define(:version => 20130530180507) do

  create_table "categories", :force => true do |t|
    t.string "name"
    t.string "description"
    t.string "ancestry"
  end

  add_index "categories", ["ancestry"], :name => "index_categories_on_ancestry"

  create_table "categories_category_managers", :force => true do |t|
    t.integer "category_id"
    t.integer "category_manager_id"
  end

  add_index "categories_category_managers", ["category_id"], :name => "index_categories_category_managers_on_category_id"
  add_index "categories_category_managers", ["category_manager_id"], :name => "index_categories_category_managers_on_category_manager_id"

  create_table "categories_notices", :force => true do |t|
    t.integer "category_id"
    t.integer "notice_id"
  end

  add_index "categories_notices", ["category_id"], :name => "index_categories_notices_on_category_id"
  add_index "categories_notices", ["notice_id"], :name => "index_categories_notices_on_notice_id"

  create_table "categories_relevant_questions", :force => true do |t|
    t.integer "category_id"
    t.integer "relevant_question_id"
  end

  add_index "categories_relevant_questions", ["category_id"], :name => "index_categories_relevant_questions_on_category_id"
  add_index "categories_relevant_questions", ["relevant_question_id"], :name => "index_categories_relevant_questions_on_relevant_question_id"

  create_table "category_managers", :force => true do |t|
    t.string "name"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "entities", :force => true do |t|
    t.string "name",                                     :null => false
    t.string "kind",           :default => "individual", :null => false
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "state"
    t.string "country_code"
    t.string "phone"
    t.string "email"
    t.string "url"
    t.string "ancestry"
  end

  add_index "entities", ["ancestry"], :name => "index_entities_on_ancestry"

  create_table "entity_notice_roles", :force => true do |t|
    t.integer  "entity_id"
    t.integer  "notice_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "entity_notice_roles", ["entity_id"], :name => "index_entity_notice_roles_on_entity_id"
  add_index "entity_notice_roles", ["notice_id"], :name => "index_entity_notice_roles_on_notice_id"

  create_table "file_uploads", :force => true do |t|
    t.integer  "notice_id"
    t.string   "kind"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "file_uploads", ["notice_id"], :name => "index_file_uploads_on_notice_id"

  create_table "infringing_urls", :force => true do |t|
    t.string   "url",        :limit => 1024, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "infringing_urls_works", :id => false, :force => true do |t|
    t.integer  "infringing_url_id", :null => false
    t.integer  "work_id",           :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "infringing_urls_works", ["infringing_url_id"], :name => "index_infringing_urls_works_on_infringing_url_id"
  add_index "infringing_urls_works", ["work_id"], :name => "index_infringing_urls_works_on_work_id"

  create_table "notices", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "date_sent"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notices_relevant_questions", :force => true do |t|
    t.integer "notice_id"
    t.integer "relevant_question_id"
  end

  add_index "notices_relevant_questions", ["notice_id"], :name => "index_notices_relevant_questions_on_notice_id"
  add_index "notices_relevant_questions", ["relevant_question_id"], :name => "index_notices_relevant_questions_on_relevant_question_id"

  create_table "notices_works", :id => false, :force => true do |t|
    t.integer  "notice_id"
    t.integer  "work_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "notices_works", ["notice_id"], :name => "index_notices_works_on_notice_id"
  add_index "notices_works", ["work_id"], :name => "index_notices_works_on_work_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item"], :name => "index_rails_admin_histories_on_item"
  add_index "rails_admin_histories", ["month"], :name => "index_rails_admin_histories_on_month"
  add_index "rails_admin_histories", ["table"], :name => "index_rails_admin_histories_on_table"
  add_index "rails_admin_histories", ["year"], :name => "index_rails_admin_histories_on_year"

  create_table "relevant_questions", :force => true do |t|
    t.text "question"
    t.text "answer"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "works", :force => true do |t|
    t.string   "url",         :limit => 1024, :null => false
    t.text     "description"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

end
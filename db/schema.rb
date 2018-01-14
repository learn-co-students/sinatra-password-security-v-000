ActiveRecord::Schema.define(version: 20150916154312) do

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

end
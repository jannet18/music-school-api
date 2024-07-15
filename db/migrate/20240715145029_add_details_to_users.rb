class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :grade, :string
    add_column :users, :guardian_contact, :string
    add_column :users, :subject_specialization, :string
    add_column :users, :qualifications, :string
    add_column :users, :contact_number, :string
  end
end

Sequel.migration do
  up do
    create_table :todos do
      primary_key :id
      String :title
      Boolean :is_completed
    end
  end

  down do
    drop_table :todos
  end
end

Sequel::Model.plugin(:schema)
Sequel::Model.plugin(:timestamps)
Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
Sequel::Model.db = (
  case Padrino.env
  when :development
    Sequel.connect(
      'postgres://nick@localhost/padrino_todos_development',
      loggers: [logger]
    )
  when :production
    Sequel.connect(ENV['DATABASE_URL'])
  when :test
    Sequel.connect(
      'postgres://nick@localhost/padrino_todos_test',
      loggers: [logger]
    )
  end
)

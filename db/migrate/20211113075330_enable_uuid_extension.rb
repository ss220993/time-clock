class EnableUuidExtension < ActiveRecord::Migration[6.0]
  def up
    enable_extension "uuid-ossp"
    enable_extension 'pgcrypto'
  end

  def down
    disable_extension "uuid-ossp"
    enable_extension 'pgcrypto'
  end
end

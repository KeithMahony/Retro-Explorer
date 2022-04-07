# Instructing Rails to store cookie data in projects database, rather than default strategy

Rails.application.config.session_store :active_record_store, :key => 'my_app_session'

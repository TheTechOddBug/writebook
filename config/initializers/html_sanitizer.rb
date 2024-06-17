Rails.application.config.action_view.sanitized_allowed_attributes = Rails::HTML5::SafeListSanitizer.allowed_attributes + %w[ target ]

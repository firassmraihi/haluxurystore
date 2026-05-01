Rails.application.config.after_initialize do
  Spree::Image.attachment_definitions[:attachment][:variants] = {
    mini:    { resize_to_limit: [48, 48] },
    small:   { resize_to_limit: [100, 100] },
    product: { resize_to_limit: [240, 240] },
    large:   { resize_to_limit: [600, 600] },
    big:     { resize_to_limit: [800, 800] }
  }
end
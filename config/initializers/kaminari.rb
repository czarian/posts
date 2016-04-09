#fix conflict with rails_admin will_paginate and kamari
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end


unless Rails.env.development? || Rails.env.test?
  Yabeda::Rails.install!
end

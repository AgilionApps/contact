configure do
  yaml = YAML.load_file('./_config.yml')
  yaml.each_pair do |key, value|
    set key.to_sym, value
  end
end

RSpec::Matchers.define :include_field do |name, value|
  match do |doc|
    field = doc.css("input[name=#{name}]")
    if field.any?
      if value
        field.attribute('value').value.to_s == value
      else
        field.attribute('value').value.to_s != ''
      end
    else
      false
    end
  end

  failure_message_for_should do |actual|
    err = "expected to find #{name} field"
    err << " with value #{value}" if value
    err
  end
end

class DatePickerInput < SimpleForm::Inputs::StringInput
  def input
    value = @builder.object.send(attribute_name)
    input_html_options[:value] = case value
                                   when Date, Time, DateTime
                                     localize(value)
                                   else
                                     value.to_s
                                 end

    input_html_options[:class] ||= []
    input_html_options[:class] << "date_picker_input form-control"
    @builder.text_field(attribute_name, input_html_options)
  end
end
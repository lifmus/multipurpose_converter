class StockItem
  
  def initialize(header_row, data_row)
    unformatted_hash = Hash[header_row.zip(data_row)]
    @main_values     = unformatted_hash
    @modifiers       = unformatted_hash.clone
  end

  def formatted_hash
    main_values["modifiers"] = []
    (1..number_of_modifier_pairs).each do |number|
      if modifiers["modifier_#{number}_name"] || modifiers["modifier_#{number}_price"]
        main_values["modifiers"] << { "name" => modifiers["modifier_#{number}_name"], "price" => modifiers["modifier_#{number}_price"] }
      end
    end
    main_values
  end

  private

  def number_of_modifier_pairs
    modifiers.size / 2
  end

  def main_values
    @main_values.delete_if(&key_contains_modifier)
  end

  def modifiers
    @modifiers.keep_if(&key_contains_modifier)
  end

  def key_contains_modifier
    Proc.new { |key, value| key =~ /modifier_/}
  end

end

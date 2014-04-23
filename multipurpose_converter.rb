require 'csv'
require 'json'
require './stock_item.rb'

module MultipurposeConverter

  input_file  = ARGV[0]
  output_file = ARGV[1]

  master_array = [] #must be an array of hashes to output properly

  case File.extname(input_file)
  when ".csv"
    puts "The input file type is csv"
    case File.basename(input_file)
    when /stock_item/
      puts "Importing stock item file"
      all_rows   = CSV.open(input_file).read
      header_row = all_rows[0]
      data_rows  = all_rows[1..-1]
      data_rows.each do |data_row|
        master_array << StockItem.new(header_row, data_row).formatted_hash
      end
    end
  end

  case File.extname(output_file)
  when ".json"
    puts "The output file type is json"
    File.open(output_file,"w") do |f|
      f.write(master_array.map{ |hash| JSON.pretty_generate(hash)})
      puts "The output has been saved"
    end
  end

end
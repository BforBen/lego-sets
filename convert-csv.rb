#!/usr/bin/env ruby
require 'csv'
require 'json'
require 'safebool'

lines = CSV.read("sets.csv", headers: true)

lines.each{|h| 
h[0] = h[0].to_i
h[5] = h[5].to_i
ins = JSON.parse(h[6]) unless h[6].to_s.strip.empty?
h[6] = ins&.select { |hash| !hash["description"].include?(" V39")  }
h[7] = h[7].to_b
h[8] = h[8].to_b
}

data = lines.map { |row| row.to_hash }

File.open("_data/sets.json", 'w') do |f|
    f.puts JSON.pretty_generate(data)
end

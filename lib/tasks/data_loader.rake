require 'json'
require 'pp'

data_files = {
  crp_farmers_markets: {
    file: 'data_feeds/regional_farmers_market.geojson',
    keymap: {
      lat: lambda { |hash| hash['geometry']['coordinates'][0]},
      long: lambda { |hash| hash['geometry']['coordinates'][1]},
      region: lambda { |hash| hash['properties']['Muni']},
      name: lambda { |hash| hash['properties']['Name']},
      address: lambda { |hash| hash['properties']['Address']},
      type: lambda { |x| "Farmer's Market" },
      source_url: -> { 'http://www.calgaryregionopendata.ca/browse/file/3229' },
      source_name: -> {'CRP Farmers Markets'}
    }
  },
  crp_institution: {
      file: 'data_feeds/regional_institutions.geojson',
      keymap: {
        lat: lambda { |hash| hash['geometry']['coordinates'][0]},
        long: lambda { |hash| hash['geometry']['coordinates'][1]},
        region: lambda { |hash| hash['properties']['MUNI']},
        name: lambda { |hash| hash['properties']['NAME']},
        address: lambda { |hash| hash['properties']['ADDRESS']},
        type: lambda {
          |hash| [hash['properties']['TYPE'], hash['properties']['SUB_TYPE']].compact.join(" - ")
        },
        source_url: -> { 'http://www.calgaryregionopendata.ca/browse/file/6931' },
        source_name: -> {'CRP Institution'}

      }
  }
}

namespace :data_loader do
  desc "Load geo json files for alberta adventure"
  task geo_json: :environment do
    user = User.find_by(username: "DancingBear")

    data_files.each do |key, data|

      collection = Collection.find_or_create_by(name: key, user_id: user)

      keymap = data[:keymap]
      file_name = [Rails.root, data[:file]].join('/')

      file = File.read(file_name)
      data_hash = JSON.parse(file)
      data_hash['features'].each do |feature|
        lat = keymap[:lat].call(feature)
        long = keymap[:long].call(feature)
        region = keymap[:region].call(feature)
        name = keymap[:name].call(feature)
        address = keymap[:address].call(feature)
        type = keymap[:type].call(feature)
        source_name = keymap[:source_name].call()
        source_url = keymap[:source_url].call()

        location_source = LocationSource.find_or_create_by(name: source_name, url: source_url)
        location_type = LocationType.find_or_create_by(name: type)
        region_model = Region.find_or_create_by(name: region)

        location = Location.create(
          name:name,
          address:address,
          lat:lat,
          long:long,
          region_id:region_model,
          location_type_id: location_type,
          location_source_id: location_source
        )

        collection.locations << location
      end
    end
  end
end

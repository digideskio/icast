# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contribution do
    user                { User.all.sample }
    contributable       { Station.all.sample }

    data                { { name: "Contributed Name" } }
  end

  factory :contribution_new_content, class: "Contribution" do
    user                { User.all.sample }
    contributable_type  { 'Station' }

    data                do
      attributes = FactoryGirl.attributes_for(:station)
      attributes['details_attributes'] = FactoryGirl.attributes_for(:station_details, station: nil)
      attributes['streams_attributes'] = [ FactoryGirl.attributes_for(:stream, station: nil) ]
      attributes
    end
  end
end

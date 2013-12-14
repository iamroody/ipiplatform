FactoryGirl.define do
  factory :resource do
    name 'resource_name'
    description 'resource_description'
    image 'image'
    full_description 'resource_full_description'
    link 'resource_link'
    source 'resource_source'
    tag_list 'resource_tag_list'
    user_id 1
  end
end
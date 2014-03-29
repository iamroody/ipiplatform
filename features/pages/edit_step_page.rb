class EditStepPage < SitePrism::Page
  set_url "/journeys{/journey_id}/steps{/id}/edit"
  set_url_matcher /\/journeys\/\d+\/steps\/\d+\/edit/

  elements "resources_to_edit", "a.edit"
  element "resource_name", "#resource_name"
  elements "resource_names", "a.step_resources"
  elements "resources_to_delete", "a.delete"
  elements "step_resource", "a.step_resource"
  elements "step_resources", "a.step_resources"

  element :name, "#step_name"
  element :save_button, "input[value='Save']"
  element :add_existing_resource_link, "a.add_existing_resources"

  elements :show_resource_links, ".show_resource"
end

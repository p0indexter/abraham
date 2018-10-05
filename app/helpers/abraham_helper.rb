# frozen_string_literal: true
module AbrahamHelper
  def abraham_tour
    puts "AbrahamHelper"
    puts "controller_name: #{controller_name}"
    puts "action_name: #{action_name}"
    puts "controller_path: #{controller_path}"
    puts "AbrahamHelper"

    # Do we have tours for this controller/action in the user's locale?
    tours = Rails.configuration.abraham.tours["#{controller_name}.#{action_name}.#{I18n.locale}"]

    unless tours
      # How about the default locale?
      tours = Rails.configuration.abraham.tours["#{controller_name}.#{action_name}.#{I18n.default_locale}"]
    end

    if tours
      completed = AbrahamHistory.where(
        creator_id: current_user.id,
        controller_name: controller_name,
        action_name: action_name
      )
      remaining = tours.keys

  
      # Generate the javascript snippet for the next remaining tour
      render(partial: 'application/abraham',
             locals: { tour_name: remaining.first,
                       steps: tours[remaining.first]['steps'] })
      
    end
  end
end

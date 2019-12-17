module ConferencesHelper

  def conference_json_index conferences
    json = Jbuilder.new
    json.array conferences do |conference_model|
      present(conference_model) do |conference| 
        json.id conference.id
        json.name conference.name
        json.status conference.status
        json.message conference.message
        json.counter conference.counter
      end
    end
  end

  def conference_json_show conference_model
    json = Jbuilder.new
    json.object do 
      present(conference_model) do |conference|
        json.id conference.id
        json.name conference.name
        json.status conference.status
        json.message conference.message
        json.counter conference.counter
        json.members conference.members do |member_model|
          present(member_model) do |member|
            json.id member.id
            json.name member.name
            json.status member.status
          end
        end
      end
    end
  end
end

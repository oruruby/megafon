module ConferencesHelper

  def member_json_show member_model
    json = Jbuilder.new
    json.object do 
      present(member_model) do |member|
        json.id member.id
        json.name member.name
        json.status member.status
        json.mute_status member.mute_status
      end
    end
  end
end

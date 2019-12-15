present(@conference) do |conference|
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
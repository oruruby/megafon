json.array! @conferences do |conference_model|
  present(conference_model) do |conference|
    json.id conference.id
    json.name conference.name
    json.status conference.status
    json.message conference.message
    json.counter conference.counter
  end
end
class MegafonController < ApplicationController
  def callback
    puts "\\/"
    puts data
    puts "========"
    puts "Method: #{method}"
    puts "Token: #{token}"
    puts "/\\"

    if token
      conference_id = token.split("_")[1].to_i
      conference_action = token.split("_")[2]
      conference = Conference.find(conference_id)
      if conference_action == 'confMake'
        if data["result"]
          if data["result"]["data"]
            if data["result"]["data"]["conf_session"]
              conference.activate! do
                conference.conf_session = data["result"]["data"]["conf_session"]
              end
            else
              throw 'data["result"]["data"]["conf_session"] is nil'
            end
          else
            throw 'data["result"]["data"] is nil'
          end
        else
          throw 'data["result"] is nil'
        end
      elsif conference_action == 'confDestroy'
        if data["result"]
          conference.inactivate! do 
            conference.conf_session = nil
          end
        else
          throw 'Unknown data in confDestroy'
        end
      elsif conference_action == 'confStatusGet'
        if data["result"]
          throw 'Not released action in confStatusGet result'
        elsif data["error"]
          if data["error"]["code"] == -5
            conference.inactivate! do 
              conference.conf_session = nil
            end
          elsif data["error"]["code"] == -3
            conference.inactivate! do
              conference.conf_session = nil
            end
          else
            throw 'Unknown code in error confStatusGet'
          end
        else
          throw 'Unknown data in confStatusGet'
        end
      else
        throw "Unknown action #{conference_action}"
      end
    else
      
    end
  end

  private 

  def token
    data["id"]
  end

  def data
    JSON.parse(params[:_json])
  end

  def method
    data["method"]
  end
end
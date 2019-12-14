require 'faye/websocket'
require 'eventmachine'

class StartConferenceJob < ApplicationJob
  queue_as :default

  def perform(conference)
    EM.run {
      client = Megafone.new

      client.handle('onClose', -> params {
        conference.
        EM.stop
      })

      client.handle('onOpen', -> params {
        client.request('confMake')
      })

      client.handle('onCallAnswer', -> params {
        client.request('callFilePlay', {call_session: params.call_session, file: 'welcone.pcm'})
      })

      client.handle('onCallFilePlay', -> params {
        client.request('confAdd', { conf_session: @conf_session, call_session: params.call_session })
      })
      
      client.handle('onConfMake', -> params {
        @conf_session = params.conf_session
        client.request('confBroadcastConnect', {
          conf_session: @conf_session
        })
        conference.members do |member|
          client.request('callMake', {
            bnum: member.phone
          })
        end
      })

      client.open()
      }
  end

end

class Megafone
  
  def initialize
    @counter = 0
    @handlers = {}
  end

  def handle name, handler
    @handlers[name] = handler
  end

  def request method, params
    request_data = { id: ++@counter, jsonrpc: '2.0', method: method, params: params }
    @ws.send(request_data.to_json)
  end

  def close

    @ws.close()
  end

  def open
    @ws = Faye::WebSocket::Client.new('ws://testapi.megafon.ru/v1')
    @ws.on :open do |event|
      @handlers[:onOpen]() if @handlers[:onOpen]
    end
    @ws.on :close do |event|
      @handlers[:onClose]() if @handlers[:onClose]
    end
    @ws.on :message do |message|
      message_data = JSON.parse(message[:data])
      if message_data[:result]
        @handlers[:onSuccess](message_data[:result]) if @handlers[:onSuccess] 
      elsif message_data[:error]
        @handlers[:onError](message_data[:error]) if @handlers[:onError]
      elsif message_data[:method]
        @handlers[message_data[:method].to_sym](data.params) if @handlers[message_data[:method].to_sym]
      else
        throw 'Something wrong'
      end
    end
  end

end
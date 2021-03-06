require "external_param_validator/version"

module ExternalParamValidator

  def url_string(device_id)
      if ENV["URL_DEVICE_AUTH"]
        "#{ENV["URL_DEVICE_AUTH"]}/#{device_id}"
      else
        "http://localhost:3001/api/v1/terminals/#{device_id}"
      end
  end

    def check_external_param()
      if request.headers["Device-id"]
        device =  HTTParty.get(url_string(request.headers["Device-id"]))
        if device.present?
          device
        else
          render nothing: true, status: :not_found
        end
      end
    end
end

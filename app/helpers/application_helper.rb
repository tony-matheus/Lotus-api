module ApplicationHelper

  def render_json(code,msg)
      render :json => {
       :status => code,
       :message => msg
      }.to_json
    end

end

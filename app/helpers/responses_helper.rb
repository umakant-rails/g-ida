module ResponsesHelper
  def poll_response_with_option(poll)
    poll.responses.select("answer_id, count(*) as count").group("answer_id")
  end

end

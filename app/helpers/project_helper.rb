module ProjectHelper

  def project_status(project)
    if (project.expected_start_date < Date.today) && (project.expected_completion_date > Date.today)
      "In progress"
    elsif project.expected_completion_date < Date.today
      "Completed"
    elsif project.expected_start_date > Date.today
      "In planning"
    end
  end

end

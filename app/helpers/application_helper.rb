module ApplicationHelper
  ALERT_TYPES = [:success, :info, :warning, :danger] unless const_defined?(:ALERT_TYPES)

  def bootstrap_flash(options = {})
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :danger  if type == :alert
      type = :danger  if type == :error
      next unless ALERT_TYPES.include?(type)

      tag_class = options.extract!(:class)[:class]
      tag_options = {
        class: "alert fade in alert-#{type} #{tag_class}"
      }.merge(options)

      close_button = content_tag(:button, raw("&times;"), type: "button", class: "close", "data-dismiss" => "alert")

      Array(message).each do |msg|
        text = content_tag(:div, close_button + msg, tag_options)
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end

  def s3_link(tenant_id, artifact_key)
    label = File.basename(URI.parse(artifact_key).path)
    link_to label, "#{artifact_key}", target: 'new'
  end

  def member_name(user)
    member = Member.where(tenant_id: user.tenants.first.id, user_id: user.id).first
    "#{member.first_name} #{member.last_name}"
  end

  def organization_name(current_user)
    if session[:tenant_id]
      Tenant.set_current_tenant session[:tenant_id]
    else
      Tenant.set_current_tenant current_user.tenants.first
    end
    Tenant.current_tenant.name
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def project_status(project)
    if (project.expected_start_date <= Date.today) && (project.expected_completion_date >= Date.today)
      "In progress"
    elsif project.expected_completion_date < Date.today
      "Completed"
    elsif project.expected_start_date > Date.today
      "In planning"
    end
  end

  def completed_tasks_percentage(project)
    if project.tasks.count > 0 && project.tasks.published.count > 0
      percentage = (project.tasks.count / project.tasks.published.count) * 100
    else
      percentage = 0
    end
    "#{percentage}"
  end

  def task_progress_percentage(task)
    if task.status == "defined"
      "0"
    elsif task.status == "in_progress"
      "20"
    elsif task.status == "completed"
      "40"
    elsif task.status == "account_acceptance"
      "60"
    elsif task.status == "client_acceptance"
      "80"
    elsif task.status == "published"
      "100"
    end
  end

  def humanize(text)
    "#{text.humanize}"
  end
end

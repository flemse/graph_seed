def flightlogger
  "company_1 = Company.create!(name: \"Flightlogger\")"
end

def flemming
  "employee_1 = Employee.create!(company: company_1, lucky_numbers: [1, 2, 3, \"nan\"], name: \"Flemming\")"
end

def kenneth
  "employee_2 = Employee.create!(company: company_1, name: \"Kenneth\", admin: true)"
end

def project_1
  "project_1 = Project.create!(employee: employee_1, field_with_stupid_name_id: 20, name: \"Sms\")"
end

def settings
  "settings_1 = Settings.create!(company: company_1)"
end

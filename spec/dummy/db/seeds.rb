# ruby encoding: utf-8

Company.create!(
  name: "Flightlogger",
  employees: Employee.create!([
    {
      name: "Flemming",
      projects: Project.create!([
        {
          name: "Sms"
        }
      ])
    }
  ])
)

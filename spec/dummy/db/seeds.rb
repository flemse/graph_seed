# ruby encoding: utf-8

Company.create!(
  name: "Flightlogger",
  employees: Employee.create!([
    {
      name: "Flemming",
      lucky_numbers: [1, 2, 3, "nan"],
      projects: Project.create!([
        {
          name: "Sms"
        }
      ])
    }
  ])
)

# ruby encoding: utf-8

Company.create!(
  name: "Flightlogger",
  settings: Settings.create!(),
  employees: Employee.create!([
    {
      name: "Flemming",
      lucky_numbers: [1, 2, 3, "nan"],
      tags: Tag.create!([{name: "test"}]),
      projects: Project.create!([
        {
          name: "Sms",
          field_with_stupid_name_id: 20
        }
      ])
    },
    {
      name: "Kenneth",
      admin: true
    }
  ])
)

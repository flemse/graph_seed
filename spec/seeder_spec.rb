require "spec_helper"

describe GraphSeed::Seeder do
  it "Create seeds from company" do
    gs = GraphSeed::Seeder.new(Company.first)

    seed = gs.to_seed

    expect(seed).to eq([
      "company_1 = Company.create!(name: \"Flightlogger\")",
      "employee_1 = Employee.create!(company: company_1, lucky_numbers: [1, 2, 3, \"nan\"], name: \"Flemming\")",
      "project_1 = Project.create!(employee: employee_1, name: \"Sms\")"
    ])
  end

  it "Create seeds but without projects" do
    gs = GraphSeed::Seeder.new(Company.first, ignored: { projects: true } )

    seed = gs.to_seed

    expect(seed).to eq([
      "company_1 = Company.create!(name: \"Flightlogger\")",
      "employee_1 = Employee.create!(company: company_1, lucky_numbers: [1, 2, 3, \"nan\"], name: \"Flemming\")"
    ])

  end
end

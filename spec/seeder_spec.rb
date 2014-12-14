require "spec_helper"

describe GraphSeed::Seeder do
  it "Create seeds from only one level" do
    gs = GraphSeed::Seeder.new(Company.first, max_depth: 0)
    expect(gs.to_seed).to eq([
      "company_1 = Company.create(name: \"Flightlogger\")",
      "employee_1 = Employee.create(company: company_id, name: \"Flemming\")"
    ])
  end
end

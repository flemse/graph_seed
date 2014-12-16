require "spec_helper"

describe GraphSeed::Seeder do
  it "Create seeds from company" do
    gs = GraphSeed::Seeder.new(Company.first)

    seed = gs.to_seed

    expect(seed).to eq([
      flightlogger,
      flemming,
      tag_1,
      project_1,
      kenneth,
      settings
    ])
  end

  it "Create seeds but without projects" do
    gs = GraphSeed::Seeder.new(Company.first, ignored: { projects: true } )

    seed = gs.to_seed

    expect(seed).to eq([
      flightlogger,
      flemming,
      tag_1,
      kenneth,
      settings
    ])
  end
end

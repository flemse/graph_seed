require "spec_helper"

describe "Reseed database" do
  it "recreates database" do
    gs = GraphSeed::Seeder.new(Company.first)
    records_before_test = count_models

    seed = gs.to_seed

    path = GraphSeed.root_path + "/tmp/seeds.rb"

    File.open(path, "w") do |f|
      f << seed.join("\n")
    end

    DatabaseCleaner.clean_with :truncation
    Rails.application.load path

    expect(count_models).to eq(records_before_test)
  end
end

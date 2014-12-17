desc "Create seed file from existing data"
task graph_seed: :environment do
  seeds = GraphSeed::Seeder.new(Account.where(subdomain: "test").first, verbose: true, ignored: { versions: true, attachable: true } ).to_seed
  File.open("test_seeds.rb", "w") do |f|
    f << seeds.join("\n")
  end
end

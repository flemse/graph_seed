desc "Create seed file from existing data"
task graph_seed: :environment do
  seeds = GraphSeed::Seeder.new(Account.where(subdomain: "fl").first, verbose: true, ignored: { versions: true } ).to_seed
  File.open("test_seeds.rb", "w") do |f|
    f << seeds.join("\n")
  end
end

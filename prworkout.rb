require 'httparty'

count = 0
access_token = YAML.load_file(File.join('config', 'keys.yml'))['access_token']
repos = YAML.load_file(File.join('config', 'repos.yml'))['repos']

repos.each do |repo|
  repo_path = "https://api.github.com/repos/#{repo}/pulls?access_token=#{access_token}&state=open"
  response = HTTParty.get(repo_path, headers: { 'User-Agent' => 'Ruby/PullRequestWorkout' })
  count += response.parsed_response.count
  puts "#{repo} has #{response.parsed_response.count} open pull requests."
end

puts ''
puts "You need to complete #{count} pull request workout sets this week!"
puts ''

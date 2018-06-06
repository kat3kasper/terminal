SKILLS = ['AR', 'VR', 'Cybersecurity', 'Management', 'Kubernetes', 'Docker', 'Architecture', 'Mentorship', 'AWS', 'Java', 'Python', 'C', 'Ruby', 'Javascript', 'JQuery', 'AngularJS', 'Node.js', 'React', 'PHP', 'WordPress', 'HTML', 'CSS', 'Objective-C', 'Swift', 'iOS', 'Android', 'Kotlin', 'SQL', '.NET', 'R', 'Perl', 'MATLAB', 'Erlang', 'Scala', 'Bash', 'Clojure', 'Haskell', 'Groovy', 'DevOps', 'Systems', 'Apex', 'SAS', 'Crystal', 'git', 'GitHub', 'Project Management', 'Product Management', 'Engineering Management', 'CTO', 'User Experience Design / UX', 'User Interface Design / UI', 'Quality Assurance / QA', 'Automated QA', 'Ruby on Rails', 'SaaS', 'React Native', 'Technical Sales', 'Outbound Sales', 'Business Development', 'Training', 'Django'].freeze

EMPLOYMENT_TYPE = ['full-time', 'part-time', 'contract', 'temporary', 'seasonal', 'internship'].freeze

BENEFITS = ['Office Dogs', 'Equity', 'Remote', '30+ Days Parental Leave', '60+ Days Parental Leave', '90+ Days Parental Leave', 'Flexible Hours', 'Social Mission', 'Environmental Mission', '401(k)', '401(k) Matching', "100\% Covered Health Insurance", "80\%+ Covered Health Insurance", 'Dental Insurance', 'Vision Insurance', 'Life Insurance', 'Trans-Inclusive Healthcare', 'Professional Development Budget', 'Unlimited Vacation', '30+ Days Vacation', 'Lunch Provided', 'Beach Within 60 Minutes', 'Mountain Within 60 Minutes', 'In-Office Gym', 'Flat Heirarchy', 'Commuter Coverage'].freeze

CULTURES = ['family-like team', 'Cubicles', 'No cubicles' , 'company outings' , 'beer on tap', 'ping pong', 'Game Nights', 'pair programming', 'not pair programming'].freeze

SKILLS.each do |skill|
  Competence.create(value: skill)
end

p "Created #{Competence.all.count} competence"

BENEFITS.each do |value|
  Benefit.create(value: value)
end

p "Created #{Benefit.all.count} benefits"


CULTURES.each do |value|
  Culture.create(value: value)
end

p "Created #{Culture.all.count} cultures"


10.times do
  company = Company.create(url: Faker::Internet.url, name: Faker::Company.name)
  puts "created company #{company.name}"
end

Company.all.each do |company|
  10.times do
    cultures = []
    benefits = []
    skills = []
    remote = [['remote'], ['office'], %w[remote office]]
    salary = [10_000, 20_000, 30_000, 40_000, 50_000, 60_000]
    rand(2..5).times do
      cultures << Culture.find(rand(1..Culture.count)).value
    end
    rand(2..5).times do
      benefits << Benefit.find(rand(1..Benefit.count)).value
    end
    job = Job.new(
      title: Faker::FamilyGuy.character,
      description: Faker::Lorem.paragraph(2, false, 4),
      remote: remote.sample,
      city: 'Los Angeles',
      zip_code: '90009',
      state: 'California',
      country: 'United States',
      employment_type: EMPLOYMENT_TYPE.sample,
      level: rand(1..5),
      latitude: nil,
      longitude: nil,
      max_salary: salary.sample,
      benefits: benefits,
      cultures: cultures,
      can_sponsor: Faker::Boolean.boolean(0.2),
      company: company
    )

    job.save
    puts "created job #{job.title}"
    job.skills.new(name: SKILLS.sample, level: rand(1..4)).save

  end

end
#
p "Creating Developer"

50.times do

    dev = Developer.create!(
    email: Faker::Internet.email,
    password: 'Developer9)',
    password_confirmation: 'Developer9)',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city: 'Los Angeles',
    zip_code: '90009',
    country: 'United States',
    need_us_permit: Faker::Boolean.boolean(0.2),
    min_salary: salary = [10_000, 20_000, 30_000].sample,
    level: rand(1..5),
    remote: [['remote'], ['office'], %w[remote office]].sample,
  )

3.times do
  a = dev.skills.new(name: SKILLS.sample, level: rand(3..5))
  dev.password = 'Developer1!'
  dev.save
  a.save
end
 p "One developer created"
end

Developer.check_for_first_matches

30.times do
  Application.create(match: Match.all.sample, message: "Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur sodales ligula in libero. Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor. Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa. Fusce ac turpis quis ligula lacinia aliquet. Mauris ipsum. Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh.")
end

20.times do
a = Recruiter.new(email: Faker::Internet.email, password: "Recruiter9)" , password_confirmation:  "Recruiter9)" )
Employee.create(company: Company.all.sample, recruiter: a)
end

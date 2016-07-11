user = User.create!(
  { username: "Bob", password: "b", password_confirmation: "b", bio: "I'm a builder. I build things", avatar: Rails.root.join('app', 'assets', 'images', 'Bob', 'avatar.jpg') }
)

Dir.mkdir(Rails.root.join('app', 'assets', 'images', 'Bob')) unless Dir.exist? Rails.root.join('app', 'assets', 'images', 'Bob')
`wget -O #{Rails.root.join('app', 'assets', 'images', 'Bob', 'avatar.jpg')} https://i.ytimg.com/vi/5TX28dM8mf0/maxresdefault.jpg`

tasks=user.tasks.create!([
  { name: "Build house" },
  { name: "Fitness goals" },
  { name: "SF Trip" }
])

subtasks=tasks[0].subtasks.create!([
  { name: "Foundation", percent: 25.0 },
  { name: "Framing", percent: 25.0 },
  { name: "Roofing", percent: 25.0 },
  { name: "Finish up", percent: 25.0 }
])

subtasks[1].children.build([
  { name: "West Wall", percent: 25.0 },
  { name: "North Wall", percent: 25.0 },
  { name: "East Wall", percent: 25.0 },
  { name: "South Wall", percent: 25.0 }
]).each{|x| x.save}

subtasks[2].children.build([
  { name: "West Facing", percent: 50.0 },
  { name: "East Facing", percent: 50.0 }
]).each{|x| x.save}

subtasks[3].children.build([
  { name: "Wiring", percent: 33.3333333 },
  { name: "Plumbing", percent: 33.3333333 },
  { name: "Furnishing", percent: 33.3333333 }
]).each{|x| x.save}

subtasks=tasks[1].subtasks.create!([
  { name: "Running", percent: 25.0 },
  { name: "Sit-ups", percent: 25.0 },
  { name: "Push-ups", percent: 25.0 },
  { name: "Squats", percent: 25.0 }
])

subtasks[0].children.build([
  { name: "1/4 mi per day", percent: 25.0 },
  { name: "1/2 mi per day", percent: 25.0 },
  { name: "1 mi per day", percent: 25.0 },
  { name: "2 mi per day", percent: 25.0 }
]).each{|x| x.save}

subtasks[1].children.build([
  { name: "20 per day", percent: 25.0 },
  { name: "40 per day", percent: 25.0 },
  { name: "60 per day", percent: 25.0 },
  { name: "80 per day", percent: 25.0}
]).each{|x| x.save}

subtasks[2].children.build([
  { name: "10 per day", percent: 25.0 },
  { name: "20 per day", percent: 25.0 },
  { name: "30 per day", percent: 25.0 },
  { name: "40 per day", percent: 25.0 }
]).each{|x| x.save}

subtasks[3].children.build([
  { name: "10 per day", percent: 25.0 },
  { name: "20 per day", percent: 25.0 },
  { name: "30 per day", percent: 25.0 },
  { name: "40 per day", percent: 25.0 }
]).each{|x| x.save}

subtasks=tasks[2].subtasks.create!([
  { name: "Golden Gate Park", percent: 25.0 },
  { name: "Giants!", percent: 25.0 },
  { name: "Alcatraz", percent: 25.0 },
  { name: "Exploratorium", percent: 25.0 }
])

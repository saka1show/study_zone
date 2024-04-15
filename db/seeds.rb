# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

subjects = [
  { subject_name: '国語' },
  { subject_name: '数学' },
  { subject_name: '理科' },
  { subject_name: '社会' },
  { subject_name: '英語' },
  { subject_name: '情報' },
  { subject_name: 'その他' }
]

subjects.each do |subjects|
  Subject.find_or_create_by!(subject)
end
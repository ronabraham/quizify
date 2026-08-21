require "csv"
require "mysql2"
require "securerandom"
require "date"
#read the data from csv
filename = ARGV[0] ? ARGV[0] : "Quizify_data.csv"

#read the csv file into an IOObject
data_file = File.read(filename)

#print data_file
#create a csv instance
csv = CSV.new(data_file,headers: true)

#1 - Create a Questionnaire record
uid = SecureRandom.uuid
created_at = DateTime.now
notes = filename
status = "draft"
client = Mysql2::Client.new(:host => "localhost", :username => "ron", :password => 'ron', :database => 'quizify', :symbolize_keys =>'true')
client.query("INSERT INTO quiz_questionnaire(uid,created_at,notes,status) 
	VALUES ('#{uid}','#{created_at}','#{notes}','#{status}')")
puts  "Rows affected: #{client.affected_rows}"
puts "Last Client Id : #{client.last_id}"
questionnaire_id = client.last_id

#2 - Create a set of question records for questionnaire (id) created 
csv.each do |row|
#Construct the record
	uid = SecureRandom.uuid
	category = row.to_hash["Category"]
	text = client.escape(row.to_hash["Question_Text"])
	answer = row.to_hash["Correct_Answer"]
	option_1 = row.to_hash["Incorrect_Options"]
	notes = row.to_hash["Notes"]
	difficulty = row.to_hash["Difficulty"]
	qn_number = csv.lineno()-1 #due to headers:true , the starting line number will always be 2
	insert_query = "INSERT INTO quiz_questions(uid,qn_no,questionnaire_id,category,text,notes,difficulty) VALUES ('#{uid}',#{qn_number},#{questionnaire_id},'#{category}','#{text}','#{notes}','#{difficulty}')"
	puts "insert_query : #{insert_query}"
	puts "inserting question no: #{qn_number} : #{text} for quiz_questionnaire no #{questionnaire_id}"
	client.query(insert_query)

	#client.query("INSERT INTO quiz_questions(uid,qn_no,questionnaire_id,category,text,notes,difficulty)VALUES('#{uid}',#{qn_number},#{questionnaire_id},'#{category}','#{text}','#{notes}','#{difficulty}'")
	#client.query("INSERT INTO quiz_questions(uid,qn_no,questionnaire_id,category,text,notes,difficulty) VALUES
end
csv.close
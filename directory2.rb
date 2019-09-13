@students = []

def input_students
   puts "Please enter the name of the student"
   puts "To finish, just hit return twice"
   months = [
       "january",
       "february",
       "march",
       "april",
       "may",
       "june",
       "july",
       "august",
       "september",
       "october",
       "november",
       "december"
       ]
   name = gets.chomp
   while !name.empty? do
     while true do
       puts "Please enter a cohort month. If unknown, a default value will be set."
       cohort = gets.chomp
       if months.include?(cohort)
           cohort = cohort.to_sym
           break
       elsif cohort.empty?
         cohort = :september
         break
       else
            puts "ERROR, month not recognised"
       end
     end
     puts "Please enter any defining features"
     features = gets.chomp
     @students << {name: name, cohort: cohort, features: features}
     if @students.count == 1
       puts "Now we have 1 student. Enter another?"
     else
       puts "Now we have #{@students.count} students. Enter another?"
     end
     name = gets.chomp
   end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "9. Exit"
end

def show_students
    print_header
    print_student_list
    print_footer
end

def process(selection)
  case selection
  when "1"
    $students = input_students
  when "2"
    show_students
  when "3"
    save_students
  when "9"
      exit
  else
      puts "I don't know what you meant, try again"
  end
end

def print_header
    puts "The students of Villains Academy"
    puts "-------------"
end

def print_student_list
  if @students.count > 0
    count = 1
    while count <= @students.count
      if ((@students[count - 1][:name]).split("")).count < 12
        puts "#{@students[count - 1][:name]}, #{@students[count - 1][:cohort]}, (#{@students[count - 1][:features]})".center(30)
      end
      count += 1
    end
  end
end

def print_footer
    puts "Overall we have #{@students.count} great students".center(30)
end

interactive_menu

def save_students
    file = File.open("students.csv", "w")
    @students.each do |student|
      student_data = [student[:name], student[:cohort], student[:features]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
    file.close
end
#cohorts = []
#@students.each { |x| cohorts << x[:cohort] }
#sorted_cohorts = cohorts.uniq
#sorted_cohorts.each do |month|
#   puts "#{month} cohort: " + @students.select{|n| n[:cohort] == month}.map{|y| y[:name]}.to_s
#   end
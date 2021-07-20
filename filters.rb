# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

def find(id)
  @candidates.detect {|candidates| candidate[:id] == id}
end

def experienced?(candidate)
  candidate [:years_of_experience] >= 2
end

def qualified_candidates(candidates)
  @candidates.select do |candidate|
    experienced?(candidate) &&
    points_over_100(candidate) &&
    ruby_or_python(candidate) &&
    applied_recently(candidate) &&
    age_over_17(candidate)
  end
end

def points_over_100(candidate)
  candidate [:github_points].to_i >= 100
end

def ruby_or_python(candidate)
  candidate [:languages].include? 'Ruby' || 'Python'
end

def applied_recently(candidate)
  candidate [:date_applied] >= 15.days.ago.to_date
end

def age_over_17(candidate)
  candidate [:age] > 17
end

def ordered_by_qualifications(candidates)
  candidates.sort do |first, second|
    if first[:years_of_experience] == second[:years_of_experience]
      second[:github_points] <=> first[:github_points]
    else 
      second[:years_of_experience] <=> first[:years_of_experience]
    end
  end
end

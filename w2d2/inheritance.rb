class Employee
  attr_reader :name, :title, :salary
  attr_accessor :boss

  def initialize(name, title, salary, boss)
    @name, @title, @salary, @boss = name, title, salary, boss
  end

  def bonus(multiplier)
    salary * multiplier
  end
end

class Manager < Employee
  def initialize(name, title, salary, boss, employees = [])
    super(name, title, salary, boss)
    @employees = employees
    @employees.each { |employee| employee.boss = self }
  end

  def bonus(multiplier)
    employee_salaries * multiplier
  end

  def employee_salaries
    total = 0
    @employees.each do |employee|
      if employee.is_a? Manager
        total += employee.salary + employee.employee_salaries
      else
        total += employee.salary
      end
    end
    total
  end
end

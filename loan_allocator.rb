class Loan
  attr_accessor :id, :category, :grade, :amount, :allocated

  def initialize(id, category, grade, amount)
    @id = id
    @category = category
    @grade = grade
    @amount = amount
    @allocated = false
  end
end

class Investor
  attr_accessor :name, :available_funds

  def initialize(name, available_funds, criteria)
    @name = name
    @available_funds = available_funds
    @criteria = criteria
    @available_category = set_available_category
  end

  def set_available_category
    # Set amount limit for each individual category if applicable
    return {} if (!@criteria[:category] || @criteria[:category].empty?)
    available_category = {}
    @criteria[:category].each do |category|
      if category[:percent]
        available_category[category[:name]] = (category[:percent] * @available_funds)
      end
    end
    available_category
  end

  def can_fund_loan?(loan)
    # Only allow investors with available funds to invest
    @available_funds >= loan.amount
  end

  def category_criteria(loan)
    # Only allow investors with matching category to invest
    return true if (!@criteria[:category] || @criteria[:category].empty?)
    @criteria[:category].each do |category|
        if loan.category.downcase.eql?(category[:name].downcase)
          return true unless category[:percent]
          if @available_category[category[:name]] >= loan.amount
            @available_category[category[:name]] -= loan.amount
            return true
          end
        end
    end
    false
  end

  def grate_criteria(loan)
    # Only allow investors with matching grade to invest
    return true if (!@criteria[:grade] || @criteria[:grade].empty?)
    @criteria[:grade].each do |grade|
        return true if loan.grade.downcase.eql?(grade.downcase)
    end
    false
  end
end


class LoanAllocator
  def initialize(loans, investors)
    @loans = loans
    @investors = investors
  end

  def allocate_loans
    # Allocates loans based on various criteria and return hash of all investors along with ids of the loans they invested in
    allocated_loans = Hash.new { |hash, key| hash[key] = [] }
    @investors.each do |investor|
      @loans.each do |loan|
        if investor.grate_criteria(loan) && investor.can_fund_loan?(loan) && !loan.allocated && investor.category_criteria(loan)
          allocated_loans[investor.name] << loan.id
          investor.available_funds -= loan.amount
          loan.allocated = true
        end
      end
    end
    allocated_loans
  end
end

# Example test case
# loan1 = Loan.new(1,'property','a',1000)
# loan2 = Loan.new(2,'property','b',2000)
# loan3 = Loan.new(3,'retail','c',3000)
# loan4 = Loan.new(4,'property','b',2000)
# loan5 = Loan.new(5,'retail','a',3000)
# loan6 = Loan.new(6,'retail','b',2000)

# The criteria attribute should be a hash with keys category and grade
# The grade should have an array of loan grades which the investor is willing to invest in
# The category should be an array of hashes of loan categories which the investor is willing to invest in
# It contains name property of the category and an optional percentage if there is any limit on percent of total funds the investor can invest in a particular property
# investor1 = Investor.new('Bob',10000,{category: [{name: 'property', percent: 0.4}]})
# investor2 = Investor.new('Susan',5000,{category: [{name: 'property'},{name: 'retail'}]})
# investor3 = Investor.new('George',3000,{grade: ['A']})

# puts LoanAllocator.new([loan1,loan2,loan3,loan4,loan5,loan6],[investor1,investor2,investor3]).allocate_loans
# {"Bob"=>[1, 2], "Susan"=>[3, 4], "George"=>[5]}

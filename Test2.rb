require 'pdf-reader'
reader = PDF::Reader.new('C:\Users\Sheikh Ans\Desktop\Ruby Tests\17423_2019-07-08_N11.pdf')
#gem update --system 3.4.4
response = ""
reader.pages.each do |page|
    
    response =page.text
end
petitioner = ""
if response.include? ")"
    petitioner = response[0, response.index(")")] 
    if petitioner.include? "\n"
        petitioner = petitioner[petitioner.index("\n")+"\n".length, petitioner.size-1].strip 
    end
    petitioner.gsub! ',', ''
end

respondent = ""
if response.include? "Appellate Rule 209(b)"
    respondent = response[response.index("Appellate Rule 209(b)")+"Appellate Rule 209(b)".length,response.size-1] 
    if respondent.include? ")"
        respondent = respondent[0, respondent.index(")")].strip
    end
    respondent.gsub! ',', ''
end

amount =""
if response.include? " $"
    amount = response[response.index(" $"),response.size-1].strip 
    if amount.include? " "
        amount = amount[0, amount.index(" ")]
    end
end
date =""
if response.include? "Date of Judgment:"
    date = response[response.index("Date of Judgment:")+"Date of Judgment:".length,response.size-1].strip 
    if date.include? "\n"
        date = date[0, date.index("\n")].strip
    end
end
if date == ""
    if response.include? "Date of Notice:"
        date = response[response.index("Date of Notice:")+"Date of Notice:".length,response.size-1].strip
        if date.include? "\n"
            date = date[0, date.index("\n")].strip
        end
    end
end
# puts petitioner
# puts respondent
# puts date
# puts amount
data = {
    :petitioner => petitioner,
    :respondent => respondent,
    :date => date,
    :amount => amount
}
puts data

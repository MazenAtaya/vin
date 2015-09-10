module Constants

@@NAME_MIN_LENGTH = 3
@@NAME_MAX_LENGTH = 50

@@NOTE_MIN_LENGTH = 128
@@NOTE_MAX_LENGTH = 1024

@@DAYS = [:Mon, :Tue, :Wed, :Thu, :Fri, :Sat ]

@@TIMES = [:AM, :PM]

@@SELECTIONS = [:AR, :AW, :RW]

@@MONTHS = [:Jan,	:Feb,	:Mar,	:Apr,	:May,	:June, :July,	:Aug,	:Sep,	:Oct,	:Nov,	:Dec]

@@STATUSES = [:Pending, :Delivered, :Returned, :Cancelled]

@@BANNED_STATES = ["Alabama", "Arkansas", "Delaware", "Kentuky", "Massachusetts", "Mississippi", "Oklahoma", "Pennsylvania", "South Dakota", "Utah"]
@@BANNED_STATES += ["AL", "AR", "DE", "KY", "MA", "MS", "OK", "PA", "SD", "UT" ]

@@STATES = ["Alaska","Arizona","California","Colorado","Connecticut","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Louisiana","Maine","Maryland","Michigan","Minnesota","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oregon","Rhode Island","South Carolina","Tennessee","Texas","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
@@STATES += ["AK","AZ","CA","CO","CT","FL","GA","HI","ID","IL","IN","IA","KS","LA","ME","MD","MI","MN","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OR",	"RI","SC","TN","TX","VT","VA","WA","WV","WI","WY"]
end

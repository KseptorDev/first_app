class ApplicationController < ActionController::Base
  protect_from_forgery
  include BothHelper
  include TegsHelper
  include LinksHelper
  include TempHelper
  

end
    

# ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAtzF8V5c5w/0v9PD21q39dYP8JaHesy4ujOKs0ka/Pyx3Xigj6T3CBr4jkMHpS8xTSGVaWqiVushVq/AmJaOhmt84RCQjIlWWR0Iaj2kiYcUoFlloempfWN8rnmNwhl3mqlHRzl759iOHZueSF0g4UL2H0DcPwrsXFwP7z8puR4VVV+6swLmwu4krEngTE1e+W6qo0nq7WtnIePytM31U9RiPRTGlPlL0OpzTpaL/ke6UcqPDh7cmS/5vBqVbNap9q3CEr3ItarPDRAmCq4o3DqORj8JGpRD+CupPigpt4XbWSosGCgQqnmcp5FmZzv75/ndRyrabeyWmW/6cHRVonw==  user@key-for-app-19580-first_app
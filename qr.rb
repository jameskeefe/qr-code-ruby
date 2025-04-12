# Write your solution here!
require "rqrcode"
require "pry-byebug"


def qrcode(encode_text)
  # encode the text in a QR code
  qrcode = RQRCode::QRCode.new(encode_text)

  # Create a 500x500 pixel image based off our "text" in qrcode
  png = qrcode.as_png({:size => 500})

  # Get user input for name of the QR code file
  puts "What would you like to name your QR code file?"
  puts 
  qrname = gets.chomp
  puts

  if !qrname.include?(".png")
    qrname = qrname + ".png"
  end

  # Write the image data to a file with the name that the user requested and save it
  IO.binwrite(qrname, png.to_s)

  # Let the user know the QR PNG has been created.
  puts "Here is the QR code image you requested."
  puts
  return
end

while true

  puts "What kind of QR code would you like to generate?"
  puts
  puts "1. Open a URL"
  puts "2. Join a wifi network"
  puts "3. Send a text message"
  puts
  puts "Press 4 to exit"
  puts

  kind_of_code = gets.chomp
  puts

  # Option 1: URL
  if kind_of_code=="1"
    puts "What URL would you like to encode in a QR code?"
    puts
    url_name = gets.chomp

    # It's 2025. We only use https
    if url_name.include?("http://")
      url_name.gsub("http:","https:")
    end
    # Need to add https to the url :)
    if !url_name.include?("https://")
      url_name = "https://" + url_name
    end

    qrcode(url_name)

  # Make a WiFi network QR code
  elsif kind_of_code=="2"
    puts "What is the name of your WiFi network?"
    puts 
    network_name = gets.chomp
    puts

    puts "What is the password for your WiFi network?"
    puts
    network_password = gets.chomp
    puts

    # encode the name and password of the network
    encode_text = "WIFI:T:WPA;S:#{network_name};P:#{network_password}"

    # save the QR code
    qrcode(encode_text)

  # Send a text message
  elsif kind_of_code=="3"

    puts "What is the phone number you would like to text?"
    puts 
    cell = gets.chomp
    puts

    cell.gsub(" ","")

    puts "What do you want to text them?"
    puts
    message = gets.chomp

    # encode the name and password of the network
    encode_text = "SMSTO:#{cell}:#{message}"

    # save the QR code
    qrcode(encode_text)

  # Exit
  elsif kind_of_code=="4"
    pp "Understood. Please come back again soon!"

    break

  else
    puts "Invalid input. Please try again."
    puts

    next

  end 

  puts "What else can I do for you?"
  puts

  end

pp "End of file. Exiting... "

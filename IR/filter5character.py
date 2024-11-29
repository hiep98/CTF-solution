import os

# Directory containing the txt files
directory = os.getcwd() # set current folder

#directory = r'D:\TeraBoxDownload\IR'  # set specific folder

# Function to read files and print lines with 5 characters
def read_files_and_print_lines(directory):
    # Iterate through all files in the directory
    for filename in os.listdir(directory):
        if filename.endswith(".txt"):  # Check if the file is a text file
            filepath = os.path.join(directory, filename)
            print(f"Reading file: {filename}")
            
            # Open the file and read line by line
            with open(filepath, 'r') as file:
                for line in file:
                    # Strip newline characters and check length
                    if len(line.strip()) == 9:
                        print(line.strip())  # Print lines with exactly 5 characters

# Call the function
read_files_and_print_lines(directory)

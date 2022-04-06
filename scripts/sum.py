import sys

# This program print the sum of two integer numbers 
# Get the numbers from user arguments like:  ./sum.py 33 44 => print 77

# Check that user sends only 2 numbers as arguments, I write 3 in if statement
# because the first argument is for the program file name + 2 arguments (numbers)
if len(sys.argv) != 3:
    print("Enter only two arguments..")
    sys.exit(1)

num1 = sys.argv[1]
num2 = sys.argv[2]

    
# Check if the two arguments are numbers    
if not num1.isdigit() or not num2.isdigit():
    print("Please enter only integer numbers..")
    sys.exit(2)
 
print(f"{int(num1) + int(num2)}")

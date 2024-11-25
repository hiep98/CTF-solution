#Decrypt RSA
from Crypto.Util.number import long_to_bytes
from sympy import factorint
from sympy.ntheory.modular import solve_congruence

# Given values 
n = value
e = value
ct = value

# Step 1: Factor n into p and q
factors = factorint(n)
p, q = list(factors.keys())

# Step 2: Calculate Euler's totient function phi(n)
phi_n = (p - 1) * (q - 1)

# Step 3: Calculate the private exponent d using the modular inverse of e modulo phi(n)
d = pow(e, -1, phi_n)

# Step 4: Decrypt the ciphertext using RSA: plain = ct^d mod n
plain = pow(ct, d, n)

# Step 5: Convert the plaintext back to bytes and then to a string
flag = long_to_bytes(plain).decode()

# Output the result
print("Flag:", flag)


# solution 2

from Crypto.Util.number import long_to_bytes
from sympy import factorint

# Given values
n = value
e = value
ct = value

# Step 1: Factor n into primes
factors = factorint(n)

# Print the factorization to see how many primes there are
print("Factors of n:", factors)

# Step 2: Handle the case of more than two factors
if len(factors) == 2:
    # If there are exactly two primes, we can proceed with RSA decryption
    p, q = list(factors.keys())
    phi_n = (p - 1) * (q - 1)
    d = pow(e, -1, phi_n)
    plain = pow(ct, d, n)
    flag = long_to_bytes(plain).decode()
    print("Flag:", flag)
else:
    print("The modulus n is not the product of two primes. The factorization is:", factors)

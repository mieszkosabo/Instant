import os
import subprocess
import sys
 
# A ultra simple tester, no proper error handling, no nothing

if len(sys.argv) != 2:
    print("Usage: python3 myTester.py <directory_with_test_cases>")
    print("Tests should be in a format of two files: <test_name>.ins and <test_name>.output")
    exit(1)

testDir = sys.argv[1]

insFiles = [f for f in os.listdir(testDir) if f.endswith('.ins') and not f.startswith(".")]
print(insFiles)

for inputFile in insFiles:
    subprocess.call('./insc_jvm ' + f'{testDir}/{inputFile}', shell=True)
    p = subprocess.run(f'java -cp {testDir} {inputFile[:-4]} | diff - {testDir}/{inputFile[:-4]}.output', shell=True)
    if p.returncode == 0:
        print(f'{inputFile} OK')
    else:
        print(f'{inputFile} BAD')

    subprocess.call(f'rm {testDir}/*.class', shell=True)

for inputFile in insFiles:
    subprocess.call('./insc_llvm ' + f'{testDir}/{inputFile}', shell=True)
    p = subprocess.run(f'lli {testDir}/{inputFile[:-4]}.bc | diff - {testDir}/{inputFile[:-4]}.output', shell=True)
    if p.returncode == 0:
        print(f'{inputFile} OK')
    else:
        print(f'{inputFile} BAD')

    subprocess.call(f'rm {testDir}/*.bc', shell=True)
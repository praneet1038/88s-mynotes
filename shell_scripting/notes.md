DRY - don't repeat yourself
pointers in C
- check installed module version
`dnf list installed nginx`
- remove installed package
`dnf remove nginx`
- if success or failure (&) redirect output to log file 
`&>> output.txt`
- print and save to log file 
`| tee output.txt`
- print and append to log file
`| tee -a output.txt`


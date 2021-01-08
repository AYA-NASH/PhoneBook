# PhoneBook
A phonebook app for intel8086,using assembly language ,a project for ECE311C course.
phonebook(directory) do Five operations:    
* add user
* display
* remove
* search
* quit
 
 
 ## Installation
 we use Irvine32: A library for assembly language, That is use to simplify tasks related to input-output and string handling in assembly language programming.
 ```
 include    c:\Irvine\Irvine32.inc
includelib c:\Irvine\irvine32.lib
includelib c:\Irvine\kernel32.lib
includelib y:\masm32\lib\user32.lib
```


## usage
First when you run the project we get the massage on screen to choose the number of operation you need to do 
![first massage](https://github.com/AYA-NASH/PhoneBook/blob/main/intel-8086/first%20massage0.PNG?raw=true)

   #### Add
   Allow to user to Enter its Name (the max contain 20 character )
   ```
    mov edx, arrayptr           ; Argument for ReadString: Pointer to memory
    mov ecx, 20                 ; Argument for ReadString: maximal number of chars
    call ReadString             ; Doesn't change EDX
    test eax, eax               ; EAX == 0 (got no string)
    jz zero_name                ; Yes: don't store a new arrayptr
    lea edx, [edx+eax+1]        ; EDX += EAX + 1
    mov arrayptr, edx           ; New pointer, points to the byte where the next string should begin
    ```
   

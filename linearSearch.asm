; LINEAR SEARCH ALGORITHM USING AN ARRAY OF 8 ELEMENTS
; I used one-digit number only, since I wanted to focus on building the algorithm using Assembly language.
; My goal was not to manipulate large numbers.

; Developed by: Vito Marco Rubino
; Date: 26 - 01 - 2022

; MACRO
linearSearch macro array, size, number, foundIndex
    mov cl, size
    mov si, 0
    
    searchLoop:
        mov bl, array[si]
        
        cmp bl, number
        je found
        
        jmp continue 
        
        found:
            mov foundIndex, si
            
        continue:
        
        inc si
        
    loop searchLoop 
endm
      
print_string macro string
    lea dx, string
    mov ah, 9
    int 21h
endm 

convert_to_ASCII macro number
    mov dx, number
    add dx, 30h ; to print a value we need to add 30h, which is '0' in the ASCII table
    mov number, dx
endm

print_char macro character
    mov dx, character
    mov ah, 2
    int 21h
endm

read_char macro character
    mov ah, 1
    int 21h
    
    mov character, al
endm

convert_to_decimal macro number
    mov al, number
    sub al, 30h ; to use an entered digit conversion to decimal is needed. So we subtract 30h, which is '0' in the ASCII table, to have the decimal value
    mov number, al
endm

clear_registers macro
    mov ax, 0
    mov bx, 0
    mov cx, 0
    mov dx, 0
endm

data segment
    ; add your data here!
       
    ; numeric variables
    size db 8 ; size of array
    array db 2, 5, 7, 6, 4, 1, 9, 3 ; array of 8 values. 0 and 8 can be entered to check what happens when a value is missing
    
    number db ? ; value to be searched
    foundIndex dw 2fh ; index of found value.
                      ; if the value is not found, foundIndex will be '/'
    
    ; alphanumeric variables     
    msgTitle db "LINEAR SEARCH ALGORITHM$"
    msgEnterValue db "Value to be searched: $"
    msgFound db "Value found at index: $"
    msgNotFound db "Value not found.$"     
    msgArray db "ARRAY$"
    newline db 13, 10, "$"   
    whitespace db " $"
    
ends
       +
stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    
    clear_registers
    
    mov cl, size
    mov si, 0
                  
    print_string msgTitle ; display "LINEAR SEARCH ALGORITHM"
    print_string newline 
    
    print_string newline
    print_string msgArray ; display "ARRAY"
    print_string newline
    
    print_array:         
        mov dl, array[si]
        add dl, 30h
        
        mov ah, 2
        int 21h 
        
        print_string whitespace 
        
        inc si
    loop print_array
    
    print_string newline
    print_string newline
    
    print_string msgEnterValue ; display "Value to be searched: "
    read_char number ; read value to be searched from keyboard                                   
    
    
    convert_to_decimal number
    
    linearSearch array, size, number, foundIndex
    
    print_string newline
    
    cmp foundIndex, 2fh ; if foundIndex is equal to 2fh, which is '\', the value is not found
    je not_found
     
        print_string msgFound ; display "Value found at index: "
        
        convert_to_ASCII foundIndex 
        print_char foundIndex ; displaying index of found value
        
        jmp end_program
        
    not_found: 
    
        print_string msgNotFound ; display "Value not found." 
        
    end_program:
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.

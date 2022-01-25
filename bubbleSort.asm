; multi-segment executable file template.

; MACRO   

print_char macro character
    mov dl, character
    mov ah, 2
    int 21h
endm

print_string macro string
    lea dx, string
    mov ah, 9
    int 21h
endm
   
convert_to_ASCII macro number 
    mov al, number
    add al, 30h ; in order to print a char in Assembly you need to add 30h, which is '0' in the ASCII table 
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
    size dw 8
    array db 6, 2, 5, 8, 7, 1, 4, 3  
    
    ; alphanumeric variables
    msgTitle db "* BUBBLE SORT ALGORITHM *$"                  
    msgArray db "ARRAY$"
    msgSortedArray db "SORTED ARRAY$" 
    msgSorting db "Sorting...$"
    newline db 13, 10, "$"
    whitespace db " $"
    
ends

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
                   
    print_string msgTitle
    print_string newline
    
    print_string newline
    print_string msgArray
    print_string newline
    
    mov cx, size
    mov si, 0
     
    ; printing unsorted array
    printLoop:   
        mov al, array[si]
        convert_to_ASCII al
        print_char al 
        
        print_string whitespace
        
        inc si
    loop printLoop
    
    print_string newline 
    print_string newline
    print_string msgSorting
    print_string newline
    
    clear_registers
    
    ; bubble sort
    
    mov si, 0
    
    outerLoop: 
    
        mov cx, size
        dec cl

        mov di, 0
        
        innerLoop: 
            
            mov al, array[si]
            mov bl, array[di]
            
            cmp al, bl
            jl swap
               
                jmp continue
            
            swap:
                mov array[si], bl
                mov array[di], al
                
            continue:
         
            inc di  
            
        cmp di, cx
        jne innerLoop:
         
        dec cx
        
        inc si
        
    cmp si, size
    jne outerLoop
        
     
    clear_registers
    
    print_string newline 
    print_string newline
    print_string msgSortedArray 
    print_string newline
    
    mov cx, size
    mov si, 0
     
    ; printing sorted array
    printSorted:           
        mov al, array[si]
        convert_to_ASCII al
        print_char al
        
        print_string whitespace
        
        inc si
    loop printSorted
      
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.

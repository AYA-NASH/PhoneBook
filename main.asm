include    c:\Irvine\Irvine32.inc
includelib c:\Irvine\irvine32.lib
includelib c:\Irvine\kernel32.lib
includelib y:\masm32\lib\user32.lib


.DATA
       aName BYTE 51 DUP (?)
    arrayptr    DWORD OFFSET array
    array       BYTE 4096 DUP (?)
    mes1        BYTE 10, "1-add number 2-display all numbers 3-remove a number 4-search for a number 5-quit", 0
    check byte 0,0
    ;mes1        BYTE 10, "press 1 to add an element, 2 to print, 3 to quit    ", 0
    yourName  byte "Name :  ",0
    number byte "Number :  ",0
    mesToTakeName byte "Enter Your Name : ",0
    mesToMaxNumber byte "Max Numbers !!!",0
    mesToTakeNumber byte "Enter Your Number : ",0
    msgMoreNumber byte "More Numbers? (y) or (n)",0
    maxNum byte 0,0
    indexWeAt DWORD 0,0
    indexWeAt2 DWORD 0,0

    zeros  byte "-",0
    eqaa byte "+",0
    searchInput dword 0,0
    nameSize byte ?
    contacts word 1000 DUP(?);array of conects
    contactsPtr DWORD OFFSET contacts
    index byte ?

    
buffer BYTE 21 DUP(0)          ; input buffer
byteCount DWORD ?              ; holds counter
      



.CODE


readin PROC
    mov    maxNum , 0
    mov edx, arrayptr           ; Argument for ReadString: Pointer to memory
    mov al , eqaa
    mov  [edx], al
    lea edx, [edx+1+1]        ; EDX += EAX + 1
    mov arrayptr, edx           ; New pointer, points to the byte where the next string should 
    lea   edx, mesToTakeName
	call  writeString
	call	CrLf
    mov edx, arrayptr           ; Argument for ReadString: Pointer to memory
    mov ecx, 20                 ; Argument for ReadString: maximal number of chars
    call ReadString             ; Doesn't change EDX
    test eax, eax               ; EAX == 0 (got no string)
    jz zero_name                     ; Yes: don't store a new arrayptr
    lea edx, [edx+eax+1]        ; EDX += EAX + 1
    mov arrayptr, edx           ; New pointer, points to the byte where the next string should begin
    take_number:
        cmp   maxNum , 3
        je    maxNumFunc
        lea   edx, mesToTakeNumber
	    call  writeString
	    call	CrLf
        mov edx, arrayptr           ; Argument for ReadString: Pointer to memory
        mov ecx, 15                 ; Argument for ReadString: maximal number of chars
        call ReadString             ; Doesn't change EDX
        inc     maxNum
        test eax, eax               ; EAX == 0 (got no string)
        jz filling                     ; Yes: don't store a new arrayptr
        lea edx, [edx+eax+1]        ; EDX += EAX + 1
        mov arrayptr, edx           ; New pointer, points to the byte where the next string should begin
        lea edx, msgMoreNumber
		call writestring
		call	CrLf
		call readchar
		mov check , al
		cmp check , 79h
		je  take_number
        cmp   maxNum , 3
        jne    filling
        jmp done
 
 filling: 
             mov edx, arrayptr           ; Argument for ReadString: Pointer to memory
            mov ecx, 1                 ; Argument for ReadString: maximal number of 
            ;mov ecx, 15                 ; Argument for ReadString: maximal number of chars
            mov al , zeros ; zero => "-"
            mov  [edx], al
            inc     maxNum
            lea edx, [edx+1+1]        ; EDX += EAX + 1
            mov arrayptr, edx           ; New pointer, points to the
             cmp   maxNum , 3
             jne    filling
             jmp done
maxNumFunc:
	        call	CrLf
            lea   edx, mesToMaxNumber
	        call  writeString
	        call	CrLf
	        call	CrLf
            mov    maxNum , 0
            jmp done

zero_name :
        lea edx, [edx-1-1]          ; EDX += EAX + 1
        mov arrayptr, edx           ; New pointer, points to the byte where the next string should 
    

            
    done:
        ret
readin ENDP














delete PROC
     
    

    done:
    ret
    
    delete ENDP




    

print_name PROC
    
    done:
    ret
print_name ENDP





print PROC
mov indexWeAt , 0
    mov index,0
    lea edx, array              ; Points to the first string
    L1:
    cmp edx, arrayptr           ; Does it point beyond the strings?
    jae done                    ; Yes -> break
    cmp index,0
    je scan_for_null
;    mov ecx,[edx]
 ;   cmp ecx,'+'
  ;  je scan_for_null
    cmp index,1
    je name_print
    jg number_print
    name_print:
    cmp byte ptr [edx] , '='
    je scan_to_remove
    mov eax , edx
    lea edx,yourName
    call writeString
    mov edx,eax
    call WriteString            ; Doesn't change EDX
    call Crlf  
    jmp scan_for_null
    number_print:
     cmp byte ptr [edx] , '='
    je scan_to_remove
    mov eax , edx
    lea edx,number
    call writeString
    mov edx,eax
    call WriteString            ; Doesn't change EDX
    call Crlf                   ; Doesn't change EDX
    scan_for_null:
    inc edx                     ; Pointer to next string
    cmp BYTE PTR [edx], 0       ; Terminating null?
    jne scan_for_null           ; no -> next character
    inc edx                     ; Pointer to next string
    inc index
    cmp index,5
    je zero_index
    jmp L1
    zero_index:
    mov index,0
    jmp L1

scan_to_remove:
       inc indexWeAt
       jmp scan_for_null


    done:
    ret
print ENDP















search PROC
        mov check,0
        mov index , 0
        lea   edx, mesToTakeName
	    call  writeString
	    call	CrLf
        mov edx, contactsPtr           ; Argument for ReadString: Pointer to memory
        mov ecx, 15                 ; Argument for ReadString: maximal number of chars
        call ReadString             ; Doesn't change EDX
        inc     maxNum
        test eax, eax               ; EAX == 0 (got no string)
        jz done                     ; Yes: don't store a new arrayptr
        mov esi,eax
        lea edx, [edx+eax+1]        ; EDX += EAX + 1
        mov contactsPtr, edx           ; New pointer, points to the byte where the next string should begin
        mov indexWeAt,0
        mov indexWeAt2,0
        mov index,0
        xor edx ,edx
        xor ebx ,ebx
        xor ecx ,ecx
        mov ecx , edx
        lea edx , yourName
        call writestring
        mov edx , ecx
            mov eax , offset array
            ;dec eax
            mov edi , offset contacts
        compare_string:
            mov ebx , edi
            ;call	CrLf
            mov cl , BYTE PTR [ebx]
            cmp BYTE PTR [eax], cl       ; Terminating null?
            je okay_print
            mov index , 0
            cmp eax, arrayptr           
            jae done                    
            scan_for_null:
            mov edi , offset contacts
            inc eax                     ; Pointer to next string
            cmp BYTE PTR [eax], 0       ; Terminating null?
            jne scan_for_null           ; no -> next character
            inc eax                     ; Pointer to next string
            jmp compare_string
            okay_print:
            inc index
            mov ecx , esi
            cmp index , cl
            jne double_check
            sub eax , ecx
            inc eax
            xor edx , edx
            mov edx , eax                ;=========>>>>>> edx holds Name Index in the array
            call writestring

            ;inc eax                     ; Pointer to next string
            call	CrLf
            
        mov ecx , edx
        lea edx , number
        call writestring
        mov edx , ecx
           scan_for_null2:
            inc edx                     ; Pointer to next string
            cmp BYTE PTR [edx], 0       ; Terminating null?
            jne scan_for_null2           ; no -> next character
            inc edx                     ; Pointer to next string
            call writestring		 ;=========>>>>>> edx holds first Number Index in the array
            		call	CrLf

        mov ecx , edx
        lea edx , number
        call writestring
        mov edx , ecx
           scan_for_null3:
            inc edx                     ; Pointer to next string
            cmp BYTE PTR [edx], 0       ; Terminating null?
            jne scan_for_null3           ; no -> next character
            inc edx                     ; Pointer to next string
            call writestring		;=========>>>>>> edx holds second Number Index in the array
            		call	CrLf

        mov ecx , edx
        lea edx , number
        call writestring
        mov edx , ecx
           scan_for_null4:
            inc edx                     ; Pointer to next string
            cmp BYTE PTR [edx], 0       ; Terminating null?
            jne scan_for_null4           ; no -> next character
            inc edx                     ; Pointer to next string
            call writestring		;=========>>>>>> edx holds third Number Index in the array
            jmp done

        double_check:
            inc edi
            inc eax
            jmp compare_string

    done:
		call	CrLf
		ret	



search ENDP



























main PROC

    ;mov edx, offset fileName
    ;call createoutputfile
    ;mov al , mesToTakeNumber
    ;call Writetofile

    ;cmp [mes1] , 1
    ;jg add1
    ;jl stop









    start:
    
    lea edx, mes1
    call WriteString
    call	CrLf
    call ReadDec
    cmp eax, 1
    je add1
    cmp eax, 2
    je print2
    cmp eax, 3
    je delete2
    cmp eax, 4
    je search2
    cmp eax, 5



    je stop
    jmp next                    ; This was missing in the OP


    
add1:
    call readin
    jmp next                    ; Just a better name than in the OP


delete2:
    call delete
    jmp next                    ; Just a better name than in the OP




print2:
    mov index,0
    call print
    jmp next                    ; Just a better name than in the OP



search2:
    mov cx,15
    mov edx , offset contacts

myloop:
 
    mov contactsPtr , offset contacts

    call search
    jmp next                    ; Just a better name than in the OP



next:                           ; Just a better name than in the OP
    jmp start


stop:
    exit

main ENDP

END main

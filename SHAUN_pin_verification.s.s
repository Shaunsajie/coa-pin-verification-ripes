.data
correct_pin: .word 1234

# Test inputs (simulate user attempts)
user1: .word 1111
user2: .word 2222
user3: .word 1234

msg_granted: .asciz "Access Granted\n"
msg_denied:  .asciz "Access Denied\n"
msg_blocked: .asciz "System Blocked\n"

.text
.globl main

main:
    li t4, 3              # attempts = 3

    la t5, user1          # pointer to user inputs

loop:
    lw t1, correct_pin    # load correct PIN
    lw t2, 0(t5)          # load current attempt

    beq t1, t2, success   # if equal → success

    # Wrong PIN
    la a0, msg_denied
    li a7, 4
    ecall

    addi t4, t4, -1       # attempts--

    beq t4, x0, blocked   # if attempts == 0 → blocked

    addi t5, t5, 4        # move to next input
    j loop

success:
    la a0, msg_granted
    li a7, 4
    ecall
    j end

blocked:
    la a0, msg_blocked
    li a7, 4
    ecall

end:
    li a7, 10
    ecall
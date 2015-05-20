From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] Input:evdev - Fix to avoid the execution of same instruction in every iteration of for loop.
Date: Thu, 21 May 2015 00:35:46 +0530
Message-ID: <1432148746-3845-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>
List-Id: linux-input@vger.kernel.org

Here in for loop the instruction "len / sizeof(compat_long_t)" is used
as a terminating condition which is executing (being computed) in every
iteration of for loop. Below is the armv7-a architecture assembly code with
similar for loop having the same instruction in condition.Note that the
instruction "lsr r3, r3, #2" i.e Logical Shift Right on behalf of
"len / sizeof(compat_long_t)" is getting executed every time the loop
iterates.

       .syntax unified
        .arch armv7-a
        .eabi_attribute 27, 3
        .fpu vfpv3-d16
        .eabi_attribute 20, 1
        .eabi_attribute 21, 1
        .eabi_attribute 23, 3
        .eabi_attribute 24, 1
        .eabi_attribute 25, 1
        .eabi_attribute 26, 2
        .eabi_attribute 30, 6
        .eabi_attribute 34, 1
        .eabi_attribute 18, 4
        .thumb
        .file   "test.c"
        .section        .rodata
        .align  2
.LC0:
        .ascii  "Shail\000"
        .text
        .align  2
        .global main
        .thumb
        .thumb_func
        .type   main, %function
main:
        @ args = 0, pretend = 0, frame = 8
        @ frame_needed = 1, uses_anonymous_args = 0
        push    {r7, lr}
        sub     sp, sp, #8
        add     r7, sp, #0
        mov     r3, #1000
        str     r3, [r7, #4]
        mov     r3, #0
        str     r3, [r7, #0]
        b       .L2
.L3:
        movw    r3, #:lower16:.LC0
        movt    r3, #:upper16:.LC0
        mov     r0, r3
        bl      printf
        ldr     r3, [r7, #0]
        add     r3, r3, #1
        str     r3, [r7, #0]
.L2:
        ldr     r2, [r7, #0]
        ldr     r3, [r7, #4]
        lsr     r3, r3, #2 -------> Instruction "len/sizeof(compat_long_t)"
        cmp     r2, r3              will execute in every loop iteration.
        bcc     .L3
        mov     r3, #0
        mov     r0, r3
        add     r7, r7, #8
        mov     sp, r7
        pop     {r7, pc}
        .size   main, .-main
        .ident  "GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
        .section        .note.GNU-stack,"",%progbits

This fix will avoid the execution( computation) of same instruction in 
every for loop iteration and will perform the instruction computation 
before the for loop. Below is the armv7-a assembly code after changes. 
In this we can note that the "lsr r3, r3, #2" i.e. Logical Shift Right 
instruction on behalf of "len / sizeof(compat_long_t)" is getting 
executed only once before the loop.

        .syntax unified
        .arch armv7-a
        .eabi_attribute 27, 3
        .fpu vfpv3-d16
        .eabi_attribute 20, 1
        .eabi_attribute 21, 1
        .eabi_attribute 23, 3
        .eabi_attribute 24, 1
        .eabi_attribute 25, 1
        .eabi_attribute 26, 2
        .eabi_attribute 30, 6
        .eabi_attribute 34, 1
        .eabi_attribute 18, 4
        .thumb
        .file   "test.c"
        .section        .rodata
        .align  2
.LC0:
        .ascii  "Shail\000"
        .text
        .align  2
        .global main
        .thumb
        .thumb_func
        .type   main, %function
main:
        @ args = 0, pretend = 0, frame = 8
        @ frame_needed = 1, uses_anonymous_args = 0
        push    {r7, lr}
        sub     sp, sp, #8
        add     r7, sp, #0
        mov     r3, #1000
        str     r3, [r7, #4]
        ldr     r3, [r7, #4]
        lsr     r3, r3, #2  ------->Instruction "len/sizeof(compat_long_t)"
        str     r3, [r7, #4]        will execute only once before for loop.
        mov     r3, #0
        str     r3, [r7, #0]
        b       .L2
.L3:
        movw    r3, #:lower16:.LC0
        movt    r3, #:upper16:.LC0
        mov     r0, r3
        bl      printf
        ldr     r3, [r7, #0]
        add     r3, r3, #1
        str     r3, [r7, #0]
.L2:
        ldr     r2, [r7, #0]
        ldr     r3, [r7, #4]
        cmp     r2, r3
        blt     .L3
        mov     r3, #0
        mov     r0, r3
        add     r7, r7, #8
        mov     sp, r7
        pop     {r7, pc}
        .size   main, .-main
        .ident  "GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
        .section        .note.GNU-stack,"",%progbits

Thus the fix will save duplicate instruction execution in every
iteration of for loop.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/input/evdev.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index dcc588e..bea576f 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -618,7 +618,9 @@ static int bits_to_user(unsigned long *bits, unsigned int maxbit,
 		if (len > maxlen)
 			len = maxlen;
 
-		for (i = 0; i < len / sizeof(compat_long_t); i++)
+		maxlen = len / sizeof(compat_long_t);
+
+		for (i = 0; i < maxlen; i++)
 			if (copy_to_user((compat_long_t __user *) p + i,
 					 (compat_long_t *) bits +
 						i + 1 - ((i % 2) << 1),
-- 
1.7.9.5

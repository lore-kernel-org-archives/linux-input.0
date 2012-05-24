From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Reg. kernel crash while using pixcir touchscreen driver
Date: Thu, 24 May 2012 11:20:01 +0530
Message-ID: <CAK9yfHzGgYTSE7mJ1xmnCrZ-_eYxBvbZp-hQ8tSJ77=TLvFdvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:56100 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab2EXFuD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 May 2012 01:50:03 -0400
Received: by qadb17 with SMTP id b17so3825757qad.19
        for <linux-input@vger.kernel.org>; Wed, 23 May 2012 22:50:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jcbian@pixcir.com.cn, dmitry.torokhov@gmail.com, rydberg@euromail.se

Hi,

I encountered a kernel crash while integrating Pixcir touchscreen
driver with one of our hardware. The log is attached at the end of the
mail (inline).

The following ISR code:

while (!tsdata->exiting) {
        pixcir_ts_poscheck(tsdata);

        if (tsdata->chip->attb_read_val())
              break;

        msleep(20);
}

seems to run until the if condition is false. However, when it exits
the loop (when the condition becomes true), it crashes saying "exiting
task "irq/438-pixcir_" (1011) is an active IRQ thread".

I have 2 questions here:
1. Do we need such a loop and the if condition. In my case it worked
with the isr just doing
pixcir_ts_poscheck(tsdata);

2. What exactly is expected by attb_read_val() function.

Any pointers would be helpful.

*****
Unable to handle kernel paging request at virtual address e7fddef0
pgd = cf9e4000
[e7fddef0] *pgd=00000000
Internal error: Oops: 80000005 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1    Not tainted  (3.4.0-rc3-00050-g718e84c-dirty #24)
PC is at 0xe7fddef0
LR is at pixcir_ts_isr+0x7c/0x210
pc : [<e7fddef0>]    lr : [<c01aaa68>]    psr: 60000013
sp : cef83f50  ip : 00000000  fp : 00000001
r10: cf8ce780  r9 : 00000001  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 000000fc
r3 : e7fddef0  r2 : cef83f48  r1 : 60000013  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 4f9e404a  DAC: 00000015
Process irq/438-pixcir_ (pid: 1011, stack limit = 0xcef822f0)
Stack: (0xcef83f50 to 0xcef84000)
3f40:                                     cef83f8c 00000256 c0367f80 56000180
3f60: 0000fc02 00000000 00000001 cef82000 cebdc720 00000001 cebdc700 c0380a40
3f80: c0380a94 c038c670 00000000 c00636e8 c0367f80 c03672c0 00000001 cf833dfc
3fa0: cebdc700 c00635ec 00000013 00000000 00000000 00000000 00000000 c0038bd4
3fc0: 00000000 cebdc700 00000000 00000000 00000000 dead4ead ffffffff ffffffff
3fe0: cef83fe0 cef83fe0 cf833dfc c0038b50 c000f02c c000f02c 00002468 00000000
[<c01aaa68>] (pixcir_ts_isr+0x7c/0x210) from [<c00636e8>]
(irq_thread+0xfc/0x14c)
[<c00636e8>] (irq_thread+0xfc/0x14c) from [<c0038bd4>] (kthread+0x84/0x90)
[<c0038bd4>] (kthread+0x84/0x90) from [<c000f02c>] (kernel_thread_exit+0x0/0x8)
Code: bad PC value
---[ end trace cbb10841fae7b402 ]---
exiting task "irq/438-pixcir_" (1011) is an active IRQ thread (irq 438)


-- 
Regards,
Sachin

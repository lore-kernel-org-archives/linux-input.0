From: Shaleen Jain <shaleen@thejains.org.in>
Subject: Synaptics touchpad intertouch on Galago Pro
Date: Sun, 26 Nov 2017 11:05:48 +0000
Message-ID: <0102015ff801301f-97e6e838-7d8c-4a11-bacd-07d445652c18-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a4-2.smtp-out.eu-west-1.amazonses.com ([54.240.4.2]:43220 "EHLO
        a4-2.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751733AbdKZLFu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 26 Nov 2017 06:05:50 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

After noticing following logs in my dmesg:

psmouse serio2: synaptics: Your touchpad (PNP: SYN1221 PNP0f13) says it
can support a different bus. If i2c-hid and hid-rmi are not used, you
might want to try setting psmouse.synaptics_intertouch to 1 and report
this to linux-input@vger.kernel.org.
psmouse serio2: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1,
caps: 0xf00223/0x840300/0x26800/0x0, board id: 3175, fw id: 2330500

I booted with the mentioned kernel parameter but unfortunately resulted
in my touchpad not working.

Some of the logs with the parameter:
psmouse serio2: synaptics: queried max coordinates: x [..5718], y
[..4908]
psmouse serio2: synaptics: queried min coordinates: x [1238..], y
[956..]
psmouse serio2: synaptics: Trying to set up SMBus access

Nov 26 10:33:07 shalzz-galp2 kernel: i801_smbus 0000:00:1f.4: Timeout
waiting for interrupt!
Nov 26 10:33:07 shalzz-galp2 kernel: i801_smbus 0000:00:1f.4:
Transaction timeout
Nov 26 10:33:07 shalzz-galp2 kernel: rmi4_physical rmi4-00: Failed to
read irqs, code=-110
Nov 26 10:33:08 shalzz-galp2 kernel: i801_smbus 0000:00:1f.4: Timeout
waiting for interrupt!
Nov 26 10:33:08 shalzz-galp2 kernel: i801_smbus 0000:00:1f.4:
Transaction timeout
Nov 26 10:33:08 shalzz-galp2 kernel: rmi4_physical rmi4-00: Failed to
read irqs, code=-110
Nov 26 10:33:08 shalzz-galp2 kernel: i801_smbus 0000:00:1f.4: Timeout
waiting for interrupt!
Nov 26 10:33:08 shalzz-galp2 kernel: i801_smbus 0000:00:1f.4:
Transaction timeout
Nov 26 10:33:08 shalzz-galp2 kernel: rmi4_physical rmi4-00: Failed to
read irqs, code=-110

I also noticed this just before the kernel smbus logs:
Nov 26 10:33:08 shalzz-galp2 kernel: irq 16: nobody cared (try booting
with the "irqpoll" option)
Nov 26 10:33:08 shalzz-galp2 kernel: CPU: 2 PID: 0 Comm: swapper/2 Not
tainted 4.13.12-1-ARCH #1
Nov 26 10:33:08 shalzz-galp2 kernel: Hardware name:
Notebook                         N130BU/N130BU, BIOS 1.05.04nRSA
04/26/2017
Nov 26 10:33:08 shalzz-galp2 kernel: Call Trace:
Nov 26 10:33:08 shalzz-galp2 kernel:  <IRQ>
Nov 26 10:33:08 shalzz-galp2 kernel:  dump_stack+0x63/0x8b
Nov 26 10:33:08 shalzz-galp2 kernel:  __report_bad_irq+0x35/0xc0
Nov 26 10:33:08 shalzz-galp2 kernel:  note_interrupt+0x254/0x2a0
Nov 26 10:33:08 shalzz-galp2 kernel:  handle_irq_event_percpu+0x54/0x80
Nov 26 10:33:08 shalzz-galp2 kernel:  handle_irq_event+0x3c/0x60
Nov 26 10:33:08 shalzz-galp2 kernel:  handle_fasteoi_irq+0x85/0x140
Nov 26 10:33:08 shalzz-galp2 kernel:  handle_irq+0x1a/0x30
Nov 26 10:33:08 shalzz-galp2 kernel:  do_IRQ+0x46/0xd0
Nov 26 10:33:08 shalzz-galp2 kernel:  common_interrupt+0x89/0x89
Nov 26 10:33:08 shalzz-galp2 kernel: RIP:
0010:cpuidle_enter_state+0x130/0x300
Nov 26 10:33:08 shalzz-galp2 kernel: RSP: 0018:ffffb029031c3e58 EFLAGS:
00000246 ORIG_RAX: ffffffffffffffbc
Nov 26 10:33:08 shalzz-galp2 kernel: RAX: ffff9476fed18d00 RBX:
0000000088ae713a RCX: 000000000000001f
Nov 26 10:33:08 shalzz-galp2 kernel: RDX: 0000000088ae713a RSI:
fffffffdb4166edf RDI: 0000000000000000
Nov 26 10:33:08 shalzz-galp2 kernel: RBP: ffffb029031c3e98 R08:
00000000ffffffff R09: 0000000000000008
Nov 26 10:33:08 shalzz-galp2 kernel: R10: 0000000000000001 R11:
0000000000000001 R12: ffff9476fed20d20
Nov 26 10:33:08 shalzz-galp2 kernel: R13: 0000000000000000 R14:
0000000000000001 R15: ffffffffa4aa96f8
Nov 26 10:33:08 shalzz-galp2 kernel:  </IRQ>
Nov 26 10:33:08 shalzz-galp2 kernel:  ? cpuidle_enter_state+0x120/0x300
Nov 26 10:33:08 shalzz-galp2 kernel:  cpuidle_enter+0x17/0x20
Nov 26 10:33:08 shalzz-galp2 kernel:  call_cpuidle+0x23/0x40
Nov 26 10:33:08 shalzz-galp2 kernel:  do_idle+0x18f/0x1e0
Nov 26 10:33:08 shalzz-galp2 kernel:  cpu_startup_entry+0x73/0x80
Nov 26 10:33:08 shalzz-galp2 kernel:  start_secondary+0x15a/0x1a0
Nov 26 10:33:08 shalzz-galp2 kernel:  secondary_startup_64+0x9f/0x9f
Nov 26 10:33:08 shalzz-galp2 kernel: handlers:
Nov 26 10:33:08 shalzz-galp2 kernel: [<ffffffffc0712120>] i801_isr
[i2c_i801]
Nov 26 10:33:08 shalzz-galp2 kernel: Disabling IRQ #16

Please let me know if you need any additional info.
I'm not subscribed to the list so please cc me.

-- 
Regards,
Shaleen Jain

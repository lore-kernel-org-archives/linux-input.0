From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: i8042: add a check in i8042_interrupt
Date: Sun, 2 Jul 2017 15:27:38 -0700
Message-ID: <20170702222738.GA8574@dtor-ws>
References: <7952EC96A33C0E41A611E13B3EB75D4224F70FA0@DGGEMA501-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7952EC96A33C0E41A611E13B3EB75D4224F70FA0@DGGEMA501-MBX.china.huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "chenhong (N)" <chenhong3@huawei.com>
Cc: vojtech@suse.cz, "Jinjian (Ken)" <jinjian@huawei.com>, "Wulizhen (Pss)" <pss.wulizhen@huawei.com>, LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On Sat, Jun 24, 2017 at 09:38:48AM +0000, chenhong (N) wrote:
> Description of problem:
> 
> Encounterd BUG case:
> serio: i8042 KBD port at 0x60,0x64 irq 1
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000050
> IP: [<ffffffff8150feaf>] _spin_lock_irqsave+0x1f/0x40
> PGD 0
> Oops: 0002 [#1] SMP
> last sysfs file:
> CPU 0
> Modules linked in:
> 
> Pid: 1, comm: swapper Not tainted 2.6.32-358.el6.x86_64 #1 QEMU Standard PC (i440FX + PIIX, 1996)
> RIP: 0010:[<ffffffff8150feaf>]  [<ffffffff8150feaf>] _spin_lock_irqsave+0x1f/0x40
> RSP: 0018:ffff880028203cc0  EFLAGS: 00010082
> RAX: 0000000000010000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000282 RSI: 0000000000000098 RDI: 0000000000000050
> RBP: ffff880028203cc0 R08: ffff88013e79c000 R09: ffff880028203ee0
> R10: 0000000000000298 R11: 0000000000000282 R12: 0000000000000050
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000098
> FS:  0000000000000000(0000) GS:ffff880028200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000050 CR3: 0000000001a85000 CR4: 00000000001407f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Process swapper (pid: 1, threadinfo ffff88013e79c000, task ffff88013e79b500)
> Stack:
> ffff880028203d00 ffffffff813de186 ffffffffffffff02 0000000000000000
> <d> 0000000000000000 0000000000000000 0000000000000000 0000000000000098
> <d> ffff880028203d70 ffffffff813e0162 ffff880028203d20 ffffffff8103b8ac
> Call Trace:
> <IRQ>
>  [<ffffffff813de186>] serio_interrupt+0x36/0xa0
> [<ffffffff813e0162>] i8042_interrupt+0x132/0x3a0
> [<ffffffff8103b8ac>] ? kvm_clock_read+0x1c/0x20
> [<ffffffff8103b8b9>] ? kvm_clock_get_cycles+0x9/0x10
> [<ffffffff810e1640>] handle_IRQ_event+0x60/0x170
> [<ffffffff8103b154>] ? kvm_guest_apic_eoi_write+0x44/0x50
> [<ffffffff810e3d8e>] handle_edge_irq+0xde/0x180
> [<ffffffff8100de89>] handle_irq+0x49/0xa0
> [<ffffffff81516c8c>] do_IRQ+0x6c/0xf0
> [<ffffffff8100b9d3>] ret_from_intr+0x0/0x11
> [<ffffffff81076f63>] ? __do_softirq+0x73/0x1e0
> [<ffffffff8109b75b>] ? hrtimer_interrupt+0x14b/0x260
> [<ffffffff8100c1cc>] ? call_softirq+0x1c/0x30
> [<ffffffff8100de05>] ? do_softirq+0x65/0xa0
> [<ffffffff81076d95>] ? irq_exit+0x85/0x90
> [<ffffffff81516d80>] ? smp_apic_timer_interrupt+0x70/0x9b
> [<ffffffff8100bb93>] ? apic_timer_interrupt+0x13/0x20
> Version-Release number of selected component (if applicable):
> 
> RELEASE: 2.6.32-358.el6.x86_64 (Red Hat Enterprise Linux 6.4)
> VERSION: #1 SMP Thu Feb 21 02:37:52 EST 2013
> 
> The problem was also reproduced on Red Hat Enterprise Linux 7.3-x86_64(3.10.0-514.el7)
> 
> Cause of the problem:
> static irqreturn_t i8042_interrupt(int irq, void *dev_id)
> {
> ......
> serio = port->exists ? port->serio : NULL;
>        ......
>        if (likely(port->exists && !filtered))
>               serio_interrupt(serio, data, dfl);
>        ......
> }
> 
> static int i8042_start(struct serio *serio)
> {
>        struct i8042_port *port = serio->port_data;
>        port->exists = true;
>        mb();
>        return 0;
> }
> 
> 
> i8042_probe
> |
> i8042_setup_kbd --> request_irq(i8042_interrupt)
> |
> i8042_register_ports --> serio_queue_event(SERIO_REGISTER_PORT) --> serio_handle_event --> serio_add_port --> i8042_start
> 
> 
> i8042_start which set port->exists be true may be called during the i8042_interrupt function according to the analysis of initialization order.  If port->exists is set to be true after the assignment of serio and before calling of serio_interrupt, a NULL pointer will be passed to serio_interrupt. The latest upstream kernel still has this problem.
> 

Thank you for your report and the correct analysis of the problem.

> 
> Solution for this problem
> Add a check for serio to prevent NULL pointer.
> 
> --- a/drivers/input/serio/i8042.c       2017-06-19 16:44:50.890078100 +0800
> +++ b/drivers/input/serio/i8042.c      2017-06-19 16:45:20.230022700 +0800
> @@ -524,7 +524,7 @@ i8042_interruptspin_unlock_irqrestore(&i8042_lock, flags);
> -       if (likely(port->exists && !filtered))
> +      if (likely(port->exists && !filtered && serio))

I do not think we need to check port->exists here, just checking serio
should be enough.

Also, please check Documentation/SubmittingPatches when submitting
patches in the future.

I believe we want the version of the patch below.

Thanks!

-- 
Dmitry

Input: i8042 - fix crash at boot time

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

The driver checks port->exists twice in i8042_interrupt(), first when
trying to assign temporary "serio" variable, and second time when deciding
whether it should call serio_interrupt(). The value of port->exists may
change between the 2 checks, and we may end up calling serio_interrupt()
with a NULL pointer:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000050
IP: [<ffffffff8150feaf>] _spin_lock_irqsave+0x1f/0x40
PGD 0
Oops: 0002 [#1] SMP
last sysfs file:
CPU 0
Modules linked in:

Pid: 1, comm: swapper Not tainted 2.6.32-358.el6.x86_64 #1 QEMU Standard PC (i440FX + PIIX, 1996)
RIP: 0010:[<ffffffff8150feaf>]  [<ffffffff8150feaf>] _spin_lock_irqsave+0x1f/0x40
RSP: 0018:ffff880028203cc0  EFLAGS: 00010082
RAX: 0000000000010000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000282 RSI: 0000000000000098 RDI: 0000000000000050
RBP: ffff880028203cc0 R08: ffff88013e79c000 R09: ffff880028203ee0
R10: 0000000000000298 R11: 0000000000000282 R12: 0000000000000050
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000098
FS:  0000000000000000(0000) GS:ffff880028200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000050 CR3: 0000000001a85000 CR4: 00000000001407f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process swapper (pid: 1, threadinfo ffff88013e79c000, task ffff88013e79b500)
Stack:
ffff880028203d00 ffffffff813de186 ffffffffffffff02 0000000000000000
<d> 0000000000000000 0000000000000000 0000000000000000 0000000000000098
<d> ffff880028203d70 ffffffff813e0162 ffff880028203d20 ffffffff8103b8ac
Call Trace:
<IRQ>
 [<ffffffff813de186>] serio_interrupt+0x36/0xa0
[<ffffffff813e0162>] i8042_interrupt+0x132/0x3a0
[<ffffffff8103b8ac>] ? kvm_clock_read+0x1c/0x20
[<ffffffff8103b8b9>] ? kvm_clock_get_cycles+0x9/0x10
[<ffffffff810e1640>] handle_IRQ_event+0x60/0x170
[<ffffffff8103b154>] ? kvm_guest_apic_eoi_write+0x44/0x50
[<ffffffff810e3d8e>] handle_edge_irq+0xde/0x180
[<ffffffff8100de89>] handle_irq+0x49/0xa0
[<ffffffff81516c8c>] do_IRQ+0x6c/0xf0
[<ffffffff8100b9d3>] ret_from_intr+0x0/0x11
[<ffffffff81076f63>] ? __do_softirq+0x73/0x1e0
[<ffffffff8109b75b>] ? hrtimer_interrupt+0x14b/0x260
[<ffffffff8100c1cc>] ? call_softirq+0x1c/0x30
[<ffffffff8100de05>] ? do_softirq+0x65/0xa0
[<ffffffff81076d95>] ? irq_exit+0x85/0x90
[<ffffffff81516d80>] ? smp_apic_timer_interrupt+0x70/0x9b
[<ffffffff8100bb93>] ? apic_timer_interrupt+0x13/0x20

To avoid the issue let's change the second check to test whether serio is
NULL or not.

Also, let's take i8042_lock in i8042_start() and i8042_stop() instead of
trying to be overly smart and using memory barriers and synchronize_irq().

Reported-by: Chen Hong <chenhong3@huawei.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/i8042.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index c52da651269b..2f19bdbf64b5 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -436,8 +436,10 @@ static int i8042_start(struct serio *serio)
 {
 	struct i8042_port *port = serio->port_data;
 
+	spin_lock_irq(&i8042_lock);
 	port->exists = true;
-	mb();
+	spin_unlock_irq(&i8042_lock);
+
 	return 0;
 }
 
@@ -450,16 +452,10 @@ static void i8042_stop(struct serio *serio)
 {
 	struct i8042_port *port = serio->port_data;
 
+	spin_lock_irq(&i8042_lock);
 	port->exists = false;
-
-	/*
-	 * We synchronize with both AUX and KBD IRQs because there is
-	 * a (very unlikely) chance that AUX IRQ is raised for KBD port
-	 * and vice versa.
-	 */
-	synchronize_irq(I8042_AUX_IRQ);
-	synchronize_irq(I8042_KBD_IRQ);
 	port->serio = NULL;
+	spin_unlock_irq(&i8042_lock);
 }
 
 /*
@@ -576,7 +572,7 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 
 	spin_unlock_irqrestore(&i8042_lock, flags);
 
-	if (likely(port->exists && !filtered))
+	if (likely(serio && !filtered))
 		serio_interrupt(serio, data, dfl);
 
  out:

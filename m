From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH] usbhid: Fix lockdep unannotated irqs-off warning
Date: Mon, 28 Sep 2015 10:10:04 +0200
Message-ID: <1443427804-2957-1-git-send-email-sedat.dilek@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35731 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756449AbbI1IKW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 04:10:22 -0400
Received: by wicge5 with SMTP id ge5so93081812wic.0
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2015 01:10:20 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Sedat Dilek <sedat.dilek@gmail.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>

When compiling Linux v4.2+ and v4.3-rc2+ with a llvmlinux patchset
and CLANG v3.7 I see a BUG line like this:

[   24.705463] BUG: sleeping function called from invalid context at kernel/workqueue.c:2680
[   24.705576] in_atomic(): 0, irqs_disabled(): 1, pid: 1447, name: acpid

After some vital help from workqueue and hid folks it turned out to be
a problem in the hid area.

Jiri encouraged me to look into del_timer-sync()/cancel_work_sync().
So, I disassembled kernel/time/timer.o.
This looked good.

Both functions are called in hid_cancel_delayed_stuff().
Adding a might_sleep() on top of it showed hints towards lockdep and
unannotated irqs-off.

[   23.723807] WARNING: CPU: 0 PID: 1451 at kernel/locking/lockdep.c:3519 check_flags+0x6c/0x1b0()
[   23.723866] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
...
[   23.774719] possible reason: unannotated irqs-off.

Dealing with irqflags-tracing I enabled some helpful kernel-options:

CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_TRACING=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_IRQSOFF_TRACER=y

The file irqflags-tracing.txt was helpful.
Steven Rostedt pointed me to the irqsoff section in ftrace.txt documentation.

Then, I tried to force to turn off the tracing of hardirqs in usbhid_close()
via trace_hardirqs_off() - line by line.
Finally, the spin_unlock_irq() within the if-statement looked like the culprit.

Looking through commits having a similiar issue, I replaced spin_{un}lock_irq()
with spin_{un}lock_bh() as this doesn't need interrupts disabled.

This fixed the issue for me.

Tested against Linux v4.3-rc3.

Still unsure why the same kernel built with GCC v4.9 does not show this.

Thanks to all involved people.

[1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/irqflags-tracing.txt
[2] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/trace/ftrace.txt#n906

CC: Jiri Kosina <jikos@kernel.org>
CC: linux-input@vger.kernel.org
CC: Tejun Heo <tj@kernel.org>
CC: Lai Jiangshan <jiangshanlai@gmail.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Paul McKenney <paulmck@linux.vnet.ibm.com>

---
 drivers/hid/usbhid/hid-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 36712e9f56c2..188f59348ec5 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -729,16 +729,16 @@ void usbhid_close(struct hid_device *hid)
 	 * data acquistion due to a resumption we no longer
 	 * care about
 	 */
-	spin_lock_irq(&usbhid->lock);
+	spin_lock_bh(&usbhid->lock);
 	if (!--hid->open) {
-		spin_unlock_irq(&usbhid->lock);
+		spin_unlock_bh(&usbhid->lock);
 		hid_cancel_delayed_stuff(usbhid);
 		if (!(hid->quirks & HID_QUIRK_ALWAYS_POLL)) {
 			usb_kill_urb(usbhid->urbin);
 			usbhid->intf->needs_remote_wakeup = 0;
 		}
 	} else {
-		spin_unlock_irq(&usbhid->lock);
+		spin_unlock_bh(&usbhid->lock);
 	}
 	mutex_unlock(&hid_open_mut);
 }
-- 
2.5.3


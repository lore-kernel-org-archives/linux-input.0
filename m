From: Bastian Hecht <hechtb@gmail.com>
Subject: [INFO] No re-enabling of IRQ line when using touchscreen during suspend
Date: Thu, 14 Feb 2013 11:29:52 -0600
Message-ID: <CABYn4sz2LdgTrY1ZBqWwY1zi4qygSkHWD+OPsoJF=PAq34kyyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Linux-SH <linux-sh@vger.kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Tony SIM <chinyeow.sim.xt@renesas.com>
List-Id: linux-input@vger.kernel.org

Hi,

I wanted to add this information that is related to my patch
submissions. Next to the i2c timeout issues dealt in "[PATCH] i2c:
sh_mobile: Don't start transfers when suspending" I'm experiencing
another problem when using the touchscreen during the suspend process.

When handling the touch the generic_irq_handler masks out the line,
but before the irq_thread can reenable it suspension seems to finish.
Thus we get stuck in the sleep mode without being able to wake using
this device. I'm unsure if this a general fault in the suspend code or
if it is somehow driver related.

My debug output on a kzm9g looks like this:


PM: Syncing filesystems ... enabling 568
done.
PM: Preparing system for mem sleep
disabling IRQ: 568 568
enabling 568
Freezing user space processes ... disabling IRQ: 568 568
enabling 568
disabling IRQ: 568 568
(elapsed 0.02 seconds) enabling 568
done.
Freezing remaining freezable tasks ... disabling IRQ: 568 568
enabling 568
disabling IRQ: 568 568
enabling 568
(elapsed 0.02 seconds) done.
PM: Entering mem sleep
Suspending console(s) (use no_console_suspend to debug)
disabling IRQ: 568 568


Cheers,

 Bastian

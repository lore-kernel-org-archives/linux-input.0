From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] i8042 / PM: Allow PC keyboard to wake up from suspend-to-idle
Date: Mon, 09 Mar 2015 23:41:12 +0100
Message-ID: <3127745.ybR8YAlvTb@vostro.rjw.lan>
References: <2197217.yzvHkR7SyK@vostro.rjw.lan> <20150309180004.GA22993@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49180 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750933AbbCIWRb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2015 18:17:31 -0400
In-Reply-To: <20150309180004.GA22993@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Monday, March 09, 2015 11:00:04 AM Dmitry Torokhov wrote:
> Hi Rafael,
> 
> On Mon, Mar 09, 2015 at 04:19:50PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > If they keyboard interrupt is registered, mark the i8042 platform
> > device as wakeup-capable and check the user space wakeup setting in
> > i8042_pm_suspend() and i8042_pm_resume() to enable or disable,
> > respectively, the keyboard interrupt to wake up the system.
> > 
> > This makes it possible to use the PC keyboard to wake up the system
> > from suspend-to-idle after writing "enabled" to the i8042 device's
> > power/wakeup sysfs attribute.
> 
> Why do we do that for KBD but not AUX port? Should we mark individual
> serio port be wakeup capable and not the whole i8042.

We can do that, but only after the port serio device has been registered.

I guess I can add code for that to i8042_register_ports().  Let me try that.

> Also, why exactly is this needed? My laptops seem to resume just fine
> from keyboard activity without this patch...

Mine don't.  At least not from suspend-to-idle ("echo freeze > /sys/power/state").

Whether or not the PC keyboard wakes them up from suspend-to-RAM depends on the
BIOS.  That only works for one of my laptops, but this patch doesn't help here.

Rafael


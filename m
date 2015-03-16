From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] i8042 / PM: Allow PC keyboard to wake up from suspend-to-idle
Date: Tue, 17 Mar 2015 00:20:49 +0100
Message-ID: <1902569.dAVq7nl4i8@vostro.rjw.lan>
References: <2197217.yzvHkR7SyK@vostro.rjw.lan> <2514027.izE5Direg3@vostro.rjw.lan> <20150316211108.GC11441@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52591 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750948AbbCPW45 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 18:56:57 -0400
In-Reply-To: <20150316211108.GC11441@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Monday, March 16, 2015 10:11:08 PM Pavel Machek wrote:
> On Tue 2015-03-10 00:08:43, Rafael J. Wysocki wrote:
> > On Monday, March 09, 2015 11:41:12 PM Rafael J. Wysocki wrote:
> > > On Monday, March 09, 2015 11:00:04 AM Dmitry Torokhov wrote:
> > > > Hi Rafael,
> > > > 
> > > > On Mon, Mar 09, 2015 at 04:19:50PM +0100, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > 
> > > > > If they keyboard interrupt is registered, mark the i8042 platform
> > > > > device as wakeup-capable and check the user space wakeup setting in
> > > > > i8042_pm_suspend() and i8042_pm_resume() to enable or disable,
> > > > > respectively, the keyboard interrupt to wake up the system.
> > > > > 
> > > > > This makes it possible to use the PC keyboard to wake up the system
> > > > > from suspend-to-idle after writing "enabled" to the i8042 device's
> > > > > power/wakeup sysfs attribute.
> > > > 
> > > > Why do we do that for KBD but not AUX port? Should we mark individual
> > > > serio port be wakeup capable and not the whole i8042.
> > > 
> > > We can do that, but only after the port serio device has been registered.
> > > 
> > > I guess I can add code for that to i8042_register_ports().  Let me try that.
> > 
> > Yeah, that works too.  And you're right that there's no reason to do that for
> > keyboard only.
> 
> Actually, are you sure?
> 
> Resuming on mouse click is reasonable, resuming on mouse move is not,
> as table vibrations are likely to cause that.

This is disabled by default, so user space has to enable it anyway if it wants
to.

Rafael


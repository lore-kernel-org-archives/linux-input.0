From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] i8042 / PM: Allow PC keyboard to wake up from
 suspend-to-idle
Date: Mon, 16 Mar 2015 22:11:08 +0100
Message-ID: <20150316211108.GC11441@amd>
References: <2197217.yzvHkR7SyK@vostro.rjw.lan>
 <20150309180004.GA22993@dtor-ws>
 <3127745.ybR8YAlvTb@vostro.rjw.lan>
 <2514027.izE5Direg3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2514027.izE5Direg3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue 2015-03-10 00:08:43, Rafael J. Wysocki wrote:
> On Monday, March 09, 2015 11:41:12 PM Rafael J. Wysocki wrote:
> > On Monday, March 09, 2015 11:00:04 AM Dmitry Torokhov wrote:
> > > Hi Rafael,
> > > 
> > > On Mon, Mar 09, 2015 at 04:19:50PM +0100, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > 
> > > > If they keyboard interrupt is registered, mark the i8042 platform
> > > > device as wakeup-capable and check the user space wakeup setting in
> > > > i8042_pm_suspend() and i8042_pm_resume() to enable or disable,
> > > > respectively, the keyboard interrupt to wake up the system.
> > > > 
> > > > This makes it possible to use the PC keyboard to wake up the system
> > > > from suspend-to-idle after writing "enabled" to the i8042 device's
> > > > power/wakeup sysfs attribute.
> > > 
> > > Why do we do that for KBD but not AUX port? Should we mark individual
> > > serio port be wakeup capable and not the whole i8042.
> > 
> > We can do that, but only after the port serio device has been registered.
> > 
> > I guess I can add code for that to i8042_register_ports().  Let me try that.
> 
> Yeah, that works too.  And you're right that there's no reason to do that for
> keyboard only.

Actually, are you sure?

Resuming on mouse click is reasonable, resuming on mouse move is not,
as table vibrations are likely to cause that.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

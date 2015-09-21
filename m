From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Mon, 21 Sep 2015 14:30:55 +0200
Message-ID: <20150921123055.GB16589@amd>
References: <CAJZ5v0j5XN3Y=YW4jWekUB9qwL5KAVkeDMdhMiKv6j=xLa8psA@mail.gmail.com>
 <Pine.LNX.4.44L0.1509091118000.2045-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1509091118000.2045-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Tirdea, Irina" <irina.tirdea@intel.com>, Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Wed 2015-09-09 11:20:25, Alan Stern wrote:
> On Wed, 9 Sep 2015, Rafael J. Wysocki wrote:
> 
> > > The best example and actually the very specific problem we want to
> > > solve is handling touchscreens on a phone / tablet. When the screen is
> > > turned off, it is ideal to suspend the touchscreen for two reasons: to
> > > lower the power consumption as much as possible and to prevent
> > > interrupts to wake-up the CPU when the user touches the device, and
> > > thus save even more power as we allow the CPU to stay in deep idle
> > > states for longer periods.
> > >
> > > Note that when the screen is turned-on again, we want to resume the
> > > touchscreen so that it can send events again.
> > 
> > In fact, then, what you need seems to be the feature discussed by Alan
> > and me some time ago allowing remote wakeup do be disabled for runtime
> > PM from user space as that in combination with autosuspend should
> > address your use case.
> 
> That, plus they want the touchscreen to go into runtime suspend 
> whenever the screen is off (was this not the main reason for the 
> patch?).
> 
> It seems to me that it should be possible to arrange for this to happen 
> simply by making userspace close the touchscreen device when the screen 
> is turned off.  Or am I missing something?

Well... that's not what existing userspace expects. Your X windows
server will not close the touchscreen.

..and it would be nice to have enough hardware abstraction in the
kernel so that X can be used on phones...
									
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Mon, 21 Sep 2015 10:38:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509211035000.1713-100000@iolanthe.rowland.org>
References: <20150921123055.GB16589@amd>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150921123055.GB16589@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Tirdea, Irina" <irina.tirdea@intel.com>, Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Mon, 21 Sep 2015, Pavel Machek wrote:

> > > In fact, then, what you need seems to be the feature discussed by Alan
> > > and me some time ago allowing remote wakeup do be disabled for runtime
> > > PM from user space as that in combination with autosuspend should
> > > address your use case.
> > 
> > That, plus they want the touchscreen to go into runtime suspend 
> > whenever the screen is off (was this not the main reason for the 
> > patch?).
> > 
> > It seems to me that it should be possible to arrange for this to happen 
> > simply by making userspace close the touchscreen device when the screen 
> > is turned off.  Or am I missing something?
> 
> Well... that's not what existing userspace expects. Your X windows
> server will not close the touchscreen.

Surely that's a userspace issue, rather than a kernel problem?  The X
server does have some notion of power management and power savings; why
not extend that notion to include touchscreens?

> ..and it would be nice to have enough hardware abstraction in the
> kernel so that X can be used on phones...

What -- not Wayland?!  :-)

Alan Stern


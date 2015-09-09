From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Wed, 9 Sep 2015 10:33:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509091031460.2045-100000@iolanthe.rowland.org>
References: <1441779966.26994.52.camel@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1441779966.26994.52.camel@suse.com>
Sender: linux-pm-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: "Tirdea, Irina" <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Purdila, Octavian" <octavian.purdila@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Wed, 9 Sep 2015, Oliver Neukum wrote:

> On Tue, 2015-09-08 at 10:44 -0400, Alan Stern wrote:
> > It would not put the device into runtime suspend immediately, like you
> > are proposing.  Instead it would mean the same as the "auto" mode,
> > except that remote wakeup should be disabled during runtime suspend.
> 
> Hi,
> 
> this proposal is incomplete. If you don't want remote wakeup you
> imply that input is no longer needed or possible. If that is
> already known, we can just as well inform the driver, so that
> it can cease IO for input.

Like I said, it was never implemented.  For that reason, it was never 
completely fleshed out.

> Yet that is not necessarily the only scenario. For example
> if you run a screensaver, you might not care for where the
> user touches the screen, but the event as such is valuable.

I suspect it's not worth the effort to distinguish between getting an 
event with all the details and merely knowing that an event occurred.

Alan Stern


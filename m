From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Mon, 28 Sep 2015 16:23:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509281614570.1612-100000@iolanthe.rowland.org>
References: <CAJZ5v0iROHkuXBPKw_tY_xRuV+N8_C=rU_rWePK44YJVWz36Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iROHkuXBPKw_tY_xRuV+N8_C=rU_rWePK44YJVWz36Gg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Oliver Neukum <oneukum@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Len Brown <len.brown@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

On Mon, 28 Sep 2015, Rafael J. Wysocki wrote:

> Hi Alan,
> 
> On Mon, Sep 28, 2015 at 4:29 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Mon, 28 Sep 2015, Rafael J. Wysocki wrote:
> >
> >> > This suggests we forget about power/wakeup == "off" and introduce an
> >> > "inhibit" attribute instead.
> >>
> >> If we do that, can it still be regarded as a PM attribute?
> >
> > Why not?  Consider this: Is there any reason to support inhibit when
> > CONFIG_PM is disabled?  I can't come up with any.
> 
> Well, the "I don't want any input from you now, because the phone is
> going into a pocket" case?

But who would make a phone without CONFIG_PM?  If you're sufficiently 
unconcerned about power usage that you turn off CONFIG_PM, then you 
probably don't care about getting excess input events either.

> It isn't stticlty dependent on PM.

No, not strictly.  But it is closely enough related that people
shouldn't mind if it becomes part of the PM code.

> >> > Well, I suppose there might be a driver that supports inhibit but
> >> > doesn't support runtime PM, unlikely as that seems.  Or the driver
> >> > might support both but the user might leave power/control == "on" while
> >> > inhibiting the device.
> >>
> >> That sounds like a general rather than PM-related mechanism then.
> >
> > I don't follow your reasoning.
> 
> Support for "inhibit" and lack of runtime PM support means that the
> feature has nothing to do with PM any more AFAICS.

My example above referred to support in a single driver, not support in 
the system as a whole.  By the same reasoning, since some drivers 
support system sleep but not runtime PM, system sleep must have nothing 
to do with PM.  :-)

> That's why I think it may be regarded by more than just PM.  It should
> make runtime PM behave in a specific way if supported, but then it
> should work withot it too, shouldn't it?

If you want inhibit to be part of the device core rather than the PM
core, that's okay with me.

> My opinion is that "inhibit" should affect PM, but should not require
> PM to function (there's no technical reason for that).

All right.  Then a design should be straightforward.

Alan Stern

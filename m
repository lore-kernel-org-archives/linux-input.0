From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Wed, 23 Sep 2015 10:27:56 +0300
Message-ID: <CAE1zotKKhmiNh92x8Hp8CyL0X0GyU4N509tm5vqVOVLeeqyn5g@mail.gmail.com>
References: <Pine.LNX.4.44L0.1509221116430.1742-100000@iolanthe.rowland.org>
	<1442977394.8607.8.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1442977394.8607.8.camel@suse.de>
Sender: linux-pm-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Sep 23, 2015 at 6:03 AM, Oliver Neukum <oneukum@suse.de> wrote:
>
> On Tue, 2015-09-22 at 11:22 -0400, Alan Stern wrote:
> > On Tue, 22 Sep 2015, Oliver Neukum wrote:
> >
> > > Cancel, yes, going to low power is a consequence which needn't bother
> > > the power subsystem.
> >
> > Going to low power needn't involve the power subsystem?  That sounds
> > weird.
>
> Think of it like rfkill. It makes sense to suspend an rfkilled device.
> It still is the job of the driver to report that its device is idle.
>
> > >  You need a callback. If there are spurious
> > > events, the current heuristics will keep devices awake.
> > > You must discard them anyway, as they are spurious. There's no point
> > > in transporting over the bus at all. We can cease IO for input.
> > >
> > > > This would create a parallel runtime-PM mechanism which is independent
> > > > of the existing one.  Is that really a good idea?
> > >
> > > It isn't strictly PM. It helps PM to do a better job, but
> > > conceptually it is independent.
> >
> > So my next question is: _How_ can this help PM to do a better job?
> > That is, what are the mechanisms?
>
> "inhibit" -> driver stops input -> driver sets PM count to zero
> -> PM subsystem acts
>
> To go from the first to the second step a callback is needed
>

The IIO drivers use this model. The application keeps the fd open but
there is a buffer enable switch to enable / disable input. Based on
that trigger drivers use pm runtime put operations to induce PM
idleness (and pm runtime get to wakeup the device).

> > One you have already stated: Lack of spurious events will help prevent
> > unwanted wakeups (or unwanted failures to go to sleep).
>
> That too. We also save CPU cycles.
>
> > But Dmitry made a stronger claim: Inhibiting an input device should
> > allow the device to go to low power.  I would like to know how we can
> > implement this cleanly.  The most straightforward approach is to use
> > runtime PM, but it's not obvious how this can be made to work with the
> > current API.
>
> Yes, we can use the current API.
> The key is that you think of the mechanism as induced idleness,
> not forced suspend. We already have a perfectly working mechanism
> for suspending idle devices.
>

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing runtime suspend
Date: Wed, 09 Sep 2015 22:25:23 +0200
Message-ID: <1870624.bK0YQxbsoD@vostro.rjw.lan>
References: <1441658561-26190-1-git-send-email-irina.tirdea@intel.com> <1441806946.19223.5.camel@suse.com> <CAE1zotKye=grm2CR+0Q25t7B3ZFo_LjrHa5qLYbCUv9=tYTSmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE1zotKye=grm2CR+0Q25t7B3ZFo_LjrHa5qLYbCUv9=tYTSmw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>, Oliver Neukum <oneukum@suse.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Tirdea, Irina" <irina.tirdea@intel.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Colin Cross <ccross@android.com>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
List-Id: linux-input@vger.kernel.org

On Wednesday, September 09, 2015 06:02:02 PM Octavian Purdila wrote:
> On Wed, Sep 9, 2015 at 4:55 PM, Oliver Neukum <oneukum@suse.com> wrote:
> > On Wed, 2015-09-09 at 14:22 +0200, Rafael J. Wysocki wrote:
> >> > Note that when the screen is turned-on again, we want to resume the
> >> > touchscreen so that it can send events again.
> >
> > Why is it impractical to close the fd for the touchscreen?
> >
> 
> I am not sure, but I think it is this way due to historical reasons.
> On Android devices early-suspend was used originally to save power
> when the screen was turned-off but the device was not suspend. Later
> Android moved to power HAL [1] and run-time PM for some devices,
> however that is not sufficient for touchscreen.
> 
> i2c touchscreen devices usually have two low-power states: a deep
> power state where event collection is disabled and the device needs to
> be poked via i2c to restart collecting events and a shallow power
> state where the device reduces the internal polling rate after it is
> idle for some time. The latter it is usually implemented directly in
> hardware. That means that you can't really implemented auto-suspend
> with the deep power state, since the device can not resume itself.
> 
> To address this limitation, Android used early suspend (and then the
> power HAL mechanism) where the upper layers signals when you can turn
> on or off certain devices.
> 
> I have added Colin and Arve to this thread who maybe can answer this better.
> 
> >> In fact, then, what you need seems to be the feature discussed by Alan
> >> and me some time ago allowing remote wakeup do be disabled for runtime
> >> PM from user space as that in combination with autosuspend should
> >> address your use case.
> >
> > I'd doubt that. Suppose you put the phone into your pocket while
> > the device isn't suspended. The continuous stream of spurious events
> > will keep it awake.

Why would they be regarded as spurious then?  They are just regular touch panel
events in that case, aren't they?

> I agree.
> 
> > The ability to disable remote wakeup is necessary but not sufficient.
> >
> 
> I don't know enough about remote wake-up, but do we even need to use
> it for this kind of devices?

Well, if the device is capable of generating wakeup events while suspended,
the current expected behavior is to do that, but of course that needs to
be enabled by the driver/bus type too.

Thanks,
Rafael

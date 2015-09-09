From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing runtime suspend
Date: Wed, 09 Sep 2015 22:35:12 +0200
Message-ID: <4206072.KuQlnyyHaz@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1509091118000.2045-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1509091118000.2045-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Octavian Purdila <octavian.purdila@intel.com>, "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Oliver Neukum <oneukum@suse.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Wednesday, September 09, 2015 11:20:25 AM Alan Stern wrote:
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

Right.

> It seems to me that it should be possible to arrange for this to happen 
> simply by making userspace close the touchscreen device when the screen 
> is turned off.  Or am I missing something?

Honestly, I don't know.

Octavian, Irina, any reasons why things can't be done as Alan is suggesting?

Thanks,
Rafael

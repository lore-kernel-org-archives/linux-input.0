From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing runtime suspend
Date: Mon, 28 Sep 2015 15:47:22 +0200
Message-ID: <1859392.HSqFSV3NKL@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1509261110470.4211-100000@netrider.rowland.org> <1493729.nvxxQyxdme@vostro.rjw.lan> <20150927170217.GA3303@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56039 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933479AbbI1NTF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 09:19:05 -0400
In-Reply-To: <20150927170217.GA3303@xo-6d-61-c0.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Len Brown <len.brown@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Sunday, September 27, 2015 07:02:17 PM Pavel Machek wrote:
> Hi!

Hi,

> > > > > That, or there may be an additional value, say "aggressive", to write to the
> > > > > control file in which case it becomes just
> > > > > 
> > > > > echo aggressive >/sys/.../power/control
> > > > 
> > > > That said I suppose that the "off" value for the "wakeup" file might also be
> > > > useful in some other cases, so it likely is a better approach.
> > > 
> > > We still need some sort of "inhibit" callback for cases where the
> > > driver doesn't want to go into runtime suspend but does want to turn
> > > off all I/O.  Should this callback be triggered when the user writes
> > > "off" to power/wakeup, or when the user writes "inhibit" to
> > > power/control, or should there be a separate sysfs attribute?
> > 
> > My first thought is that if there is a separate attribute, then it only actually
> > makes sense for devices that generate input events, while the "off" thing may
> > be generally useful in principle (eg. it may indicate to disable PME for the
> > device to the PCI layer etc).
> > 
> > OTOH, the additional "inhibit" attribute may only be exposed if the corresponding
> > callback is present, so I'm not really sure.
> > 
> > Question is, though, what's the use case for turning off I/O when we don't
> > go into runtime suspend.  After all, runtime suspend need not mean putting
> 
> Well... In "cellphone goes to pocket" case, you want to turn off I/O even if
> the touchscreen can not support runtime suspend.
> 
> See parents in the thread for explanation.

You seem to be confusing the ability to go into low-power states with supporting
runtime PM.  The latter by no means requires the former.

Also "cellphone goes to pocket" is really two different cases.  One is when
the user indicated "I'm not going to use the phone going forward" somehow (like
by pressing a screen-off button) and one is when (s)he didn't.

In the second case we really have no reason to discard any input and in the
first one we may as well go straight for runtime suspend (or even for system
suspend for that matter).

Thanks,
Rafael


From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Sun, 4 Oct 2015 17:16:35 +0200
Message-ID: <20151004151635.GC12684@xo-6d-61-c0.localdomain>
References: <CAJZ5v0iROHkuXBPKw_tY_xRuV+N8_C=rU_rWePK44YJVWz36Gg@mail.gmail.com>
 <Pine.LNX.4.44L0.1509281614570.1612-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1509281614570.1612-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Oliver Neukum <oneukum@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Len Brown <len.brown@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

Hi!

> > >
> > >> > This suggests we forget about power/wakeup == "off" and introduce an
> > >> > "inhibit" attribute instead.
> > >>
> > >> If we do that, can it still be regarded as a PM attribute?
> > >
> > > Why not?  Consider this: Is there any reason to support inhibit when
> > > CONFIG_PM is disabled?  I can't come up with any.
> > 
> > Well, the "I don't want any input from you now, because the phone is
> > going into a pocket" case?
> 
> But who would make a phone without CONFIG_PM?  If you're sufficiently 
> unconcerned about power usage that you turn off CONFIG_PM, then you 
> probably don't care about getting excess input events either.

Well.. .excess input events means that your phone now sends (meaningful, thanks
to advanced predictions) messages to your friends...

Better not do that.

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

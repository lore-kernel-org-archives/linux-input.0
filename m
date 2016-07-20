From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.1 to v4.7: regression in tsc2005 driver
Date: Wed, 20 Jul 2016 22:22:01 +0200
Message-ID: <20160720202201.GA2290@amd>
References: <20160717175257.GA26719@amd>
 <20160717182445.GA20058@deathstar>
 <20160717184209.GA30119@amd>
 <20160717185134.GA20462@deathstar>
 <20160717200339.GA29562@amd>
 <20160717225636.GB20462@deathstar>
 <20160719235120.GD19250@dtor-ws>
 <20160720062558.GA3792@amd>
 <20160720162356.GA25655@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160720162356.GA25655@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Welling <mwelling@ieee.org>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Peter Hutterer <peter.hutterer@who-t.net>
List-Id: linux-input@vger.kernel.org

Hi!

> > > > > > > > > drivers/input/touchscreen/tsc2005.c:	  input_dev->name = "TSC2005
> > > > > > > > > touchscreen";
> > > > > > > > > 
> > > > > > > > > to "TSC200X touchscreen". Unfortunately, X seems to propagate that
> > > > > > > > > name to userspace, where it is needed to be able to do
> > > 
> > > Technically X _is_ userspace.
> > 
> > There's "userspace running as root" and "userspace userspace" :-).
> 
> I do not really see any difference form the kernel POW. 
> 
> > 
> > > > > > > > > 
> > > > > > > > > xinput --set-prop --type=int ...
> > > > > > > > > 
> > > > > > > > > with the right arguments to calibrate touchscreen. (Touchscreen is
> > > > > > > > > unusable without calibration).
> > > > > > > > > 
> > > > > > > > > What to do with that?
> > > 
> > > Hmm, I do not think we ever committed for the device names to be stable.
> > > You are supposed to locate touchscreen device based on its properties
> > > and you might need some heuristic if you encounter a system with more
> > > than one such touchscreen.
> > 
> > Well, you are commited now, like it or not, X people did it for you
> > :-(.
> > 
> > Because there's no other reasonable way to use xinput --set-prop...
> 
> Well, X is going to have to fix it. How am I supposed to control my
> devices in multi-seat environment if I use the same hardware (or if I
> have device with multiple touchscreens)? They all will have the same
> name (well, all mice, then all keyboards, etc). Let's add Peter to the
> fold...

Well, if someone has such a multiseat config, they have a problem. But
in the meantime, I'd like to keep working system.

http://who-t.blogspot.cz/2016/07/xinput-resolves-device-names-and.html

And I see you replied in the blog. Good. Yes, X needs to be improved
to work nicely with multiseat. Still kernel needs to play nice and not
have regressions.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

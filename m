From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: v4.1 to v4.7: regression in tsc2005 driver
Date: Wed, 20 Jul 2016 15:20:02 -0700
Message-ID: <20160720222002.GD26006@dtor-ws>
References: <20160717175257.GA26719@amd>
 <20160717182445.GA20058@deathstar>
 <20160717184209.GA30119@amd>
 <20160717185134.GA20462@deathstar>
 <20160717200339.GA29562@amd>
 <20160717225636.GB20462@deathstar>
 <20160719235120.GD19250@dtor-ws>
 <20160720062558.GA3792@amd>
 <20160720162356.GA25655@dtor-ws>
 <20160720214736.GA4321@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160720214736.GA4321@jelly>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Pavel Machek <pavel@ucw.cz>, Michael Welling <mwelling@ieee.org>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-input@vger.kernel.org

On Thu, Jul 21, 2016 at 07:47:36AM +1000, Peter Hutterer wrote:
> On Wed, Jul 20, 2016 at 09:23:56AM -0700, Dmitry Torokhov wrote:
> > On Wed, Jul 20, 2016 at 08:25:58AM +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > > > > > > drivers/input/touchscreen/tsc2005.c:	  input_dev->name = "TSC2005
> > > > > > > > > > touchscreen";
> > > > > > > > > > 
> > > > > > > > > > to "TSC200X touchscreen". Unfortunately, X seems to propagate that
> > > > > > > > > > name to userspace, where it is needed to be able to do
> > > > 
> > > > Technically X _is_ userspace.
> > > 
> > > There's "userspace running as root" and "userspace userspace" :-).
> > 
> > I do not really see any difference form the kernel POW. 
> > 
> > > 
> > > > > > > > > > 
> > > > > > > > > > xinput --set-prop --type=int ...
> > > > > > > > > > 
> > > > > > > > > > with the right arguments to calibrate touchscreen. (Touchscreen is
> > > > > > > > > > unusable without calibration).
> > > > > > > > > > 
> > > > > > > > > > What to do with that?
> > > > 
> > > > Hmm, I do not think we ever committed for the device names to be stable.
> > > > You are supposed to locate touchscreen device based on its properties
> > > > and you might need some heuristic if you encounter a system with more
> > > > than one such touchscreen.
> > > 
> > > Well, you are commited now, like it or not, X people did it for you
> > > :-(.
> > > 
> > > Because there's no other reasonable way to use xinput --set-prop...
> > 
> > Well, X is going to have to fix it. How am I supposed to control my
> > devices in multi-seat environment if I use the same hardware (or if I
> > have device with multiple touchscreens)? They all will have the same
> > name (well, all mice, then all keyboards, etc). Let's add Peter to the
> > fold...
> > 
> > In the mean time you can adjust the name or use XID instead.
> 
> X has partially fixed this a few years ago. All input drivers (that
> matter) export a Device Node property that sets the device node for each
> device.
> 
>  $ xinput list-props "SynPS/2 Synaptics TouchPad" | grep "Device Node"
>         Device Node (261):      "/dev/input/event4"
> 
> Based on that you can get the udev device and work your way into any of the
> sysfs tree. Or do whatever else you want.

The issue is not that I can't figure out sysfs path for a device, the
issue is that xinput does not accept anything but name or XID and I may
have multiple devices with the same name in the system.

> 
> But other than that there isn't anything in X to fix. xinput is primarily a
> debugging tool and it does name resolution for convenience. But it's not a
> tool for complex configurations. It does exactly what it needs to do, if you

OK, I do not believe that this information was conveyed clearly enough.
Apparently some setups use it for real configuration.

> need something that's more complicated and relies on information not
> available to the X device itself then you'll need to write a custom tool
> that does what you need. sorry.

Pavel, ^^^^


Thanks.

-- 
Dmitry

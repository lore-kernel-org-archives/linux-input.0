From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: v4.1 to v4.7: regression in tsc2005 driver
Date: Fri, 22 Jul 2016 10:10:12 +1000
Message-ID: <20160722001012.GA11426@jelly>
References: <20160717185134.GA20462@deathstar>
 <20160717200339.GA29562@amd>
 <20160717225636.GB20462@deathstar>
 <20160719235120.GD19250@dtor-ws>
 <20160720062558.GA3792@amd>
 <20160720162356.GA25655@dtor-ws>
 <20160720214736.GA4321@jelly>
 <20160721063234.GA14200@amd>
 <20160721064241.GA31008@jelly>
 <20160721085421.GA15485@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160721085421.GA15485@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Welling <mwelling@ieee.org>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-input@vger.kernel.org

On Thu, Jul 21, 2016 at 10:54:21AM +0200, Pavel Machek wrote:
> On Thu 2016-07-21 16:42:41, Peter Hutterer wrote:
> > On Thu, Jul 21, 2016 at 08:32:34AM +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > In the mean time you can adjust the name or use XID instead.
> > > > 
> > > > X has partially fixed this a few years ago. All input drivers (that
> > > > matter) export a Device Node property that sets the device node for each
> > > > device.
> > > > 
> > > >  $ xinput list-props "SynPS/2 Synaptics TouchPad" | grep "Device Node"
> > > >         Device Node (261):      "/dev/input/event4"
> > > > 
> > > > Based on that you can get the udev device and work your way into any of the
> > > > sysfs tree. Or do whatever else you want.
> > > > 
> > > > But other than that there isn't anything in X to fix. xinput is primarily a
> > > > debugging tool and it does name resolution for convenience. But it's not a
> > > > tool for complex configurations. It does exactly what it needs to do, if you
> > > > need something that's more complicated and relies on information not
> > > > available to the X device itself then you'll need to write a custom tool
> > > > that does what you need. sorry.
> > > 
> > > Ok.. so out of the box, touchscreen is "upside down" and miscalibrated
> > > on n900. So I need to run
> > > 
> > > xinput --set-prop --type=float 8 115  1.10 0.00 -0.05  0.00 1.18 -0.10 0.00 0.00 1.00
> > > xinput --set-prop --type=int 8 249 0 1
> > > 
> > > (or equivalent with names) so that I can use the touchscreen. (And
> > > that's quite important -- X is somehow unusable without pointing
> > > device).
> > > 
> > > If xinput is not the right solution, what is the right solution?
> > 
> > if it's reliably miscalibrated (i.e. the numbers don't change), use an
> > xorg.conf snippet. If it needs some run-time changes add the hooks
> > to
> 
> Does not change and is needed for all the N900's.
> 
> Well. I guess xorg.conf snippet will do the trick, but that's hardly
> better.

it's a lot better than running xinput. with the config snippet have the
device ready to go at server startup, across VT switches, server restarts
and device unplugs. for something static, especially if it's custom hardware
like this shipping an xorg.conf file is always preferable over xinput
scripts

> Should x.org have internal database saying "Nokia N900 with tsc2005
> touchscreen means this calibration"?

we sort-of do have this, look at xserver/config/10-quirks.conf
problem is though that we'd need to match on the N900 too unless the tsc2005
is used nowhere else

> Should we have calibration info in the device tree, with kernel
> passing it to the x?
> 
> Should kernel somehow do the calibration itself?

if the kernel knows about the calibration it would make more sense to just
do it in the kernel directly. but for anything even remotely run-time or
user-configured the xorg.conf snippet is the best solution.

Cheers,
   Peter

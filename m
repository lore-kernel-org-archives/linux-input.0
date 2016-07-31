From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: v4.1 to v4.7: regression in tsc2005 driver
Date: Mon, 1 Aug 2016 07:28:54 +1000
Message-ID: <20160731212854.GA11374@jelly>
References: <20160719235120.GD19250@dtor-ws>
 <20160720062558.GA3792@amd>
 <20160720162356.GA25655@dtor-ws>
 <20160720214736.GA4321@jelly>
 <20160721063234.GA14200@amd>
 <20160721064241.GA31008@jelly>
 <20160721085421.GA15485@amd>
 <20160721090429.GP29844@pali>
 <20160722001219.GB11426@jelly>
 <20160725145917.GZ29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160725145917.GZ29844@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Welling <mwelling@ieee.org>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, sre@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-input@vger.kernel.org

On Mon, Jul 25, 2016 at 04:59:17PM +0200, Pali Rohár wrote:
> On Friday 22 July 2016 10:12:19 Peter Hutterer wrote:
> > On Thu, Jul 21, 2016 at 11:04:29AM +0200, Pali Rohár wrote:
> > > On Thursday 21 July 2016 10:54:21 Pavel Machek wrote:
> > > > On Thu 2016-07-21 16:42:41, Peter Hutterer wrote:
> > > > > On Thu, Jul 21, 2016 at 08:32:34AM +0200, Pavel Machek wrote:
> > > > > > Hi!
> > > > > > 
> > > > > > > > In the mean time you can adjust the name or use XID instead.
> > > > > > > 
> > > > > > > X has partially fixed this a few years ago. All input drivers (that
> > > > > > > matter) export a Device Node property that sets the device node for each
> > > > > > > device.
> > > > > > > 
> > > > > > >  $ xinput list-props "SynPS/2 Synaptics TouchPad" | grep "Device Node"
> > > > > > >         Device Node (261):      "/dev/input/event4"
> > > > > > > 
> > > > > > > Based on that you can get the udev device and work your way into any of the
> > > > > > > sysfs tree. Or do whatever else you want.
> > > > > > > 
> > > > > > > But other than that there isn't anything in X to fix. xinput is primarily a
> > > > > > > debugging tool and it does name resolution for convenience. But it's not a
> > > > > > > tool for complex configurations. It does exactly what it needs to do, if you
> > > > > > > need something that's more complicated and relies on information not
> > > > > > > available to the X device itself then you'll need to write a custom tool
> > > > > > > that does what you need. sorry.
> > > > > > 
> > > > > > Ok.. so out of the box, touchscreen is "upside down" and miscalibrated
> > > > > > on n900. So I need to run
> > > > > > 
> > > > > > xinput --set-prop --type=float 8 115  1.10 0.00 -0.05  0.00 1.18 -0.10 0.00 0.00 1.00
> > > > > > xinput --set-prop --type=int 8 249 0 1
> > > > > > 
> > > > > > (or equivalent with names) so that I can use the touchscreen. (And
> > > > > > that's quite important -- X is somehow unusable without pointing
> > > > > > device).
> > > > > > 
> > > > > > If xinput is not the right solution, what is the right solution?
> > > > > 
> > > > > if it's reliably miscalibrated (i.e. the numbers don't change), use an
> > > > > xorg.conf snippet. If it needs some run-time changes add the hooks
> > > > > to
> > > > 
> > > > Does not change and is needed for all the N900's.
> > > > 
> > > > Well. I guess xorg.conf snippet will do the trick, but that's hardly
> > > > better.
> > > > 
> > > > Should x.org have internal database saying "Nokia N900 with tsc2005
> > > > touchscreen means this calibration"?
> > > > 
> > > > Should we have calibration info in the device tree, with kernel
> > > > passing it to the x?
> > > > 
> > > > Should kernel somehow do the calibration itself?
> > > 
> > > From my memory how this problem is solved on Maemo 5:
> > > 
> > > There is XML snippet of HAL file which contains xorg properties for
> > > input driver. Xorg server loads from HAL xorg settings and somehow
> > > propagate them. That file is generated either from default system data
> > > (those comes from DEB package) or from user config file (that is
> > > generated from Settings application) or from CAL partition (NAND
> > > partition which contains device/product specific calibration data).
> > > 
> > > Because it is read also from CAL, I need to say those data does not have
> > > to be same for all N900 devices.
> > > 
> > > And because there is Settings application which can re-calibrate
> > > touchscreen, those data are not even static.
> > > 
> > > Now HAL is deprecated, but I suspect that xorg.conf.d/ directory or UDEV
> > > can be used in same way to propagate device specific settings for
> > > touchscreen device...
> > 
> > yes, xorg.conf.d snippets replaced HAL configuration, with pretty much the
> > same functionality. Using udev is not generally recommended.
> 
> In case that calibration data are stored in different format as
> xorg.conf.d accept (and these data can be changed), what is preferred
> way for pushing these calibration into X server?

write out an xorg.conf.d snippet file that contains the required options.
this is what we already do for system-wide keyboard layouts (see localectl).

> I thought that udev could be right way as it contains key/value
> properties in unified format (not X specific) and lot of other helpers
> fill these data for different devices.

there is no "unified format" for configurations. you still need to agree on
the key name and value format. e.g. for a calibration matrix: is it 6
numbers or all 9? is it in floats, percent, or device units?
in the end what you'd be doing is just push the driver-specific
configuration to udev. that's mostly fine for some values, not so great for
others where the usage isn't as clear (see the commend about libinput below).

> Why is is not generally recommended?

because udev is not a storage mechanism for X. we made the mistake in
earlier X server versions to use HAL as config storage but there is a
distinct mismatch when you have xorg.conf and some external config data
feeding into the server. since server 1.8 (~2008 or so) we don't use
configuration data in udev.

fwiw, libinput has a slightly different approach here, we do push *some*
device configuration into udev but only those bits that are considered
hardware properties and thus both immutable and required by anything else
that wants to use the device. examples are fixes to the axis ranges, tags to
identify the device type, etc.

Cheers,
   Peter

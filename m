From: Onkalo Samu <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] drivers: misc: ak8974 / ami305 magnetometer driver
Date: Mon, 30 Aug 2010 09:55:00 +0300
Message-ID: <1283151300.16404.18.camel@4fid08082>
References: <1282910083-8629-1-git-send-email-samu.p.onkalo@nokia.com>
	 <1282910083-8629-2-git-send-email-samu.p.onkalo@nokia.com>
	 <20100827133109.1eb974ed@lxorguk.ukuu.org.uk>
	 <1282928353.2194.27.camel@noppispoppis.nmp.nokia.com>
	 <20100827185343.GA6626@opensource.wolfsonmicro.com>
Reply-To: samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100827185343.GA6626-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, ext Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: ext Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 2010-08-27 at 20:53 +0200, ext Mark Brown wrote:
> On Fri, Aug 27, 2010 at 07:59:13PM +0300, Onkalo Samu wrote:
> > On Fri, 2010-08-27 at 14:31 +0200, ext Alan Cox wrote:
> 
> > > > +static int ak8974_regulators_on(struct ak8974_chip *chip)
> > > > +{
> > > > +	int ret;
> > > > +	ret = regulator_bulk_enable(ARRAY_SIZE(chip->regs), chip->regs);
> 
> > > That bit seems platform specific but in generic code ?
> 
> > If the regulator frame work is not configured, this code does nothing.
> > I have understood (hopefully correctly) that if the frame work is in use
> > drivers could support that directly assuming that regulators are
> > configured for that platform. If that is not the case, this should be
> > platform specific.
> 
> Your understanding is correct - the regulator API provides separation
> between the driver and the platform so that the driver code can work
> with any platform.  The driver requests supplies in terms of the
> physical supplies the chip has (using the struct device and the supply
> names from the datasheet).  The regulator API them matches this with
> actual regulators on a given system using data provied separately by the
> code specific to that machine so that the regulator and the consumer
> using it don't need to know about each other.
> 
> If the regulator API is disabled then the basic regulator API calls
> compile to inline stubs that report success, and there's a facility for
> optionally automatically stubbing out missing supplies when the API is
> enabled.

Mark, thanks for clarification. So is it ok to keep this in the driver
code.

I would like to get some advice about the following related to PM and
regulator control.

Small sensor with SYSFS only interface:
---------------------------------------
Driver doesn't know when someone opens (or keeps open) sysfs entry.
It only knows when someone reads or writes to it. Sensors may have quite
long wakeup time from total power off (regulators off) so it takes quite
long time to get first result. On the other hand, driver doesn't know
when it is ok to turn off the device.
At some level, this can be handled with a timer which is is kicked every
time when there is read / write operation. However, this is sounds
little bit a hack.

Would it make sense at all to enhange sysfs to have open / close
indication for PM related control? Of course this adds overhead to
every sysfs operation and most of the sysfs entries doesn't need
this kind of feature.

One solution is to have separate disable / enable control entry
for the sensor. This needs addional operations from the applications
and is little bit tricky in case of several users - should it be
on / off type or counting type control.

Misc-char-device + sysfs interface:
-----------------------------------
PM related issues can be nicely handled with char device.
It doesn't matter if there are one or several users. However
char device with binary data format is not that handy in scripts.
Same is true for input device. 


Do you have any suggestions what could be the best way to handle this?

-Samu

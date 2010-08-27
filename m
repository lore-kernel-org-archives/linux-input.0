From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] drivers: misc: ak8974 / ami305 magnetometer driver
Date: Fri, 27 Aug 2010 11:08:38 -0700
Message-ID: <20100827180837.GB13154@core.coreip.homeip.net>
References: <1282910083-8629-1-git-send-email-samu.p.onkalo@nokia.com>
 <1282910083-8629-2-git-send-email-samu.p.onkalo@nokia.com>
 <20100827133109.1eb974ed@lxorguk.ukuu.org.uk>
 <1282928353.2194.27.camel@noppispoppis.nmp.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1282928353.2194.27.camel-Vo7XL3ix0D0UEupzmRo7jhl4MBrZKKet0E9HWUfgJXw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Onkalo Samu <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: ext Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Aug 27, 2010 at 07:59:13PM +0300, Onkalo Samu wrote:
> > 
> > > +static ssize_t ak8974_misc_read(struct file *file, char __user *buf,
> > > +			size_t count, loff_t *offset)
> > > +{
> > > +	struct ak8974_chip *chip = container_of(file->private_data,
> > > +						struct ak8974_chip,
> > > +						miscdev);
> > > +	struct ak8974_data data;
> > 
> > So we have a different API to the ak8975 just posted and to the other
> > existing devices. This needs sorting out across the devices before there
> > is a complete disaster. Right now we have a mix of submissions pending
> > which variously use
> > 
> > 	misc + sysfs
> > 	sysfs
> > 	input (reporting X Y Z etc axes)
> > 
> 
> About year ago I send driver for the same chip with input-device
> interface. During that time I asked from Dmitry Torokhov that is that a
> correct interface for this kind of driver. I understood that input
> should not be used for this kind of sensors.
> 
> sysfs is quite handy interface for small sensors. However, one problem
> is that the driver doesn't know when the interface is in use.
> I ended up to misc device to get information about the usercount for PM
> purposes.
> 
> Dmitry, what is your opinion about using input device interface for this
> kind of sensors?
> 

This is really hard question and I am going back and forth myself.

When considering using input subsystem try answering the following
question - is the device's main purpose is indeed to be a human
interface device or do you want to use input subystem because evdev
interface is convenient? If the answer is former- then it should be in
input (or available through input - let's say IIO-to-input bridge
module). If the answer is latter then input is not the right place for
the device.

Lately I was persuaded that 3-axis accelerometers are mainly used as
input devices so I took adxl driver in and I need to get back and review
cma3000 patch...

> > Someone needs to decide on a single API before it's too late.
> > 
> 
> That is definitely true. Could it be IIO?
> 

I was hpoing that IIO would take care of "unnamed" sensors. Here I mean
sensors that measure something and only user/application know exactly
what it is; the same device might measure different things depending on
setup. Take a temperature sensor - ambient temperature, temperature of
some technological process, patient temperature - it is hard for the
kernel to know which one it would be.

This is in contrast with input system that tries to classify
events so that the event has the same meaning regarless of which device
emitted it - KEY_A means the same regardless of keybord; we may route
them differently (multiseat for example), but the meaning is the same.

-- 
Dmitry

From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH 1/4] hmc6352: Add driver for the HMC6352 compass
Date: Wed, 14 Apr 2010 15:32:34 +0100
Message-ID: <20100414153234.22765666@lxorguk.ukuu.org.uk>
References: <20100414124913.23181.75903.stgit@localhost.localdomain>
	<20100414125136.23181.16788.stgit@localhost.localdomain>
	<4BC5C7A8.1040807@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BC5C7A8.1040807-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

> This is in no way a hwmon chip.  Surely misc is a better location for now
> (pending the usual discussion about all singing all dancing sensors frameworks).

Yep it's moving at the moment


> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/slab.h>
> > +#include <linux/i2c.h>
> > +#include <linux/hwmon.h>
> 
> Why these extra hwmon includes?  At least at first glance I can't see
> any uses of them.  The only call to hwmon is to stick this in the
> hwmon class.

I inherited it for cleanup so these are good points (I've been staring at
piles of these for so long extra input is very useful - this is the tip
of the iceberg !)

> > +#include <linux/hwmon-sysfs.h>
> > +#include <linux/hwmon-vid.h>
> > +#include <linux/err.h>
> > +#include <linux/delay.h>
> or any mutex usage?
> > +#include <linux/mutex.h>
> > +#include <linux/sysfs.h>
> > +
> 
> I guess this makes the driver look like many others, but why bother with
> the wrapping structure?  This is only used to keep track of the hwmon
> device to be able to remove it later.

Should go - agreed will remove

> These address changes looking a little unusual to me.  They may well be needed, but
> if so can we have an explanatory comment?

Will investigate.

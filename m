From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the
 GPIO when using ACPI pm
Date: Thu, 2 Feb 2017 15:44:39 +0200
Message-ID: <20170202134439.GS2053@lahna.fi.intel.com>
References: <20170122222015.GA31009@dtor-ws>
 <8a23b7b2-a7aa-d62d-947d-31301a0c92cc@redhat.com>
 <20170201174257.GE40045@dtor-ws>
 <20170202104130.GJ2053@lahna.fi.intel.com>
 <8e91084e-e0ea-b055-5c62-67a4e0e56df4@redhat.com>
 <20170202121018.GN2053@lahna.fi.intel.com>
 <20170202123206.GP2053@lahna.fi.intel.com>
 <d4a9ad28-d6a8-5714-ddae-510c1f61f3c6@redhat.com>
 <20170202131251.GQ2053@lahna.fi.intel.com>
 <cf8dab24-7aeb-07f1-2018-a96cc3dfc37e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54008 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbdBBNtF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 2 Feb 2017 08:49:05 -0500
Content-Disposition: inline
In-Reply-To: <cf8dab24-7aeb-07f1-2018-a96cc3dfc37e@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Thu, Feb 02, 2017 at 02:27:28PM +0100, Hans de Goede wrote:
> > Actually what is wrong here is that your gpiod_get(dev, "power") falls
> > back to use plain indexes and returns the first GPIO even though it
> > should not as the driver specifically requests GPIO with name "power"
> > and there is no _DSD.
> 
> There is no clear "binding" for this device in ACPI, so the fallback
> is actually used as a feature by the Silead driver (more or less),
> the use of "power" as name here is for the ARM + devicetree usage
> of the driver really, so IOW the series:
> 
> > 
> > Andy (Cc'd) has a patch that tries to make the fallback mechanism more
> > stricter which should in theory fix the problem as well. The patch
> > series is here:
> > 
> > https://bitbucket.org/andy-shev/linux/commits/338c0226b631b8b497d143070a301d8b8883c349?at=master
> 
> You are referring to might fix this, but then we may need to add an
> attempt to get the gpio by index for some boards which do not control
> it themselves from _PS#.
> 
> I can give the linked series a try, but I would still like a fallback
> plan if we indeed encounter boards where we need to fallback to
> getting the gpio by index. Once we do that we're back to having the
> same problem as then we would do the same fallback on boards where
> the pin is reserved for _PS# usage, and end up with an -EBUSY error
> again. I guess we could ignore -EBUSY in the fallback path, or only
> do the fallback if acpi_bus_power_manageable() returns false.

I don't think using acpi_bus_power_manageable() is a proper way to fix
this.

This can be fixed without the fallback so that for the boards you know
need to handle the GPIO themselves (based on the _HID for example), they
will call acpi_dev_add_driver_gpios() passing the mapping for "power".
The other boards then just don't get the GPIO.

We really want to get rid of the whole fallback mess.

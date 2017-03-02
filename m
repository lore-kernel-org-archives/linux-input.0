From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the
 GPIO when using ACPI pm
Date: Thu, 02 Mar 2017 13:38:47 +0200
Message-ID: <1488454727.20145.71.camel@linux.intel.com>
References: <20170122200008.27027-1-hdegoede@redhat.com>
         <20170122222015.GA31009@dtor-ws>
         <8a23b7b2-a7aa-d62d-947d-31301a0c92cc@redhat.com>
         <20170201174257.GE40045@dtor-ws> <20170202104130.GJ2053@lahna.fi.intel.com>
         <8e91084e-e0ea-b055-5c62-67a4e0e56df4@redhat.com>
         <20170202121018.GN2053@lahna.fi.intel.com>
         <20170202123206.GP2053@lahna.fi.intel.com>
         <d4a9ad28-d6a8-5714-ddae-510c1f61f3c6@redhat.com>
         <20170202131251.GQ2053@lahna.fi.intel.com>
         <ca2868cf-8c7f-5cdc-e773-ff326dd0cdc6@redhat.com>
         <3f433773-27ba-8d07-3209-6df71d6d4b33@redhat.com>
         <1487778778.20145.22.camel@linux.intel.com>
         <65b7a7ed-3199-84d2-c004-adedadce1d88@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:26322 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752515AbdCBM3R (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 2 Mar 2017 07:29:17 -0500
In-Reply-To: <65b7a7ed-3199-84d2-c004-adedadce1d88@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On Thu, 2017-02-23 at 15:19 +0100, Hans de Goede wrote:
> On 22-02-17 16:52, Andy Shevchenko wrote:
> > On Sun, 2017-02-12 at 11:40 +0100, Hans de Goede wrote:
> > > On 10-02-17 12:52, Hans de Goede wrote:
> > > > On 02-02-17 14:12, Mika Westerberg wrote:
> > > > > On Thu, Feb 02, 2017 at 01:50:58PM +0100, Hans de Goede wrote:
> > > > > > On 02-02-17 13:32, Mika Westerberg wrote:
> > > > > > > On Thu, Feb 02, 2017 at 02:10:18PM +0200, Mika Westerberg
> > > > > > > wrote:

> > > > Ok, that patches fixes the issues I was seeing with the silead
> > > > driver
> > > > on my cube iwork8 air cherrytrail tablet.
> > > 
> > > But unfortunately it causes regressions for drivers which actually
> > > use
> > > gpiod_get_by_index, e.g. drivers/extcon/extcon-intel-int3496.c,
> > > which
> > > does:
> > > 
> > >          data->gpio_usb_id = devm_gpiod_get_index(dev, "id",
> > >                                                  INT3496_GPIO_USB_
> > > ID,
> > >                                                  GPIOD_IN);
> > > 
> > > Where GPIOD_IN is 0, (it also gets gpios for index 1 and 2), I
> > > guess
> > > this driver can be fixed by replacing "id" with NULL, but the name
> > > gets used in things like /sys/kernel/debug/gpio and is actually
> > > useful there, so it looks like that patch from Andy needs some
> > > work so as to not see getting by index as an undesirable fallback
> > > while the driver is actually doing a request gpio by index.
> > 
> > Hans, I have just pushed most recent stuff into my branch. Would you
> > have a chance test it? It has extcon patches embedded.
> 
> First of all thank you for working on this.
> 
> Before I spend time on testing this I must say that I've the feeling
> these patches are going in the wrong direction.
> 
> I would expect you to modify gpiod_get_index to internally inside
> the gpiolib code pass a flag which makes it clear that the name is
> just a hint and that it should fallback to the index (*), as it is
> doing before your patches to clean things up. That way we avoid
> needing to fixup the drivers and add with IMHO is unnecessary
> boilerplate to them, in both the extcon-intel-int3496.c and
> soc_button_array.c cases we really just want to get a gpio by
> index and the name is just there to make debugging easier.

Unfortunately the flag solution was discussed as a *temporary* one to
makes someone's eye hurt when see the flag. Real solution is exactly
what I'm doing right now.

(Side note: when I started implementing flag option, I realized that it
even uglier than I thought, that's why I decide to go for fixing users
first)

The problem is that previously ACPI has no mean of mapping between
indexes and names, and connection ID has being abused for ACPI case.

Basically it means you can put *anything* as connection ID right now.
And this is bad, very bad idea!

Now, since we have _DSD and specification for mapping GPIO resources to
names (connection IDs!) we should *not* allow drivers to put anything
they want there.

It means that any driver that is supposed to be used on ACPI-based
platfroms with *or* without _DSD should provide a mapping table for the
latter case.

Other solution is to extend GPIO API to have almost all same set of
calls with an additional field "label" as it was recently done for
fwnode_get_gpiod_child() (whatever its name nowadays). I don't think
this is best (though allows less intrusion to the existing drivers) way
because (see above) an heavy abuse in the kernel of connection ID
meaning for ACPI-enabled platforms.

> Also if you look at the ACPI 6.0 or later spec. then there is
> a new "generic button device" defined there and I've patches to
> soc_button_array.c pending to add support for that:
> 
> https://github.com/jwrdegoede/linux-sunxi/commit/4fad488f818a9e45bd27e
> 6030dfcaddb555d0e2d
> https://github.com/jwrdegoede/linux-
> sunxi/commit/ae8a643e9060979e43950ae3ad09623c6b7fcaa5

Side note.
The one patch is okay, the main one needs a comprehensive review (at
least two points just came to my mind: a) it should be done in generic
ACPICA / Linux ACPI glue code, b) it should use UUID library in kernel).

> The ACPI spec clearly defines the _DSD (device specific data)
> for these devices with a ACPI0011 _HID as containing an index
> into the ACPI resources table for the device, since your patches
> make it impossible to directly get a gpio by index (if one still
> want the gpio to have a sensible name) that means I now need
> to create an acpi_gpio_mapping table on the fly for this.

Since the GPIO API doesn't provide an additional "label" field when you
get it. Otherwise the problem that you never know what you get by index.

Regarding to how to create this, I think, as I already said above, it
would be internal stuff to Linux ACPI glue layer and perhaps GPIO ACPI
library.

> TL;DR: this approach seems like a lot of extra work / churn and
> boilerplate code in drivers for no gain.

Yes, because of current *abuse* of connection ID field in ACPI case.

> Can't we please just simply keep the fallback as-is when a driver
> calls gpiod_get_index rather then gpiod_get ? That seems like a
> lot simpler and cleaner solution to me.

No. We can't.

This is explained by documentation addon in:

https://bitbucket.org/andy-shev/linux/commits/27f4d31dcf7997613dfb0db1df
4182673826646c

(with flag removed approach)
https://bitbucket.org/andy-shev/linux/commits/ab99ade0bab99983f63bf17093
dacccd30e349cc

and in commit message

https://bitbucket.org/andy-shev/linux/commits/3a50bf0c17df18df6758a3a139
0075613daee56f

> *) Or maybe even a flag that it is the index which should be looked at
> and not the name, but that may break some existing users

Mika, Linus, I would really appreciate your input to the topic:
opinions, critique, ideas, etc.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

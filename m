From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 04/12] input: matrix-keypad: push/pull, separate
 polarity
Date: Sun, 30 Jun 2013 13:43:24 +0200
Message-ID: <20130630114324.GA24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-5-git-send-email-gsi@denx.de>
 <51C4C6C9.6030000@wwwdotorg.org>
 <20130622093649.GF24305@book.gsilab.sittig.org>
 <51C8D2BC.9010507@wwwdotorg.org>
 <20130628083354.GW24305@book.gsilab.sittig.org>
 <51CDA539.1020405@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:36360 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab3F3Ln2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Jun 2013 07:43:28 -0400
Content-Disposition: inline
In-Reply-To: <51CDA539.1020405@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On Fri, Jun 28, 2013 at 09:01 -0600, Stephen Warren wrote:
> 
> On 06/28/2013 02:33 AM, Gerhard Sittig wrote:
> > On Mon, Jun 24, 2013 at 17:14 -0600, Stephen Warren wrote:
> >>
> >> [ active low pins, individually for sets or even single pins ]
> >>
> >> Can't you add this enhancement as follows:
> >>
> >> Update the driver to look at the per-pin GPIO flags in all cases.
> >> Presumably in any existing cases, those flags all say "active high"
> >> anyway, since specifying anything else was useless. In the very unlikely
> >> case this isn't true, one could always add a quirk based on the
> >> HW-specific compatible value.
> > 
> > Maybe I missed something, but
> > - is "the 'active low' property of a GPIO pin" something platform
> >   specific? (maybe ARM inspired, introduced with pinctrl features)
> > - is it only available for specific GPIO controller drivers
> >   ("chips" or "banks"), or is it in some layer on top of gpiolib?
> 
> The way this property is represented is technically defined by each
> individual GPIO controller's DT binding. However, at least on ARM (and
> in fact I'd guess everywhere), many/most controllers do this in the same
> way; by adding an additional cell to #gpio-cells, which holds flags
> data, with values in that cell containing:
> 
> include/linux/of_gpio.h:
> 
> > /*
> >  * This is Linux-specific flags. By default controllers' and Linux' mapping
> >  * match, but GPIO controllers are free to translate their own flags to
> >  * Linux-specific in their .xlate callback. Though, 1:1 mapping is recommended.
> >  */
> > enum of_gpio_flags {
> >         OF_GPIO_ACTIVE_LOW = 0x1,
> > };
> 
> include/dt-bindings/gpio/gpio.h:
> 
> > #define GPIO_ACTIVE_HIGH 0
> > #define GPIO_ACTIVE_LOW 1
> 
> I'm not sure how new this is; it's possible older bindings don't have
> this extra cell. A quick grep of arch/*/boot/dts shows that almost all
> values of #gpio-cells are 2, so likely this is almost everywhere though.

Ah, so it's not a feature of gpiolib in itself, but in parallel
to gpiolib.

In addition to the "chip and pin" spec in device tree bindings,
one may specify additional flags, of which currently only
'active-low' exists.  Thank you for the pointer.  Yes I've seen
"phandle plus two cell" specs everywhere, but haven't seen any
non-zero value so far in the second cell.

> > - is it in some other tree or branch than mainline?
> 
> It's been in mainline for quite a while now; a good number of kernel
> releases.
> 
> > Documentation/gpio.txt suggests and eyeballing the gpiolib.c
> > source supports (v3.10-rc7) that the in-kernel API doesn't have
> > an 'active-low' for pins.  There is one for the sysfs API and
> > pins that were exported to user space, but not for in-kernel use.
> > 
> > This fits with my observation that application drivers on top of
> > gpiolib often take care of such a property which actually looks
> > like it would belong to the physical attachment.
> > 
> > I understand that a chip's driver will hide when a SoC's pin is
> > inverted, but I cannot see where gpiolib provides a means to hide
> > an externally connected inverting driver.
> 
> With the current gpiolib APIs, gpiolib only provides a way for GPIO
> clients to retrieve the GPIO flags from DT. It's then up to the GPIO
> client to actually make use of the flag, by inverting the value passed
> to gpio_set(), or returned from gpio_get().
> 
> Flags are retrieved by calling of_get_named_gpio_flags() rather than
> of_get_named_gpio().

Ah, so optionally inverting the level between the logical request
in software and controlling the physical pin remains the job of
the application driver (here: the input driver that manages the
matrix which just happens to be attached to GPIOs), since it's
not transparently done within gpiolib or the gpio chip driver.

But what the matrix driver shall do is not apply one 'invert
everything' flag, but instead apply a flag that's specific to an
individual GPIO pin.  And this pin specific flag either gets
setup from device tree information (from the flags cell of the
GPIO spec), or gets derived from the platform data's 'invert
everything' flag that applies to the non-DT case.  And thus the
individual polarity of rows and columns is a mere "byproduct" of
respecting the individual pins' polarity.  Nice. :)

Thank you, this pointer is much appreciated.


> There is a new GPIO API under development which I /think/ will hide this
> flag inside the GPIO core, so that GPIO clients don't have to care about
> it, and it all works automatically. I'm not sure what the status of this
> is though. Search Google for "gpio_get()".

Oh, I understand that this involves a huge sweep over both layers
of GPIO chip drivers as well as GPIO API using drivers.  And is
completely orthogonal to whether and when more drivers are tought
to respect the pin's active-low property.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de

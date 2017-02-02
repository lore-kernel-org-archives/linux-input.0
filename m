From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the
 GPIO when using ACPI pm
Date: Thu, 2 Feb 2017 12:41:30 +0200
Message-ID: <20170202104130.GJ2053@lahna.fi.intel.com>
References: <20170122200008.27027-1-hdegoede@redhat.com>
 <20170122222015.GA31009@dtor-ws>
 <8a23b7b2-a7aa-d62d-947d-31301a0c92cc@redhat.com>
 <20170201174257.GE40045@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62914 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbdBBKuS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 2 Feb 2017 05:50:18 -0500
Content-Disposition: inline
In-Reply-To: <20170201174257.GE40045@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On Wed, Feb 01, 2017 at 09:42:57AM -0800, Dmitry Torokhov wrote:
> On Mon, Jan 23, 2017 at 11:05:14AM +0100, Hans de Goede wrote:
> > Hi,
> > 
> > On 22-01-17 23:20, Dmitry Torokhov wrote:
> > >On Sun, Jan 22, 2017 at 09:00:08PM +0100, Hans de Goede wrote:
> > >>On some x86 tablets we cannot directly access the GPIOs as they are
> > >>claimed by the ACPI tables, so check it the i2c client is not being
> > >>power-managed by ACPI before trying to get the power pin GPIO.
> > >
> > >Why do we even get this GPIO if driver is not supposed to be using it?
> > >I'd much rather gpio provider hid it from the driver instead of every
> > >driver having this check.
> > 
> > The problem is that the gpio subsys does not really know about ACPI
> > managed GPIOs the way this works is that the firmware sets a special
> > "reserved for firmware use" bit in the gpio control register and
> > directly bit-bangs the gpio control register when it wants to toggle
> > the gpio. So there is no awareness of these gpios being reserved
> > (as gpios) at the ACPI level AFAICT.
> > 
> > The hardware specific low-level gpio chip driver checks this bit
> > when we request the gpio and returns -EBUSY.
> 
> I'd say that, if GPIOs are reserved for firmware use, and kernel should
> not or can not touch them, then they should not be visible, if not to
> the gpio core, then to consumers for sure.
> 
> Let's add Mika and Linus.

It is not always possible for the GPIO driver to find out if a certain
GPIO is reserved for the firmware use or not. I don't think we have any
API in gpiolib that allows excluding certain GPIOs though.

What we do for example with the ACPI OpRegion GPIOs is that gpiolib
reserves those automatically thus preventing any consumer from using
those.

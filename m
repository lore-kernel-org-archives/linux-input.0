From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Add support for GPIO interrupts
Date: Mon, 26 Jan 2015 16:47:29 +0200
Message-ID: <20150126144729.GG1451@lahna.fi.intel.com>
References: <1422282573-18215-1-git-send-email-mika.westerberg@linux.intel.com>
 <1422282573-18215-2-git-send-email-mika.westerberg@linux.intel.com>
 <20150126143723.GI23313@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:45403 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244AbbAZOre (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jan 2015 09:47:34 -0500
Content-Disposition: inline
In-Reply-To: <20150126143723.GI23313@leverpostej>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jan 26, 2015 at 02:37:24PM +0000, Mark Rutland wrote:
> On Mon, Jan 26, 2015 at 02:29:33PM +0000, Mika Westerberg wrote:
> > The HID over I2C specification allows to have the interrupt for a HID
> > device to be GPIO instead of directly connected to the IO-APIC.
> > 
> > Add support for this so that when the driver does not find proper interrupt
> > number from the I2C client structure we check if the device has property
> > named "gpios". This is then assumed to be the GPIO that serves as an
> > interrupt for the device.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  .../devicetree/bindings/hid/hid-over-i2c.txt       |  5 +-
> >  drivers/hid/i2c-hid/i2c-hid.c                      | 70 ++++++++++++++++------
> >  2 files changed, 56 insertions(+), 19 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/hid/hid-over-i2c.txt b/Documentation/devicetree/bindings/hid/hid-over-i2c.txt
> > index 488edcb264c4..8f4a99dad3b9 100644
> > --- a/Documentation/devicetree/bindings/hid/hid-over-i2c.txt
> > +++ b/Documentation/devicetree/bindings/hid/hid-over-i2c.txt
> > @@ -15,7 +15,10 @@ Required properties:
> >  - reg: i2c slave address
> >  - hid-descr-addr: HID descriptor address
> >  - interrupt-parent: the phandle for the interrupt controller
> > -- interrupts: interrupt line
> > +- interrupts: interrupt line if the device uses IO-APIC interrupts
> > +
> > +Optional properties:
> > +- gpios: GPIO used as an interrupt if the device uses GPIO interrupts
> 
> Elsewhere we've said that for a GPIO acting as an interrupt line, GPIO
> controller should be marked as an interrupt-controller, and the GPIO
> described as an interrupt line. That also gets you the appropriate
> configuration for the GPIO as an interrupt.
> 
> Does this GPIO serve any other purpose than an ersatz interrupt line?

It is just an interrupt.

> If not, it should probably be described as an interrupt. From the PoV of
> this device, it's just an interrupt controller hooked up to the
> interrupt pin.

What I'm trying to do is to get a GPIO that is described in ACPI (as
GpioInt() in _CRS) to be supported in this driver using gpiolib like
this:

	desc = gpiod_get(&client->dev, NULL);

This calls to find "gpios" property which ends up finding the GpioInt()
in _CRS.

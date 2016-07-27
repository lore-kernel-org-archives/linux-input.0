From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6] input: touchscreen: Add generic driver for Silead
 touchscreens
Date: Wed, 27 Jul 2016 14:35:55 -0700
Message-ID: <20160727213555.GC24351@dtor-ws>
References: <1468252304-22850-1-git-send-email-hdegoede@redhat.com>
 <20160716175605.GA4873@rob-hp-laptop>
 <20160719184425.GC19250@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33150 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbcG0Vf7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jul 2016 17:35:59 -0400
Content-Disposition: inline
In-Reply-To: <20160719184425.GC19250@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Wessel Blokzijl <wesselb94@gmail.com>, Siebren Vroegindeweij <siebren.vroegindeweij@gmail.com>, Robert Dolca <robert.dolca@intel.com>, Daniel Jansen <djaniboe@gmail.com>

On Tue, Jul 19, 2016 at 11:44:25AM -0700, Dmitry Torokhov wrote:
> On Sat, Jul 16, 2016 at 12:56:05PM -0500, Rob Herring wrote:
> > On Mon, Jul 11, 2016 at 05:51:44PM +0200, Hans de Goede wrote:
> > > From: Robert Dolca <robert.dolca@intel.com>
> > > 
> > > This driver adds support for Silead touchscreens. It has been tested
> > > with GSL1680 and GSL3680 touch panels.
> > > 
> > > It supports ACPI and device tree enumeration. Screen resolution,
> > > the maximum number of fingers supported and firmware name are
> > > configurable.
> > > 
> > > Signed-off-by: Robert Dolca <robert.dolca@intel.com>
> > > Signed-off-by: Daniel Jansen <djaniboe@gmail.com>
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > > Changes in v6:
> > > -Default to 5 fingers if max-fingers is not specified
> > > -Improve devicetree binding doc: improve wake-gpios description, use
> > >  "See touchscreen.txt" where applicable
> > > ---
> > >  .../bindings/input/touchscreen/silead_gsl1680.txt  |  36 ++
> > >  drivers/input/touchscreen/Kconfig                  |  13 +
> > >  drivers/input/touchscreen/Makefile                 |   1 +
> > >  drivers/input/touchscreen/silead.c                 | 652 +++++++++++++++++++++
> > >  4 files changed, 702 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> > >  create mode 100644 drivers/input/touchscreen/silead.c
> > > 
> > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> > > new file mode 100644
> > > index 0000000..1e58d37
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> > > @@ -0,0 +1,36 @@
> > > +* GSL 1680 touchscreen controller
> > > +
> > > +Required properties:
> > > +- compatible		  : "silead,gsl1680"
> > > +- reg			  : I2C slave address of the chip (0x40)
> > > +- interrupt-parent	  : a phandle pointing to the interrupt controller
> > > +			    serving the interrupt for this chip
> > > +- interrupts		  : interrupt specification for the gsl1680 interrupt
> > > +- power-gpios		  : Specification for the pin connected to the gsl1680's
> > > +			    shutdown input. This needs to be driven high to take the
> > > +			    gsl1680 out of its low power state
> > > +- touchscreen-size-x	  : See touchscreen.txt
> > > +- touchscreen-size-y	  : See touchscreen.txt
> > > +- touchscreen-max-fingers : maximum number of fingers the touchscreen can detect
> > 
> > If you name it like a standard property, then it should be documented in 
> > touchscreen.txt.
> 
> Actually this is very much Silead-specific wart, I'd rather we called it
> "max-fingers" or "silead,max-fingers" to illustrate that it is not at
> all a generic property.
> 
> Rob, will you be OK with it?

Rob, ping? I'd like to get it into the tree and this is only outstanding
question.

Thanks!

-- 
Dmitry

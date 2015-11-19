From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v10 2/8] Input: goodix - reset device at init
Date: Thu, 19 Nov 2015 11:55:27 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F11F439@irsmsx105.ger.corp.intel.com>
References: <1447864301-1261-1-git-send-email-irina.tirdea@intel.com>
 <1447864301-1261-3-git-send-email-irina.tirdea@intel.com>
 <20151118212422.GA31164@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60316 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754269AbbKSL4J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 06:56:09 -0500
In-Reply-To: <20151118212422.GA31164@rob-hp-laptop>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>



> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: 18 November, 2015 23:24
> To: Tirdea, Irina
> Cc: Dmitry Torokhov; Bastien Nocera; Aleksei Mamlin; Karsten Merker; linux-input@vger.kernel.org; Mark Rutland; Purdila, Octavian;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v10 2/8] Input: goodix - reset device at init
> 
> On Wed, Nov 18, 2015 at 06:31:35PM +0200, Irina Tirdea wrote:
> > After power on, it is recommended that the driver resets the device.
> > The reset procedure timing is described in the datasheet and is used
> > at device init (before writing device configuration) and
> > for power management. It is a sequence of setting the interrupt
> > and reset pins high/low at specific timing intervals. This procedure
> > also includes setting the slave address to the one specified in the
> > ACPI/device tree.
> >
> > This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
> > driver gt9xx.c for Android (publicly available in Android kernel
> > trees for various devices).
> >
> > For reset the driver needs to control the interrupt and
> > reset gpio pins (configured through ACPI/device tree). For devices
> > that do not have the gpio pins properly declared, the functionality
> > depending on these pins will not be available, but the device can still
> > be used with basic functionality.
> >
> > For both device tree and ACPI, the interrupt gpio pin configuration is
> > read from the "irq-gpio" property and the reset pin configuration is
> > read from the "reset-gpio" property. For ACPI 5.1, named properties
> > can be specified using the _DSD section. This functionality will not be
> > available for devices that use indexed gpio pins declared in the _CRS
> > section (we need to provide backward compatibility with devices
> > that do not support using the interrupt gpio pin as output).
> >
> > For ACPI, the pins can be specified using ACPI 5.1:
> > Device (STAC)
> > {
> >     Name (_HID, "GDIX1001")
> >     ...
> >
> >     Method (_CRS, 0, Serialized)
> >     {
> >         Name (RBUF, ResourceTemplate ()
> >         {
> >             I2cSerialBus (0x0014, ControllerInitiated, 0x00061A80,
> >                 AddressingMode7Bit, "\\I2C0",
> >                 0x00, ResourceConsumer, ,
> >                 )
> >
> >             GpioInt (Edge, ActiveHigh, Exclusive, PullNone, 0x0000,
> >                 "\\I2C0", 0x00, ResourceConsumer, ,
> >                  )
> >                  {   // Pin list
> >                      0
> >                  }
> >
> >             GpioIo (Exclusive, PullDown, 0x0000, 0x0000,
> >                 IoRestrictionOutputOnly, "\\I2C0", 0x00,
> >                 ResourceConsumer, ,
> >                 )
> >                 {
> >                      1
> >                 }
> >         })
> >         Return (RBUF)
> >     }
> >
> >     Name (_DSD,  Package ()
> >     {
> >         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >         Package ()
> >         {
> >             Package (2) {"irq-gpio", Package() {^STAC, 0, 0, 0 }},
> >             Package (2) {"reset-gpio", Package() {^STAC, 1, 0, 0 }},
> >             ...
> >         }
> >     }
> >
> > Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > ---
> >  .../bindings/input/touchscreen/goodix.txt          |   5 +
> >  drivers/input/touchscreen/Kconfig                  |   1 +
> >  drivers/input/touchscreen/goodix.c                 | 101 +++++++++++++++++++++
> >  3 files changed, 107 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > index 8ba98ee..7137881 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > @@ -12,6 +12,8 @@ Required properties:
> >   - reg			: I2C address of the chip. Should be 0x5d or 0x14
> >   - interrupt-parent	: Interrupt controller to which the chip is connected
> >   - interrupts		: Interrupt to which the chip is connected
> > + - irq-gpio		: GPIO pin used for IRQ
> 
> Please note here why you need this in addition to just "interrupts".

Ok.

> Also, it should be irq-gpios instead.
> 
> > + - reset-gpio		: GPIO pin used for reset
> 
> Should be reset-gpios instead.
> 

I'll fix this, I wasn't aware that irq/reset-gpio is deprecated.

Thanks,
Irina

> Rob

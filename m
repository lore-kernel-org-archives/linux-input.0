From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v7 2/9] Input: goodix - reset device at init
Date: Thu, 08 Oct 2015 15:01:16 +0200
Message-ID: <5064355.NeXHGugtYj@wuerfel>
References: <1444299575-17417-1-git-send-email-irina.tirdea@intel.com> <8618206.7jshXjkP9U@wuerfel> <1F3AC3675D538145B1661F571FE1805F2F0F9A50@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F0F9A50-pww93C2UFcwu0RiL9chJVbfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Purdila, Octavian" <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thursday 08 October 2015 12:18:37 Tirdea, Irina wrote:
> > From: Arnd Bergmann [mailto:arnd-r2nGTMty4D4@public.gmane.org]
> > Sent: 08 October, 2015 13:54
> > To: Tirdea, Irina
> > Cc: Dmitry Torokhov; Bastien Nocera; Aleksei Mamlin; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mark Rutland; Purdila, Octavian; linux-
> > kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Subject: Re: [PATCH v7 2/9] Input: goodix - reset device at init
> > 
> > On Thursday 08 October 2015 13:19:28 Irina Tirdea wrote:
> > > After power on, it is recommended that the driver resets the device.
> > > The reset procedure timing is described in the datasheet and is used
> > > at device init (before writing device configuration) and
> > > for power management. It is a sequence of setting the interrupt
> > > and reset pins high/low at specific timing intervals. This procedure
> > > also includes setting the slave address to the one specified in the
> > > ACPI/device tree.
> > >
> > > This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
> > > driver gt9xx.c for Android (publicly available in Android kernel
> > > trees for various devices).
> > >
> > > For reset the driver needs to control the interrupt and
> > > reset gpio pins (configured through ACPI/device tree). For devices
> > > that do not have the gpio pins declared, the functionality depending
> > > on these pins will not be available, but the device can still be used
> > > with basic functionality.
> > >
> > > For both device tree and ACPI, the interrupt gpio pin configuration is
> > > read from the "irq-gpio" property and the reset pin configuration is
> > > read from the "reset-gpio" property. For ACPI 5.1, named properties
> > > can be specified using the _DSD section. If there is no _DSD section
> > > in the ACPI table, the driver will fall back to using indexed gpio
> > > pins declared in the _CRS section.
> > 
> > Would it help to use a plain "gpios" property here to always look
> > up the lines by index?
> > 
> 
> The problem with ACPI indexed gpios is that platforms declare the
> pins in random order. In this case we have some platforms that declare
> the interrupt pin first and others that declare the reset pin first.
> There is no way to differentiate between them so the only way to support
> these platforms is to pick a default and list all exceptions in the driver.
> My previous implementation did that with indexed gpios and dmi quirks. [1]
> 
> This can be solved by using named gpios, which are available starting with ACPI 5.1.
> In this way we know exactly which is the interrupt pin and which is the reset pin
> and we do not need to add any additional exceptions to the driver.
> However, we still need to support the platforms that are already out there so
> we fall back to indexed gpios.
> 
> [1] https://lkml.org/lkml/2015/9/15/609

Right.

> > > +/*
> > > + * Some platforms specify the gpio pins for interrupt and reset properly
> > > + * in ACPI, but cannot use the interrupt pin as output due to their specific
> > > + * HW configuration.
> > > + */
> > > +static const struct dmi_system_id goodix_no_gpio_pins_support[] = {
> > > +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
> > > +	{
> > > +		.ident = "Onda v975w",
> > > +		.matches = {
> > > +			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
> > > +			DMI_MATCH(DMI_PRODUCT_UUID,
> > > +				  "03000200-0400-0500-0006-000700080009"),
> > > +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> > > +			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
> > > +		}
> > > +	},
> > 
> > I think lists like this in drivers should be avoided if at all possible,
> > it just leads to other people adding their platform in the lists as
> > opposed to fixing their boot loaders.
> > 
> > Can you find another way to detect at runtime whether it works, and
> > print a warning if it doesn't?
> 
> I agree with you on this, but unfortunately I have not found a better way to do it.
> 
> The main problem comes from the interrupt pin. This device uses the interrupt pin
> as output, which some platforms do not support (either due to the HW configuration
> or due to flagging it wrong in BIOS) [2] [3]. There is no error returned, just a warning
> in dmesg.
> 
> [2] https://lkml.org/lkml/2015/9/28/851
> [3] https://lkml.org/lkml/2015/9/30/607

Would it be possible to combine those two and require future firmware to
use the named gpios if they want the proper reset, but fall back to not
doing it if they use an anonymous list of GPIOs?

> > > +	/* HIGH: 0x28/0x29, LOW: 0xBA/0xBB */
> > > +	error = gpiod_direction_output(ts->gpiod_int, ts->client->addr == 0x14);
> > > +	if (error)
> > > +		return error;
> > 
> > If the "interrupt" gpio is used as an output, maybe it has the wrong
> > name? Is that the name from the goodix datasheet (that would be ok)
> > or something you picked?
> > 
> 
> This is from the goodix datasheet [4]. The pin that is used for receiving interrupts
> is also used as output (for reset and suspend procedures).
> 
> [4] https://drive.google.com/folderview?id=0BxCVOQS3ZymGfmJyY2RKbE5XbVlKNlktVTlwV0lxNEdxd2dzeWZER094cmJPVnMxN1F0Yzg&usp=sharing
> 

Ok.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

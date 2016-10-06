From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH V1 01/10] mfd: da9061: MFD core support
Date: Thu, 6 Oct 2016 16:34:04 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCE244D@SW-EX-MBX02.diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <c9726b1f01300da7693324b0c1ff7f71dcbc275d.1475743411.git.stwiss.opensource@diasemi.com>
 <1eca0af9-64d5-7476-2847-71ecf9331395@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1eca0af9-64d5-7476-2847-71ecf9331395-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 06 October 2016 11:38, Keerthy [mailto:a0393675-l0cyMroinI0@public.gmane.org], wrote:

> > regmap_config which lists the correct readble, writable and volatile
> 
> /s/readble/readable

Done

[...]

> >  static struct resource da9062_core_resources[] = {
> >  	DEFINE_RES_NAMED(DA9062_IRQ_VDD_WARN, 1, "VDD_WARN",
> IORESOURCE_IRQ),
> >  };
> > @@ -142,7 +257,7 @@ static const struct mfd_cell da9062_devs[] = {
> >  		.name		= "da9062-watchdog",
> >  		.num_resources	=
> ARRAY_SIZE(da9062_wdt_resources),
> >  		.resources	= da9062_wdt_resources,
> > -		.of_compatible  = "dlg,da9062-wdt",
> > +		.of_compatible  = "dlg,da9062-watchdog",
> 
> Any particular reason why this compatible needs to be changed?

Yes. It was incorrect in the original DA9062 submission.
The binding said "dlg,da9062-watchdog", but the MFD component implemented it
incorrectly as "dlg,da9062-wdt" in the da9062.txt binding file. This fixes that error. 

The watchdog driver did not use the compatible during probe for da9062. But, it now
checks the compatible string as part of  this patch set.

[...]

> > +static const struct of_device_id da9062_dt_ids[] = {
> > +	{ .compatible = "dlg,da9062", .data = (void *)COMPAT_TYPE_DA9062,
> },
> > +	{ .compatible = "dlg,da9061", .data = (void *)COMPAT_TYPE_DA9061,
> },
> 
> WARNING: DT compatible string "dlg,da9061" appears un-documented --
> check ./Documentation/devicetree/bindings/
> #622: FILE: drivers/mfd/da9062-core.c:822:
> +	{ .compatible = "dlg,da9061", .data = (void *)COMPAT_TYPE_DA9061,
> },
> 
> Might want to re-order patches so that you have the compatibles
> documented before usage

Ah. I ordered them last because I thought the driver would need approval before
the device tree docs were accepted. On second look, that doesn't make much sense.

I will change my scripts to complete the checkpatch.pl on the e-mails to be sent to LKML
(instead of the whole files) so this sort of thing doesn't happen again.

I will re-order the patches from V1 when doing V2.

> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, da9062_dt_ids);
> > +
> >  static int da9062_i2c_probe(struct i2c_client *i2c,
> >  	const struct i2c_device_id *id)
> >  {
> >  	struct da9062 *chip;
> > +	const struct of_device_id *match;
> >  	unsigned int irq_base;
> > +	const struct mfd_cell *cell;
> > +	const struct regmap_irq_chip *irq_chip;
> > +	const struct regmap_config *config;
> > +	int cell_num;
> 
> No need of cell_num.
[...]

> > +		cell_num = ARRAY_SIZE(da9061_devs);
> 
> No need of the above assignment
[...]

> > +		cell_num = ARRAY_SIZE(da9062_devs);
> 
> No need of the above assignment
> 
> > +	ret = mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE, cell,
> > +			      cell_num, NULL, irq_base,
> 
> Use ARRAY_SIZE(cell) instead if cell_num

Okay. Can do that.
It will appear in V2.

Regards,
Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

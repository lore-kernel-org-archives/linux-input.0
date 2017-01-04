From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V5 4/8] mfd: da9061: MFD core support
Date: Wed, 4 Jan 2017 12:18:30 +0000
Message-ID: <20170104121830.GB24225@dell>
References: <cover.1481828921.git.stwiss.opensource@diasemi.com>
 <ad649a91daa6191f2385dfe79c6ec8ca339f597c.1481828921.git.stwiss.opensource@diasemi.com>
 <20170104101221.GT27589@dell>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD3BBC9@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CD3BBC9@SW-EX-MBX02.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

On Wed, 04 Jan 2017, Steve Twiss wrote:

> Hi Lee,
> 
> On 04 January 2017 10:12, Lee Jones wrote:
> 
> > Subject: Re: [PATCH V5 4/8] mfd: da9061: MFD core support
> > On Thu, 15 Dec 2016, Steve Twiss wrote:
> > > From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> [...]
> 
> > > +static const struct of_device_id da9062_dt_ids[] = {
> > > +	{ .compatible = "dlg,da9061", .data = (void *)COMPAT_TYPE_DA9061,
> > },
> > > +	{ .compatible = "dlg,da9062", .data = (void *)COMPAT_TYPE_DA9062,
> > },
> > 
> > It looks like this device can dynamically obtain this information from
> > the device.  Please use that method instead.
> 
> As I mentioned in an earlier post,
> https://lkml.org/lkml/2016/11/7/418
> 
> The 61/62 device type has been defined by the device tree in this case, and
> that definition is used to set the register map. With the regmap defined,
> access to the registers is then possible.
> 
> It is not possible to detect the device type automatically in this case because
> it suggests a predefined regmap.
> 
> This is the reason I define the chip type (DA9061 or DA9062) in the device
> tree and then assign the correct regmap first before accessing any registers.

Well at least I'm consistent. :D

> > > +	if (i2c->dev.of_node) {
> > > +		match = of_match_node(da9062_dt_ids, i2c->dev.of_node);
> > > +		if (!match)
> > > +			return -EINVAL;
> > > +
> > > +		chip->chip_type = (int)match->data;
> > > +	} else
> > > +		chip->chip_type = id->driver_data;
> > 
> > Please obtain this information from DA9062AA_VARIANT_ID.
> 
> The variant ID does contain the information about whether it is a 61 or 62, but
> in order to read the register the regmap definition needs to be defined
> first.
> 
> [...]
> 
> > >  static const struct i2c_device_id da9062_i2c_id[] = {
> > > -	{ "da9062", 0 },
> > > +	{ "da9061", COMPAT_TYPE_DA9061 },
> > > +	{ "da9062", COMPAT_TYPE_DA9062 },
> > 
> > This too.
> 
> Regards,
> Steve

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

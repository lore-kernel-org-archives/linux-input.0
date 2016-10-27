From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V2 08/10] watchdog: da9062/61: watchdog driver
Date: Thu, 27 Oct 2016 13:10:24 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCE6655@SW-EX-MBX02.diasemi.com>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
 <ecd0c36a9e1766e327b54afa6bf986e64890b881.1477501000.git.stwiss.opensource@diasemi.com>
 <20161026185926.GA16142@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161026185926.GA16142@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LINUX-INPUT <linux-input@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-input@vger.kernel.org

On 26 October 2016 19:59 Guenter Roeck wrote:

> On Wed, Oct 26, 2016 at 05:56:39PM +0100, Steve Twiss wrote:
> > From: Steve Twiss <stwiss.opensource@diasemi.com>
> >
> > +static const struct of_device_id da9062_compatible_id_table[] = {
> > +	{ .compatible = "dlg,da9062-watchdog", .data = &da9062_watchdog_info },
> > +	{ },
> > +};
> > +
> >  static int da9062_wdt_probe(struct platform_device *pdev)
> >  {
> >  	int ret;
> >  	struct da9062 *chip;
> >  	struct da9062_watchdog *wdt;
> > +	const struct of_device_id *match;
> >
> >  	chip = dev_get_drvdata(pdev->dev.parent);
> >  	if (!chip)
> >  		return -EINVAL;
> >
> > +	match = of_match_node(da9062_compatible_id_table,
> > +			      pdev->dev.of_node);
> > +	if (!match)
> > +		return -ENXIO;
> > +
> >  	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> >  	if (!wdt)
> >  		return -ENOMEM;
> >
> >  	wdt->hw = chip;
> >
> > -	wdt->wdtdev.info = &da9062_watchdog_info;
> > +	wdt->wdtdev.info = (const struct watchdog_info *)match->data;
> 
> I don't see why you would need match->data or of_match_node above.

Hi Guenter,

True. I do not need to do any matching on the table any more if the assumption is
to use a fall-back compatible string for DA9061 devices (to use the da9062 device
driver).

I can erase most of that content. Including the .data = &da9062_watchdog_info.

Regards,
Steve

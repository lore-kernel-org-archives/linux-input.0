From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V1 05/10] thermal: da9062/61: Thermal junction
 temperature monitoring driver
Date: Thu, 20 Oct 2016 13:02:31 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCE4535@SW-EX-MBX02.diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <b5ce58ca00f7ab30a025d24083549241f135b0e9.1475743411.git.stwiss.opensource@diasemi.com>
 <3bc9fd76-2885-b07a-9df8-7802b7535da2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.141]:7676 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932543AbcJTNCp (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 20 Oct 2016 09:02:45 -0400
In-Reply-To: <3bc9fd76-2885-b07a-9df8-7802b7535da2@ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>

On  07 October 2016 06:29 Keerthy wrote:

> On Thursday 06 October 2016 02:13 PM, Steve Twiss wrote:
> > From: Steve Twiss <stwiss.opensource@diasemi.com>
> > 
> > +static int da9062_thermal_probe(struct platform_device *pdev)
> > +{
> > +	struct da9062 *chip = dev_get_drvdata(pdev->dev.parent);
> > +	struct da9062_thermal *thermal;
> > +	unsigned int pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
> > +	const struct of_device_id *match;
> > +	int ret = 0;
> > +
> > +	match = of_match_node(da9062_compatible_reg_id_table,
> > +			      pdev->dev.of_node);
> > +	if (!match)
> > +		return -ENXIO;
> > +
> > +	if (pdev->dev.of_node) {
> > +		if (!of_property_read_u32(pdev->dev.of_node,
> > +					"dlg,tjunc-temp-polling-period-ms",
> > +					&pp_tmp)) {
> > +			if (pp_tmp < DA9062_MIN_POLLING_MS_PERIOD ||
> > +				pp_tmp > DA9062_MAX_POLLING_MS_PERIOD)
> > +				pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
> > +		}
> > +
> > +		dev_dbg(&pdev->dev,
> > +			 "TJUNC temp polling period set at %d ms\n",
> > +			 pp_tmp);
> > +	}
> > +
> > +	thermal = devm_kzalloc(&pdev->dev, sizeof(struct da9062_thermal),
> > +			     GFP_KERNEL);
> > +	if (!thermal) {
> > +		ret = -ENOMEM;
> > +		goto err;
> > +	}
> > +
> > +	thermal->config = match->data;
> > +
> > +	INIT_DELAYED_WORK(&thermal->work, da9062_thermal_poll_on);
> > +	mutex_init(&thermal->lock);
> 
> thermal_zone_device_register itself does
> INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
> 
> refer: drivers/thermal/thermal_core.c
> 
> It does a periodic monitoring of the temperature as well. Do you really
> want to have an additional work for monitoring temperature in your
> driver also?

The thermal triggering mechanism is interrupt based and happens when the
temperature rises above a given threshold level. The component cannot
return an exact temperature, it only has knowledge if the temperature is
above or below a given threshold value. A status bit must be polled to
detect when the temperature falls below that threshold level again.

If I was to use the core's polling_delay it would request get_temp() every
x milliseconds. This would work: I could test the status bit to decide if
the temperature was above or below the threshold, and enable or disable the
interrupt accordingly. But during normal operation, when the temperature
is in the normal range, I would be polling through I2C every x milliseconds
instead of just waiting for an IRQ trigger event before starting my polling
operations to detect when the temperature level fell below the threshold.

Since an over-temperature is supposed to be a very rare event, I decided to
go with the IRQ based trigger and then kick-off a separate work-queue to
poll the status bit and detect when the temperature dropped below the
threshold level. This seemed a more efficient way of handling this.

I have looked through thermal core, and there doesn't seem to be an obvious
way of toggling on/off thermal core polling when I need to poll the
temperature through get_temp(). So, I was going to stick with this method for
PATCH V2.

Regards,
Steve


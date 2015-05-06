From: "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH V1 5/6] watchdog: da9062: DA9062 watchdog driver
Date: Wed, 6 May 2015 14:54:37 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B21924A@SW-EX-MBX02.diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <2afd9f55c71553186e99bfe386312f0c7d7501ed.1429280614.git.stwiss.opensource@diasemi.com>
 <55327DDA.4080003@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55327DDA.4080003-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 18 April 2015 16:53 Guenter Roeck wrote:

Hi Guenter,

Thanks for your comments.

> On 04/17/2015 07:23 AM, S Twiss wrote:
> > From: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> >
> > Add watchdog driver support for DA9062
> >
> > Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> >
> Hi Steve,
> 
> Key question here is if the da9062 is really so much different to the da9062
> that you can not use the same driver.

The DA9062 watchdog driver does have some similarities with the DA9063 watchdog 
base functionality -- however the watchdog component in the DA9062 chip has more
features yet to be added in software. I do intend to add these other features ...
however, if "not adding them here" is a problem I can drop the DA9062 watchdog
driver from this patch-set until I have time to write in the newer changes.

> I am especially concerned about the added da9062_reset_watchdog_timer(),
> given the delay it introduces.

After giving this some thought, I am going to remove this 300ms delay from the
reset_watchdog_timer() function for my next submission attempt.  However
I am adding a 300ms delay into the stop() and update_timeout_register() functions
instead.

The DA9062 watchdog ping (register CONTROL_F) is "windowed" for protection
against spurious writes -- i.e. the ping function cannot be called within a 250ms
time limit or the PMIC will reset. This windowing protection also extends to altering
the timeout scale in the CONTROL_D register -- in which case if the timeout
register is altered and the ping() function is called within the 250ms limit, the
PMIC will reset. The delay is there to stop that from happening.

I realised my previous patch was over-sanitised: by putting the time delay into the
ping() function I was protecting CONTROL_D in stop() and  update_timeout_register(),
but I was being too over-protective of the ping() function. Therefore if there was an 
"incorrect trigger signal", the watchdog would not be allowed to fail because the
driver would have filtered out the errors.

> > +static int da9062_reset_watchdog_timer(struct da9062 *hw)
> > +{
> > +	int ret;
> > +
> > +	ret = regmap_update_bits(hw->regmap,
> > +			   DA9062AA_CONTROL_F,
> > +			   DA9062AA_WATCHDOG_MASK,
> > +			   DA9062AA_WATCHDOG_MASK);
> > +
> > +	mdelay(300);
> 
> Really ? That seems to be excessive, especially given how often
> this function is called (for each ping!).
> 

Please see above.

> > +
> > +	return ret;
> > +}
> > +
> > +static int da9062_wdt_update_timeout_register(struct da9062 *chip,
> > +					      unsigned int regval)
> > +{
> > +	int ret;
> > +
> > +	ret = da9062_reset_watchdog_timer(chip);
> > +	if (ret)
> > +		dev_err(chip->dev, "Failed to ping the watchdog (err =
> %d)\n",
> > +			ret);
> > +
> And no impact, so this doesn't really matter ?
> 

I really want to send an error so the user can be notified their ping()
has failed. As it stands, allowing thing to fail is not the best error path.

> > +	return regmap_update_bits(chip->regmap,
> > +				  DA9062AA_CONTROL_D,
> > +				  DA9062AA_TWDSCALE_MASK,
> > +				  regval);
> > +}
> > +

[...]

> > +static int da9062_wdt_stop(struct watchdog_device *wdd)
> > +{
> > +	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
> > +	int ret;
> > +
> > +	ret = da9062_reset_watchdog_timer(wdt->hw);
> > +	if (ret)
> > +		dev_err(wdt->hw->dev, "Failed to ping the watchdog (err =
> %d)\n",
> > +			ret);
> > +
> ping or reset ? And no impact, ie you just ignore the error ?
> 

Same again -- I will add an error path to this

[...]

> > +	wdt->wdtdev.info = &da9062_watchdog_info;
> > +	wdt->wdtdev.ops = &da9062_watchdog_ops;
> > +	wdt->wdtdev.min_timeout = DA9062_WDT_MIN_TIMEOUT;
> > +	wdt->wdtdev.max_timeout = DA9062_WDT_MAX_TIMEOUT;
> > +	wdt->wdtdev.timeout = DA9062_WDG_DEFAULT_TIMEOUT;
> > +	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
> > +
> > +	watchdog_set_drvdata(&wdt->wdtdev, wdt);
> > +	dev_set_drvdata(&pdev->dev, wdt);
> > +
> > +	irq = platform_get_irq_byname(pdev, "WDG_WARN");
> > +	if (irq < 0)
> > +		dev_err(wdt->hw->dev, "Failed to get IRQ.\n");
> 
> But you still request the negative irq.
> 
> > +
> > +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> > +			   da9062_wdt_wdg_warn_irq_handler,
> > +			    IRQF_TRIGGER_LOW | IRQF_ONESHOT |
> IRQF_SHARED,
> > +			   "WDG_WARN", wdt);
> > +	if (ret) {
> > +		dev_err(wdt->hw->dev,
> > +			"Failed to request watchdog device IRQ.\n");
> 
> Either this is an error, or it isn't. If it is, I would expect the driver
> to abort loading. If not, please don't use dev_err.
> 

I will put error paths in here also.

> > +	}
> > +
> > +	ret = watchdog_register_device(&wdt->wdtdev);
> > +	if (ret < 0)
> > +		dev_err(wdt->hw->dev,
> > +			"watchdog registration incomplete (%d)\n", ret);
> 
> incomplete ?
> 

Will fix this with an error path

> > +	else
> > +		dev_info(wdt->hw->dev, "installed DA9062 watchdog\n");
> 
> Please rop this message.
> 

Will do this.

> > +
> > +	da9062_wdt_ping(&wdt->wdtdev);
> > +	if (ret < 0)
> > +		dev_err(wdt->hw->dev,
> > +			"failed to ping the watchdog (%d)\n", ret);
> > +
> That ping is asking for an explanation. Does it imply that the watchdog is
> known to be running
> and can not be stopped ?
> 
> Also, the ping function already creates an error message. Please be less noisy
> with
> your messages.
> 
> > +	return ret;
> 
> If the above ping fails, this will return an error without unregistering
> the watchdog device.
> 

I will refactor this piece.

[...]

Regards,
Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

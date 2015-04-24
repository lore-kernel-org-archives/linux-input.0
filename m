From: "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH V1 2/6] regulator: da9062: DA9062 regulator driver
Date: Fri, 24 Apr 2015 14:47:06 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B2175E5@SW-EX-MBX02.diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <7acb2e683450a608adf81e6b820e62b523429101.1429280614.git.stwiss.opensource@diasemi.com>
 <20150418114828.GG26185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150418114828.GG26185-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


On 18 April 2015 12:48 Mark Brown wrote:

> On Fri, Apr 17, 2015 at 03:23:32PM +0100, S Twiss wrote:
> 
> > +/* Regulator interrupt handlers */
> > +static irqreturn_t da9062_ldo_lim_event(int irq, void *data)
> > +{
> > +	struct da9062_regulators *regulators = data;
> > +	struct da9062 *hw = regulators->regulator[0].hw;
> > +	struct da9062_regulator *regl;
> > +	int bits, i, ret;
> > +
> > +	ret = regmap_read(hw->regmap, DA9062AA_STATUS_D, &bits);
> > +	if (ret < 0)
> > +		return IRQ_NONE;
> 
> Please log an error for this, if we're having trouble talking to the
> device that seems like a serious issue.

Will do that with a dev_err()

-       if (ret < 0)
+       if (ret < 0) {
+               dev_err(hw->dev,
+                       "Failed to read LDO overcurrent indicator\n");
                return IRQ_NONE;
+       }

> 
> > +	for (i = regulators->n_regulators - 1; i >= 0; i--) {
> > +		regl = &regulators->regulator[i];
> > +		if (regl->info->oc_event.reg != DA9062AA_STATUS_D)
> > +			continue;
> > +
> > +		if (BIT(regl->info->oc_event.lsb) & bits)
> > +			regulator_notifier_call_chain(regl->rdev,
> > +
> 	REGULATOR_EVENT_OVER_CURRENT, NULL);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> 
> This will return IRQ_HANDLED even if none of the regulators were
> flagginng an event.
> 

Thanks,
I will refactor that part with a default error path and only return IRQ_HANDLED
when there is a hit on the notifier call.

> > +static irqreturn_t da9062_vdd_warn_event(int irq, void *data)
> > +{
> > +	return IRQ_HANDLED;
> > +}
> 
> Ignoring an interrupt is not usefully handling it - at the *least* this
> should be generating a log message.
> 

Not much use -- yes.

I've taken another look at this and I've decided to move it into the core.
The VDD_WARN applies to the system voltage and is not specific to regulators.
So it would make more sense for this to exist in the core driver instead -- this
would need to exist at all times and if it stays in the regulators it could be
moduled out of existence.

This will mean messing with a few files to fix this one.

drivers/mfd/da9062-core.c
regulator/da9062-regulator.c
include/linux/mfd/da9062/core.h

I'll resend this as PATCH V2.

> > +static struct da9062_regulators_pdata *da9062_parse_regulators_dt(
> > +		struct platform_device *pdev,
> > +		struct of_regulator_match **reg_matches)
> > +{
> > +	struct da9062_regulators_pdata *pdata;
> > +	struct da9062_regulator_data *rdata;
> > +	struct device_node *node;
> > +	int i, n, num;
> > +
> > +	node = of_get_child_by_name(pdev->dev.parent->of_node,
> "regulators");
> > +	if (!node) {
> > +		dev_err(&pdev->dev, "Regulators device node not
> found\n");
> > +		return ERR_PTR(-ENODEV);
> > +	}
> > +
> > +	num = of_regulator_match(&pdev->dev, node, da9062_matches,
> > +				 ARRAY_SIZE(da9062_matches));
> 
> Don't open code this, describe the DT names in the regualtor_desc and
> let the core register.
> 

Okay. I think I am getting this.
As of v3.18 there are  newer parts to regulator_desc from the commit 
a0c7b16 "regulator: of: Provide simplified DT parsing method"
The search function is now in the core. 

Am I on on the right track with this one?

> > +	if (IS_ERR(pdata) || pdata->n_regulators == 0) {
> > +		dev_err(&pdev->dev,
> > +			"No regulators defined for the platform\n");
> > +		return PTR_ERR(pdata);
> > +	}
> > +
> > +	n_regulators = ARRAY_SIZE(local_regulator_info),
> 
> This is broken, the set of regulators in the silicon is not a property
> of the platform.  The driver should just register all the regualtors
> that are present in the silicon.  I'm fairly sure I've been through this
> before...
> 
> > +	ret = request_threaded_irq(irq,
> > +				   NULL, da9062_vdd_warn_event,
> > +				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > +				   "VDD_WARN", regulators);
> 
> devm_request_threaded_irq().

yes -- this will come as part of the refactoring for the irq handler
static irqreturn_t da9062_vdd_warn_event(int irq, void *data)
into the core.

Regards,
Steve

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

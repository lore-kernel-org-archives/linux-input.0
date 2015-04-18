From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1 2/6] regulator: da9062: DA9062 regulator driver
Date: Sat, 18 Apr 2015 12:48:28 +0100
Message-ID: <20150418114828.GG26185@sirena.org.uk>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <7acb2e683450a608adf81e6b820e62b523429101.1429280614.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kjpMrWxdCilgNbo1"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:50692 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbbDRLs4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Apr 2015 07:48:56 -0400
Content-Disposition: inline
In-Reply-To: <7acb2e683450a608adf81e6b820e62b523429101.1429280614.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: LINUXKERNEL <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>


--kjpMrWxdCilgNbo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 17, 2015 at 03:23:32PM +0100, S Twiss wrote:

> +/* Regulator interrupt handlers */
> +static irqreturn_t da9062_ldo_lim_event(int irq, void *data)
> +{
> +	struct da9062_regulators *regulators = data;
> +	struct da9062 *hw = regulators->regulator[0].hw;
> +	struct da9062_regulator *regl;
> +	int bits, i, ret;
> +
> +	ret = regmap_read(hw->regmap, DA9062AA_STATUS_D, &bits);
> +	if (ret < 0)
> +		return IRQ_NONE;

Please log an error for this, if we're having trouble talking to the
device that seems like a serious issue.

> +	for (i = regulators->n_regulators - 1; i >= 0; i--) {
> +		regl = &regulators->regulator[i];
> +		if (regl->info->oc_event.reg != DA9062AA_STATUS_D)
> +			continue;
> +
> +		if (BIT(regl->info->oc_event.lsb) & bits)
> +			regulator_notifier_call_chain(regl->rdev,
> +					REGULATOR_EVENT_OVER_CURRENT, NULL);
> +	}
> +
> +	return IRQ_HANDLED;

This will return IRQ_HANDLED even if none of the regulators were
flagginng an event.

> +static irqreturn_t da9062_vdd_warn_event(int irq, void *data)
> +{
> +	return IRQ_HANDLED;
> +}

Ignoring an interrupt is not usefully handling it - at the *least* this
should be generating a log message.

> +static struct da9062_regulators_pdata *da9062_parse_regulators_dt(
> +		struct platform_device *pdev,
> +		struct of_regulator_match **reg_matches)
> +{
> +	struct da9062_regulators_pdata *pdata;
> +	struct da9062_regulator_data *rdata;
> +	struct device_node *node;
> +	int i, n, num;
> +
> +	node = of_get_child_by_name(pdev->dev.parent->of_node, "regulators");
> +	if (!node) {
> +		dev_err(&pdev->dev, "Regulators device node not found\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	num = of_regulator_match(&pdev->dev, node, da9062_matches,
> +				 ARRAY_SIZE(da9062_matches));

Don't open code this, describe the DT names in the regualtor_desc and
let the core register.

> +	if (IS_ERR(pdata) || pdata->n_regulators == 0) {
> +		dev_err(&pdev->dev,
> +			"No regulators defined for the platform\n");
> +		return PTR_ERR(pdata);
> +	}
> +
> +	n_regulators = ARRAY_SIZE(local_regulator_info),

This is broken, the set of regulators in the silicon is not a property
of the platform.  The driver should just register all the regualtors
that are present in the silicon.  I'm fairly sure I've been through this
before...

> +	ret = request_threaded_irq(irq,
> +				   NULL, da9062_vdd_warn_event,
> +				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +				   "VDD_WARN", regulators);

devm_request_threaded_irq().

--kjpMrWxdCilgNbo1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMkSMAAoJECTWi3JdVIfQH7AH/2dX0yzWNTBV76jedKR0IxZJ
53JdeMqgiWZAPiLDH9lD5KL0nRjMppri7uHPns81faOI3/ZvxesGrnsN1AYu9PZJ
Uqi4zi6aV+mj1uKziMMVpsT7WQqAhU1IeCAr7VV0UxCWqr/WgOAa+4hCjk7LnKcX
sxYiJVu0HpK9vh1/XdLN7yYS01VyIedanuP0ebvuBRtVAJOXIVkZoeNRVtzWflKS
qcNLXkhPe5e8vm8qWynqKn7O23t9KWZQFVrIOMh27GcTUuh6wkBwpOD/EAt2TZZh
SzkqnCOSDnXOOeKY5G3pzZPw8MkFCz2i8jul3DFKrd7T7xyhXTE54Mpnvmg7U0g=
=b4Hb
-----END PGP SIGNATURE-----

--kjpMrWxdCilgNbo1--

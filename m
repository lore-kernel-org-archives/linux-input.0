From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/8] regulator: stpmu1: add stpmu1 regulator driver
Date: Thu, 5 Jul 2018 17:48:20 +0100
Message-ID: <20180705164820.GB6227@sirena.org.uk>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com>
 <1530803657-17684-5-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530803657-17684-5-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
List-Id: linux-input@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 03:14:23PM +0000, Pascal PAILLET-LME wrote:

>  obj-$(CONFIG_REGULATOR_FIXED_VOLTAGE) +=3D fixed.o
>  obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) +=3D virtual.o
>  obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) +=3D userspace-consumer.o
> +obj-$(CONFIG_PROTECTION_CONSUMER) +=3D protection-consumer.o
> =20
>  obj-$(CONFIG_REGULATOR_88PG86X) +=3D 88pg86x.o
>  obj-$(CONFIG_REGULATOR_88PM800) +=3D 88pm800.o

Looks like this got included by mistake...

> --- /dev/null
> +++ b/drivers/regulator/stpmu1_regulator.c
> @@ -0,0 +1,919 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) STMicroelectronics 2018 - All Rights Reserved

All rights reserved and GPL :)

Please also make the entire comment a C++ one so the block looks more
intentional.

> +static unsigned int stpmu1_map_mode(unsigned int mode)
> +{
> +	return mode =3D=3D REGULATOR_MODE_STANDBY ?
> +		REGULATOR_MODE_STANDBY : REGULATOR_MODE_NORMAL;
> +}

This looks confused - what's going on here?  Normally a map_mode()
operation would be translating values in DT but this translates
everything that isn't standby into normal which suggests there's an
error checking problem.

> +static int stpmu1_ldo3_list_voltage(struct regulator_dev *rdev,
> +				    unsigned int sel)
> +{
> +	struct stpmu1_regulator *regul =3D rdev_get_drvdata(rdev);
> +
> +	if (sel =3D=3D 0)
> +		return regulator_list_voltage_linear_range(rdev, 1);
> +
> +	if (sel < 31)
> +		return regulator_list_voltage_linear_range(rdev, sel);
> +
> +	if (sel =3D=3D 31)
> +		return stpmu1_get_voltage_regmap(regul->voltage_ref_reg) / 2;
> +
> +	return -EINVAL;
> +}

The only thing that's going on here that's odd and that couldn't be
represented with a helper is selector 31 which looks to be some sort of
divided bypass mode - can you explain what this represents in hardware
terms please?

> +static int stpmu1_ldo3_get_voltage(struct regulator_dev *rdev)
> +{
> +	int sel =3D regulator_get_voltage_sel_regmap(rdev);
> +
> +	if (sel < 0)
> +		return -EINVAL;
> +
> +	return stpmu1_ldo3_list_voltage(rdev, (unsigned int)sel);
> +}

This is just the standard core behaviour, no need for this.

> +static int stpmu1_fixed_regul_get_voltage(struct regulator_dev *rdev)
> +{
> +	struct stpmu1_regulator *regul =3D rdev_get_drvdata(rdev);
> +	int id =3D rdev_get_id(rdev);
> +
> +	/* VREF_DDR voltage is equal to Buck2/2 */
> +	if (id =3D=3D STPMU1_VREF_DDR)
> +		return stpmu1_get_voltage_regmap(regul->voltage_ref_reg) / 2;
> +
> +	/* For all other case , rely on fixed value defined by Hw settings */
> +	return regul->cfg->desc.fixed_uV;
> +}

It'd be better to just use a separate set of operations for the DDR
regulator rather than have a conditional here, less code and makes it
clearer that this one is a special case.

> +static void update_regulator_constraints(int index,
> +					 struct regulator_init_data *init_data)
> +{
> +	struct stpmu1_regulator_cfg *cfg =3D &stpmu1_regulator_cfgs[index];
> +	struct regulator_desc *desc =3D &cfg->desc;
> +
> +	init_data->constraints.valid_ops_mask |=3D
> +		cfg->valid_ops_mask;
> +	init_data->constraints.valid_modes_mask |=3D
> +		cfg->valid_modes_mask;

Drivers should never be modifying their constraints, this is a no no.

> +	/*
> +	 * if all constraints are not specified in DT , ensure Hw
> +	 * constraints are met
> +	 */
> +	if (desc->n_voltages > 1) {

Drivers shouldn't be doing this either.  The API will not allow any
modifications of hardware state without constraints so unless the
bootloader is leaving things in a broken state we should be fine.

> +	if (!init_data->constraints.ramp_delay)
> +		init_data->constraints.ramp_delay =3D PMIC_RAMP_SLOPE_UV_PER_US;
> +
> +	if (!init_data->constraints.enable_time)
> +		init_data->constraints.enable_time =3D PMIC_ENABLE_TIME_US;

If these are hard constraints we know from the chip design they should
be being set in the descriptor.  The constraints are there to override
if either they're board dependent or the board needs something longer
than the chip default.

> +	/* LDO3 and VREF_DDR can use buck2 as reference voltage */
> +	if (regul->regul_id =3D=3D STPMU1_LDO3 ||
> +	    regul->regul_id =3D=3D STPMU1_VREF_DDR) {
> +		if (!buck2) {
> +			dev_err(&pdev->dev,
> +				"Error in PMIC regulator settings: Buck2 is not defined prior to LDO=
3 or VREF_DDR regulators\n"
> +				);
> +			return ERR_PTR(-EINVAL);
> +		}
> +		regul->voltage_ref_reg =3D buck2;
> +	}

Can or do?  Usually this would be hooked up in the DT (with the
regulator specifying a supply name in the desc).

> +	np =3D pdev->dev.of_node;
> +	if (!np) {
> +		dev_err(&pdev->dev, "regulators node not found\n");
> +		return -EINVAL;
> +	}
> +

May as well let the driver probe?

> +	/* Register all defined (from DT) regulators to Regulator Framework */
> +	for (i =3D 0; i < ARRAY_SIZE(stpmu1_regulator_cfgs); i++) {
> +		/* Parse DT & find regulators to register */
> +		init_data =3D stpmu1_regulators_matches[i].init_data;

You should register everything that's physically there unconditionally,
there's no harm in having a regulator registered that's not used and it
might be useful for debugging purposes.

> +static const struct of_device_id of_pmic_regulator_match[] =3D {
> +	{ .compatible =3D "st,stpmu1-regulators" },
> +	{ },
> +};

This is part of a MFD for a single chip, why do we need a specific
compatible string here rather than just enumerating from the base
registration of the device?

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls+S9QACgkQJNaLcl1U
h9Ah8Af/WM+VknAiFcVbiVarONpM4bnMEejAs5ViUkRjTy5YO3N+PrZqEWwwSQFe
adumgdEpd3G/tYrJOqQmFxUFdJrY6OEMIL0G0Gi/VNjhFadUGs6wWC9KBEG/NNcC
ei0ExN18lyXSm/jE6k+1VX6Ty0pQt2R6ZE8pxd6aUqK1oZnnPl8wdgoinNmgZViq
6Ju9T048e1lL8OfRt9jtveEBc+6M+yRuCaLpKQvtX7zDZlA6j+LI+EpZRBQIoyUK
jFQcHIVzRHPqEq3UvYgmwJ0sHkvH7l27h0sUr3mc/LY5fTB/xY2BPK5MxzLyz9wM
mdoOqdgADZ+7MqlrzbtkOgA7zvJaOA==
=wg+l
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

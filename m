From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 4/9] extcon/input/mfd/power/regulator: max77693: Move
 state container to common header
Date: Wed, 27 May 2015 11:25:03 +0100
Message-ID: <20150527102503.GE11677@x1>
References: <1432446213-4886-1-git-send-email-k.kozlowski.k@gmail.com>
 <1432446213-4886-5-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35792 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbbE0KZJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 May 2015 06:25:09 -0400
Received: by wgme6 with SMTP id e6so5306112wgm.2
        for <linux-input@vger.kernel.org>; Wed, 27 May 2015 03:25:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432446213-4886-5-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org

On Sun, 24 May 2015, Krzysztof Kozlowski wrote:

> This prepares for merging some of the drivers between max77693 and
> max77843 so the child MFD driver can be attached to any parent MFD ma=
in
> driver.
>=20
> Move the state container to common header file. Additionally add
> consistent 'i2c' prefixes to its members (of 'struct i2c_client' type=
).
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/extcon/extcon-max77693.c     |  3 ++-
>  drivers/input/misc/max77693-haptic.c |  1 +
>  drivers/mfd/max77693.c               | 31 +++++++++++++------------
>  drivers/power/max77693_charger.c     |  1 +
>  drivers/regulator/max77693.c         |  1 +
>  include/linux/mfd/max77693-common.h  | 44 ++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/max77693-private.h | 25 --------------------
>  7 files changed, 65 insertions(+), 41 deletions(-)
>  create mode 100644 include/linux/mfd/max77693-common.h

I think I Acked a version of this already:

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon=
-max77693.c
> index 78ed8727024f..4ef45f257e6e 100644
> --- a/drivers/extcon/extcon-max77693.c
> +++ b/drivers/extcon/extcon-max77693.c
> @@ -25,6 +25,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/mfd/max77693.h>
>  #include <linux/mfd/max77693-private.h>
> +#include <linux/mfd/max77693-common.h>
>  #include <linux/extcon.h>
>  #include <linux/regmap.h>
>  #include <linux/irqdomain.h>
> @@ -1077,7 +1078,7 @@ static int max77693_muic_probe(struct platform_=
device *pdev)
>  		dev_dbg(&pdev->dev, "allocate register map\n");
>  	} else {
>  		info->max77693->regmap_muic =3D devm_regmap_init_i2c(
> -						info->max77693->muic,
> +						info->max77693->i2c_muic,
>  						&max77693_muic_regmap_config);
>  		if (IS_ERR(info->max77693->regmap_muic)) {
>  			ret =3D PTR_ERR(info->max77693->regmap_muic);
> diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/mis=
c/max77693-haptic.c
> index 39e930c10ebb..69a4e401fe24 100644
> --- a/drivers/input/misc/max77693-haptic.c
> +++ b/drivers/input/misc/max77693-haptic.c
> @@ -25,6 +25,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/mfd/max77693.h>
>  #include <linux/mfd/max77693-private.h>
> +#include <linux/mfd/max77693-common.h>
> =20
>  #define MAX_MAGNITUDE_SHIFT	16
> =20
> diff --git a/drivers/mfd/max77693.c b/drivers/mfd/max77693.c
> index cb14afa97e6f..07fdf35bb9a1 100644
> --- a/drivers/mfd/max77693.c
> +++ b/drivers/mfd/max77693.c
> @@ -34,6 +34,7 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/max77693.h>
>  #include <linux/mfd/max77693-private.h>
> +#include <linux/mfd/max77693-common.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/regmap.h>
> =20
> @@ -193,22 +194,22 @@ static int max77693_i2c_probe(struct i2c_client=
 *i2c,
>  	} else
>  		dev_info(max77693->dev, "device ID: 0x%x\n", reg_data);
> =20
> -	max77693->muic =3D i2c_new_dummy(i2c->adapter, I2C_ADDR_MUIC);
> -	if (!max77693->muic) {
> +	max77693->i2c_muic =3D i2c_new_dummy(i2c->adapter, I2C_ADDR_MUIC);
> +	if (!max77693->i2c_muic) {
>  		dev_err(max77693->dev, "Failed to allocate I2C device for MUIC\n")=
;
>  		return -ENODEV;
>  	}
> -	i2c_set_clientdata(max77693->muic, max77693);
> +	i2c_set_clientdata(max77693->i2c_muic, max77693);
> =20
> -	max77693->haptic =3D i2c_new_dummy(i2c->adapter, I2C_ADDR_HAPTIC);
> -	if (!max77693->haptic) {
> +	max77693->i2c_haptic =3D i2c_new_dummy(i2c->adapter, I2C_ADDR_HAPTI=
C);
> +	if (!max77693->i2c_haptic) {
>  		dev_err(max77693->dev, "Failed to allocate I2C device for Haptic\n=
");
>  		ret =3D -ENODEV;
>  		goto err_i2c_haptic;
>  	}
> -	i2c_set_clientdata(max77693->haptic, max77693);
> +	i2c_set_clientdata(max77693->i2c_haptic, max77693);
> =20
> -	max77693->regmap_haptic =3D devm_regmap_init_i2c(max77693->haptic,
> +	max77693->regmap_haptic =3D devm_regmap_init_i2c(max77693->i2c_hapt=
ic,
>  					&max77693_regmap_haptic_config);
>  	if (IS_ERR(max77693->regmap_haptic)) {
>  		ret =3D PTR_ERR(max77693->regmap_haptic);
> @@ -222,7 +223,7 @@ static int max77693_i2c_probe(struct i2c_client *=
i2c,
>  	 * instance of MUIC device when irq of max77693 is initialized
>  	 * before call max77693-muic probe() function.
>  	 */
> -	max77693->regmap_muic =3D devm_regmap_init_i2c(max77693->muic,
> +	max77693->regmap_muic =3D devm_regmap_init_i2c(max77693->i2c_muic,
>  					 &max77693_regmap_muic_config);
>  	if (IS_ERR(max77693->regmap_muic)) {
>  		ret =3D PTR_ERR(max77693->regmap_muic);
> @@ -255,7 +256,7 @@ static int max77693_i2c_probe(struct i2c_client *=
i2c,
>  				IRQF_ONESHOT | IRQF_SHARED |
>  				IRQF_TRIGGER_FALLING, 0,
>  				&max77693_charger_irq_chip,
> -				&max77693->irq_data_charger);
> +				&max77693->irq_data_chg);
>  	if (ret) {
>  		dev_err(max77693->dev, "failed to add irq chip: %d\n", ret);
>  		goto err_irq_charger;
> @@ -296,15 +297,15 @@ err_mfd:
>  err_intsrc:
>  	regmap_del_irq_chip(max77693->irq, max77693->irq_data_muic);
>  err_irq_muic:
> -	regmap_del_irq_chip(max77693->irq, max77693->irq_data_charger);
> +	regmap_del_irq_chip(max77693->irq, max77693->irq_data_chg);
>  err_irq_charger:
>  	regmap_del_irq_chip(max77693->irq, max77693->irq_data_topsys);
>  err_irq_topsys:
>  	regmap_del_irq_chip(max77693->irq, max77693->irq_data_led);
>  err_regmap:
> -	i2c_unregister_device(max77693->haptic);
> +	i2c_unregister_device(max77693->i2c_haptic);
>  err_i2c_haptic:
> -	i2c_unregister_device(max77693->muic);
> +	i2c_unregister_device(max77693->i2c_muic);
>  	return ret;
>  }
> =20
> @@ -315,12 +316,12 @@ static int max77693_i2c_remove(struct i2c_clien=
t *i2c)
>  	mfd_remove_devices(max77693->dev);
> =20
>  	regmap_del_irq_chip(max77693->irq, max77693->irq_data_muic);
> -	regmap_del_irq_chip(max77693->irq, max77693->irq_data_charger);
> +	regmap_del_irq_chip(max77693->irq, max77693->irq_data_chg);
>  	regmap_del_irq_chip(max77693->irq, max77693->irq_data_topsys);
>  	regmap_del_irq_chip(max77693->irq, max77693->irq_data_led);
> =20
> -	i2c_unregister_device(max77693->muic);
> -	i2c_unregister_device(max77693->haptic);
> +	i2c_unregister_device(max77693->i2c_muic);
> +	i2c_unregister_device(max77693->i2c_haptic);
> =20
>  	return 0;
>  }
> diff --git a/drivers/power/max77693_charger.c b/drivers/power/max7769=
3_charger.c
> index 754879eb59f6..eb68d0572799 100644
> --- a/drivers/power/max77693_charger.c
> +++ b/drivers/power/max77693_charger.c
> @@ -21,6 +21,7 @@
>  #include <linux/regmap.h>
>  #include <linux/mfd/max77693.h>
>  #include <linux/mfd/max77693-private.h>
> +#include <linux/mfd/max77693-common.h>
> =20
>  #define MAX77693_CHARGER_NAME				"max77693-charger"
>  static const char *max77693_charger_model		=3D "MAX77693";
> diff --git a/drivers/regulator/max77693.c b/drivers/regulator/max7769=
3.c
> index 236851ab575a..5b30dc42679c 100644
> --- a/drivers/regulator/max77693.c
> +++ b/drivers/regulator/max77693.c
> @@ -30,6 +30,7 @@
>  #include <linux/regulator/machine.h>
>  #include <linux/mfd/max77693.h>
>  #include <linux/mfd/max77693-private.h>
> +#include <linux/mfd/max77693-common.h>
>  #include <linux/regulator/of_regulator.h>
>  #include <linux/regmap.h>
> =20
> diff --git a/include/linux/mfd/max77693-common.h b/include/linux/mfd/=
max77693-common.h
> new file mode 100644
> index 000000000000..7da4cc38e982
> --- /dev/null
> +++ b/include/linux/mfd/max77693-common.h
> @@ -0,0 +1,44 @@
> +/*
> + * Common data shared between Maxim 77693 and 77843 drivers
> + *
> + * Copyright (C) 2015 Samsung Electronics
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __LINUX_MFD_MAX77693_COMMON_H
> +#define __LINUX_MFD_MAX77693_COMMON_H
> +
> +enum max77693_types {
> +	TYPE_MAX77693_UNKNOWN,
> +	TYPE_MAX77693,
> +};
> +
> +/*
> + * Shared also with max77843.
> + */
> +struct max77693_dev {
> +	struct device *dev;
> +	struct i2c_client *i2c;		/* 0xCC , PMIC, Charger, Flash LED */
> +	struct i2c_client *i2c_muic;	/* 0x4A , MUIC */
> +	struct i2c_client *i2c_haptic;	/* MAX77693: 0x90 , Haptic */
> +
> +	enum max77693_types type;
> +
> +	struct regmap *regmap;
> +	struct regmap *regmap_muic;
> +	struct regmap *regmap_haptic;	/* Only MAX77693 */
> +
> +	struct regmap_irq_chip_data *irq_data_led;
> +	struct regmap_irq_chip_data *irq_data_topsys;
> +	struct regmap_irq_chip_data *irq_data_chg; /* Only MAX77693 */
> +	struct regmap_irq_chip_data *irq_data_muic;
> +
> +	int irq;
> +};
> +
> +
> +#endif /*  __LINUX_MFD_MAX77693_COMMON_H */
> diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd=
/max77693-private.h
> index e3c0afff38d3..8c4143c0c651 100644
> --- a/include/linux/mfd/max77693-private.h
> +++ b/include/linux/mfd/max77693-private.h
> @@ -529,29 +529,4 @@ enum max77693_irq_muic {
>  	MAX77693_MUIC_IRQ_NR,
>  };
> =20
> -enum max77693_types {
> -	TYPE_MAX77693_UNKNOWN,
> -	TYPE_MAX77693,
> -};
> -
> -struct max77693_dev {
> -	struct device *dev;
> -	struct i2c_client *i2c;		/* 0xCC , PMIC, Charger, Flash LED */
> -	struct i2c_client *muic;	/* 0x4A , MUIC */
> -	struct i2c_client *haptic;	/* 0x90 , Haptic */
> -
> -	enum max77693_types type;
> -
> -	struct regmap *regmap;
> -	struct regmap *regmap_muic;
> -	struct regmap *regmap_haptic;
> -
> -	struct regmap_irq_chip_data *irq_data_led;
> -	struct regmap_irq_chip_data *irq_data_topsys;
> -	struct regmap_irq_chip_data *irq_data_charger;
> -	struct regmap_irq_chip_data *irq_data_muic;
> -
> -	int irq;
> -};
> -
>  #endif /*  __LINUX_MFD_MAX77693_PRIV_H */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714613;
	b=BpZui9FuCPwbF6fDgg8RD6yRg1ScGfORXaGHfDoWe+BUwks5UBw0rz4Nv1wxzCe5WQiS
	 MTQGF3ZJXRtFc9BFNQhfvEl3116n7LacKETS8VW6yHIhQjnTjxaoBrw/JWTKDNRZcH/Kn
	 Fd6IgfyrHx5q5RqMS1VwqIDOZQ0OZlBHRj1m1U9LJ8G2Ezt1C8ibcFJoiBiSEhUesJstg
	 U/ViaE8D0P/4EqYzfKtUs7KVqr/XpoZtFCbFXJTdqj0c4NnP7eu0K8dMI39QrkImSiwPp
	 cvrZw8e7bPpLkKo7Jm5QzujYCUYb9GKZQwuiSzxnS8j/rB801X+uiQEMNiKDjQNTFuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714613;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-AI-Review-Draft;
	bh=3HJX18ykscvO3Ox8qDgd1rJ1bwooSHpiMGqMiZwMMMg=;
	b=PnmCGQKNBS46peh4x0USb+IWd9yVaz9MIT9QyIYi+Jlun3IVpw5XVMUTTMVw6T+7O8Ae
	 +rxyISGVvpUQLcLTfUmVWskpYOlYBNuEtHrvXikQKlTUXV+ApoOojSbXKcljvLdapLIk4
	 RZg2cS0wATglNXTXNXiAqv/8GlVcMw/RsuF9Ss+OFp484djegvJStjeUet/YQcC3C4r1B
	 YzW2iSAMnhcwXg0ew4baJmUWeQCj/trd9mtNO4Pe8SqMnAYYyG7YJ7Utd/b5zlqpYsZBi
	 lmfVAprbqK7wJV0+tSdYb5oJR87wZ+FMdYrZrnMLCEhDxSTXM4ZGesmvkVsoyL+fIoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+25HXE5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933D60A5BC5;
	Tue,  3 Nov 2026 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+25HXE5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1231F000C1;
	Tue,  3 Nov 2026 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793714612;
	bh=3HJX18ykscvO3Ox8qDgd1rJ1bwooSHpiMGqMiZwMMMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H+25HXE5bQpX4SO6gYb6lfNqegbOjuTEPRjDTsov3P5/8PY3O6+yCpLEnoRuWG2cM
	 R3F3IONKnEja1N07TiEc6wZb4sxxfAXv3QJOyoahBKWyL8AT1B0J4aluBdr55LSvRH
	 xJt10MUkc/KbiXXgzOc6meqOQUJ/Q8e8yza3gfKJKcK01aeuKZdv5AzBl0LDpqJia+
	 uMy57b7+9YkgVs4PG20ToXl7VRPeRxdXFeXLJyV2nCgAmoAc3AEn0OBDLhfRvh+QuO
	 rzrDuT1Q/ok87SlSTgdOHGi/J3hEIU1SJDIZf3NaxSJJmJrje95+ccNgkVzajP3lA7
	 06lV6qUKJ+t1g==
Date: Tue, 3 Nov 2026 14:03:26 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Ion Agorria <ion@agorria.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, mfd@lists.linux.dev,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v12 5/7] leds: Add driver for ASUS Transformer LEDs
Message-ID: <179249575817.1833288.1089755405582445022@kernel.org>
References: <20261019100406.103687-1-clamor95@gmail.com>
 <20261019100406.103687-6-clamor95@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261019100406.103687-6-clamor95@gmail.com>
X-AI-Review-Draft: <20261019100406.103687-6-clamor95@gmail.com>

On Mon, 19 Oct 2026, Svyatoslav Ryhel wrote:
> From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
>
> ASUS Transformer tablets have a green and an amber LED on both the Pad
> and the Dock. If both LEDs are enabled simultaneously, the emitted light
> will be yellow.
>
> Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/leds/Kconfig                    |  11 +++
>  drivers/leds/Makefile                   |   1 +
>  drivers/leds/leds-asus-transformer-ec.c | 125 ++++++++++++++++++++++++
>  3 files changed, 137 insertions(+)
>  create mode 100644 drivers/leds/leds-asus-transformer-ec.c
>
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 7ec2c8d785426..788e689fe875c 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -120,6 +120,17 @@ config LEDS_OSRAM_AMS_AS3668
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called leds-as3668.
>
> +config LEDS_ASUS_TRANSFORMER_EC
> +	tristate "LED Support for Asus Transformer charging LED"
> +	depends on LEDS_CLASS
> +	depends on MFD_ASUS_TRANSFORMER_EC
> +	help
> +	  This option enables support for charging indicator on
> +	  Asus Transformer's Pad and its Dock.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called leds-asus-transformer-ec.
> +
>  config LEDS_AW200XX
>  	tristate "LED support for Awinic AW20036/AW20054/AW20072/AW20108"
>  	depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 4d4b089156e24..3da746279bb81 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_LEDS_ADP5520)		+= leds-adp5520.o
>  obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
>  obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
>  obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
> +obj-$(CONFIG_LEDS_ASUS_TRANSFORMER_EC)	+= leds-asus-transformer-ec.o
>  obj-$(CONFIG_LEDS_OSRAM_AMS_AS3668)	+= leds-as3668.o
>  obj-$(CONFIG_LEDS_AW200XX)		+= leds-aw200xx.o
>  obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
> diff --git a/drivers/leds/leds-asus-transformer-ec.c b/drivers/leds/leds-asus-transformer-ec.c
> new file mode 100644
> index 0000000000000..1b129247ea6c6
> --- /dev/null
> +++ b/drivers/leds/leds-asus-transformer-ec.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/err.h>
> +#include <linux/leds.h>
> +#include <linux/mfd/asus-transformer-ec.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +enum {
> +	ASUSEC_LED_AMBER,
> +	ASUSEC_LED_GREEN,
> +	ASUSEC_LED_MAX
> +};
> +
> +struct asus_ec_led_config {
> +	const char *name;
> +	unsigned int color;
> +	u64 ctrl_bit;
> +};
> +
> +struct asus_ec_led {
> +	struct asus_ec_leds_data *ddata;


Why do we need 'struct asus_ec_leds_data' at all?

If we put 'const struct asusec_core *ec;' directly into 'struct
asus_ec_led', we can drop the outer wrapper struct and the back-pointer
completely.

> +	struct led_classdev cdev;
> +	u64 ctrl_bit;
> +};
> +
> +struct asus_ec_leds_data {
> +	const struct asusec_core *ec;
> +	struct asus_ec_led leds[ASUSEC_LED_MAX];
> +};
> +
> +static const struct asus_ec_led_config asus_ec_leds[] = {
> +	[ASUSEC_LED_AMBER] = {
> +		.name = "amber",
> +		.color = LED_COLOR_ID_AMBER,
> +		.ctrl_bit = ASUSEC_CTL_LED_AMBER,
> +	},
> +	[ASUSEC_LED_GREEN] = {
> +		.name = "green",
> +		.color = LED_COLOR_ID_GREEN,
> +		.ctrl_bit = ASUSEC_CTL_LED_GREEN,
> +	},
> +};
> +
> +static enum led_brightness asus_ec_led_get_brightness(struct led_classdev *cdev)
> +{
> +	struct asus_ec_led *led = container_of(cdev, struct asus_ec_led, cdev);
> +	const struct asusec_core *ec = led->ddata->ec;
> +	u64 ctl;
> +	int ret;
> +
> +	ret = asus_dockram_access_ctl(ec->dockram, &ctl, 0, 0);

As requested on v6 and v8, why are we still using this bespoke accessor instead
of Regmap?

> +	if (ret)
> +		return LED_OFF;
> +
> +	return ctl & led->ctrl_bit ? LED_ON : LED_OFF;
> +}
> +
> +static int asus_ec_led_set_brightness(struct led_classdev *cdev,
> +				      enum led_brightness brightness)
> +{
> +	struct asus_ec_led *led = container_of(cdev, struct asus_ec_led, cdev);
> +	const struct asusec_core *ec = led->ddata->ec;
> +
> +	if (brightness)
> +		return asus_dockram_access_ctl(ec->dockram, NULL,
> +					       led->ctrl_bit, led->ctrl_bit);

Use 100-chars throughout to prevent early wrapping.

> +	return asus_dockram_access_ctl(ec->dockram, NULL, led->ctrl_bit, 0);
> +}
> +
> +static int asus_ec_led_probe(struct platform_device *pdev)
> +{
> +	const struct asusec_core *ec = dev_get_drvdata(pdev->dev.parent);
> +	struct asus_ec_leds_data *ddata;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ddata);

What consumes this?

> +	ddata->ec = ec;
> +
> +	for (int i = 0; i < ASUSEC_LED_MAX; i++) {

`i` isn't just a random iterator here - maybe call it `led`?

> +		const struct asus_ec_led_config *cfg = &asus_ec_leds[i];
> +		struct asus_ec_led *led = &ddata->leds[i];
> +
> +		led->cdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s",
> +						ddata->ec->name, cfg->name);
> +		if (!led->cdev.name)
> +			return -ENOMEM;
> +
> +		led->cdev.max_brightness = 1;
> +		led->cdev.color = cfg->color;
> +		led->cdev.flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
> +		led->cdev.brightness_get = asus_ec_led_get_brightness;
> +		led->cdev.brightness_set_blocking = asus_ec_led_set_brightness;
> +
> +		led->ddata = ddata;
> +		led->ctrl_bit = cfg->ctrl_bit;
> +
> +		ret = devm_led_classdev_register(dev, &led->cdev);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to register %s LED\n",
> +					     cfg->name);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver asus_ec_led_driver = {
> +	.driver.name = "asus-transformer-ec-led",

Clever!  But, I'd prefer we still to the usual format to be honest.

> +	.probe = asus_ec_led_probe,
> +};
> +module_platform_driver(asus_ec_led_driver);
> +
> +MODULE_ALIAS("platform:asus-transformer-ec-led");
> +MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
> +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> +MODULE_DESCRIPTION("ASUS Transformer's charging LED driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.53.0
>

-- 
Lee Jones

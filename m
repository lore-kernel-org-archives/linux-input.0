From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] input/keyboard: Add support for Dollar Cove TI power
 button
Date: Thu, 31 Aug 2017 11:33:55 -0700
Message-ID: <20170831183355.GB14370@dtor-ws>
References: <20170822055710.26515-1-tiwai@suse.de>
 <20170822055710.26515-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170822055710.26515-3-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Takashi,

On Tue, Aug 22, 2017 at 07:57:09AM +0200, Takashi Iwai wrote:
> This provides a new input driver for supporting the power button on
> Dollar Cove TI PMIC, found on Cherrytrail-based devices.
> The patch is based on the original work by Intel, found at:
>   https://github.com/01org/ProductionKernelQuilts
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/input/keyboard/Kconfig        |  7 +++
>  drivers/input/keyboard/Makefile       |  1 +
>  drivers/input/keyboard/dc_ti_pwrbtn.c | 85 +++++++++++++++++++++++++++++++++++

Not sure if it ends up in drivers/input/keyboard, or drivers/input/misc/
(where most power buttons live) or in platform drivers, still a few
comments below.

>  3 files changed, 93 insertions(+)
>  create mode 100644 drivers/input/keyboard/dc_ti_pwrbtn.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 4c4ab1ced235..673748b3cc34 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -756,4 +756,11 @@ config KEYBOARD_BCM
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bcm-keypad.
>  
> +config KEYBOARD_DC_TI_PWRBTN
> +	tristate "Dollar Cove TI power button driver"
> +	depends on INTEL_SOC_PMIC_DC_TI
> +	help
> +	  Say Y here fi you want to have a power button driver for
> +	  Dollar Cove TI PMIC.

If keeping in input we customarily call out the module name (see a few
lines above).

> +
>  endif
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index d2338bacdad1..fa473d241e5c 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -66,3 +66,4 @@ obj-$(CONFIG_KEYBOARD_TM2_TOUCHKEY)	+= tm2-touchkey.o
>  obj-$(CONFIG_KEYBOARD_TWL4030)		+= twl4030_keypad.o
>  obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
>  obj-$(CONFIG_KEYBOARD_W90P910)		+= w90p910_keypad.o
> +obj-$(CONFIG_KEYBOARD_DC_TI_PWRBTN)	+= dc_ti_pwrbtn.o
> diff --git a/drivers/input/keyboard/dc_ti_pwrbtn.c b/drivers/input/keyboard/dc_ti_pwrbtn.c
> new file mode 100644
> index 000000000000..a0900a440c92
> --- /dev/null
> +++ b/drivers/input/keyboard/dc_ti_pwrbtn.c
> @@ -0,0 +1,85 @@
> +/*
> + * Power button driver for Dollar Cove TI PMIC
> + * Copyright (C) 2014 Intel Corp
> + * Copyright (c) 2017 Takashi Iwai <tiwai@suse.de>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/input.h>
> +#include <linux/mfd/intel_soc_pmic.h>
> +
> +#define DC_TI_SIRQ_REG		0x3
> +#define SIRQ_PWRBTN_REL		(1 << 0)

BIT()?

> +
> +#define DRIVER_NAME "dc_ti_pwrbtn"
> +
> +static irqreturn_t dc_ti_pwrbtn_interrupt(int irq, void *dev_id)
> +{
> +	struct input_dev *pwrbtn_input = dev_id;
> +	struct device *dev = pwrbtn_input->dev.parent;
> +	struct regmap *regmap = dev_get_drvdata(dev);
> +	int state;
> +
> +	if (!regmap_read(regmap, DC_TI_SIRQ_REG, &state)) {
> +		dev_dbg(dev, "SIRQ_REG=0x%x\n", state);
> +		state &= SIRQ_PWRBTN_REL;
> +		input_event(pwrbtn_input, EV_KEY, KEY_POWER, !state);

Why not

		input_report_key(pwrbtn_input, KEY_POWER,
				 !(state & SIRQ_PWRBTN_REL));

> +		input_sync(pwrbtn_input);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int dc_ti_pwrbtn_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
> +	struct input_dev *pwrbtn_input;
> +	int irq;
> +	int ret;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return -EINVAL;

Why do you clobber return value? Simply return "irq".

> +	pwrbtn_input = devm_input_allocate_device(dev);
> +	if (!pwrbtn_input)
> +		return -ENOMEM;
> +	pwrbtn_input->name = pdev->name;
> +	pwrbtn_input->phys = "dc-ti-power/input0";
> +	pwrbtn_input->id.bustype = BUS_HOST;
> +	pwrbtn_input->dev.parent = dev;

Not needed since devm_input_allocate_device() does it for us.

> +	input_set_capability(pwrbtn_input, EV_KEY, KEY_POWER);
> +	ret = input_register_device(pwrbtn_input);
> +	if (ret)
> +		return ret;

If staying in input, can we please call this variable err or error?

> +
> +	dev_set_drvdata(dev, pmic->regmap);
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL, dc_ti_pwrbtn_interrupt,
> +					0, KBUILD_MODNAME, pwrbtn_input);
> +	if (ret)
> +		return ret;
> +
> +	ret = enable_irq_wake(irq);
> +	if (ret)
> +		dev_warn(dev, "Can't enable IRQ as wake source: %d\n", ret);

We do not normally enable wake IRQs in probe, but instead do:

	device_init_wakeup(&pdev->dev, true);

in probe() and then check it in suspend/resume:

	if (device_may_wakeup(dev)) {
		err = enable_irq_wake(XXX->irq);
		if (!err)
			XXX->irq_wake_enabled = true;
	}

...

	if (XXX->irq_wake_enabled)
		disable_irq_wake(XXX->irq);

This allows userspace to inhibit wakeup, if needed.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver dc_ti_pwrbtn_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +	},
> +	.probe	= dc_ti_pwrbtn_probe,
> +};
> +
> +module_platform_driver(dc_ti_pwrbtn_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
> -- 
> 2.14.0
> 

Thanks!

-- 
Dmitry

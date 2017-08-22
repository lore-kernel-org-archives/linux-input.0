From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] mfd: Add support for Cherry Trail Dollar Cove TI
 PMIC
Date: Tue, 22 Aug 2017 12:37:45 +0300
Message-ID: <1503394665.25945.43.camel@linux.intel.com>
References: <20170822055710.26515-1-tiwai@suse.de>
         <20170822055710.26515-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170822055710.26515-2-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 2017-08-22 at 07:57 +0200, Takashi Iwai wrote:
> This patch adds the MFD driver for Dollar Cove TI PMIC (ACPI INT33F5)
> that is found on some Intel Cherry Trail devices.
> The driver is based on the original work by Intel, found at:
>   https://github.com/01org/ProductionKernelQuilts
> 
> This is a minimal version for adding the basic resources.  Currently,
> only ACPI PMIC opregion and the external power-button are used.

Overall looks good. Few comments below.

I hope Hans de Goede had been involved somehow to this. He did enormous
work to examine all this PMIC/ACPI/I2C stuff on CHT platforms.

> +#include <linux/module.h>
> +#include <linux/mfd/core.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/acpi.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/intel_soc_pmic.h>

Alphabetical order?

> +static const struct i2c_device_id dc_ti_i2c_id[] = {
> +	{ }
> +};

No need anymore. Moreover, you already are using ->probe_new().


> +static struct i2c_driver dc_ti_i2c_driver = {
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.pm = &dc_ti_pm_ops,
> +		.acpi_match_table = ACPI_PTR(dc_ti_acpi_ids),

ACPI_PTR is redundant here, driver is solely for ACPI case.

> +	},
> +	.probe_new = dc_ti_probe,
> +	.shutdown = dc_ti_shutdown,
> +	.id_table = dc_ti_i2c_id,
> +};

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

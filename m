From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V2 8/8] watchdog: stpmic1: add stpmic1 watchdog driver
Date: Fri, 7 Sep 2018 06:48:02 -0700
Message-ID: <c1594be0-5210-bfe0-59b8-d8b163195da5@roeck-us.net>
References: <1536325173-16617-1-git-send-email-p.paillet@st.com>
 <1536325173-16617-9-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536325173-16617-9-git-send-email-p.paillet@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>
List-Id: linux-input@vger.kernel.org

On 09/07/2018 05:59 AM, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The stpmic1 PMIC embeds a watchdog which is disabled by default. As soon
> as the watchdog is started, it must be refreshed periodically otherwise
> the PMIC goes off.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v2:
> * the hardware component has been renamed from stpmu1 to stpmic1 !
> * change headers
> * handle remarks from Guenter

Hmm ... as if I would remember what those were.

> * fix set timeout
> 
>   drivers/watchdog/Kconfig       |  12 ++++
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/stpmic1_wdt.c | 130 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 143 insertions(+)
>   create mode 100644 drivers/watchdog/stpmic1_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9af07fd..11c5937 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -796,6 +796,18 @@ config STM32_WATCHDOG
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called stm32_iwdg.
>   
> +config STPMIC1_WATCHDOG
> +	tristate "STPMIC1 PMIC watchdog support"
> +	depends on MFD_STPMIC1
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include watchdog support embedded into STPMIC1 PMIC.
> +	  If the watchdog timer expires, stpmic1 shut-down all its power
> +	  supplies.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called spmic1_wdt.
> +
>   config UNIPHIER_WATCHDOG
>   	tristate "UniPhier watchdog support"
>   	depends on ARCH_UNIPHIER || COMPILE_TEST
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 1d3c6b0..a898d8f 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -216,3 +216,4 @@ obj-$(CONFIG_ZIIRAVE_WATCHDOG) += ziirave_wdt.o
>   obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
>   obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
>   obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
> +obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
> diff --git a/drivers/watchdog/stpmic1_wdt.c b/drivers/watchdog/stpmic1_wdt.c
> new file mode 100644
> index 0000000..391e544
> --- /dev/null
> +++ b/drivers/watchdog/stpmic1_wdt.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) STMicroelectronics 2018
> +// Author: Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
> + > +#include <linux/kernel.h>
> +#include <linux/mfd/stpmic1.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/reboot.h>
> +#include <linux/slab.h>
> +#include <linux/watchdog.h>
> +
> +/* WATCHDOG CONTROL REGISTER bit */
> +#define WDT_START		BIT(0)
> +#define WDT_PING		BIT(1)
> +#define WDT_START_MASK		BIT(0)
> +#define WDT_PING_MASK		BIT(1)
> +
> +#define PMIC_WDT_MIN_TIMEOUT 1
> +#define PMIC_WDT_MAX_TIMEOUT 256
> +
> +struct stpmic1_wdt {
> +	struct stpmic1_dev *pmic;
> +	struct watchdog_device wdtdev;
> +};
> +
> +static int pmic_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return regmap_update_bits(wdt->pmic->regmap,
> +				  WCHDG_CR, WDT_START_MASK, WDT_START);
> +}
> +
> +static int pmic_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return regmap_update_bits(wdt->pmic->regmap,
> +				  WCHDG_CR, WDT_START_MASK, ~WDT_START);
> +}
> +
> +static int pmic_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return regmap_update_bits(wdt->pmic->regmap,
> +				  WCHDG_CR, WDT_PING_MASK, WDT_PING);
> +}
> +
> +static int pmic_wdt_set_timeout(struct watchdog_device *wdd,
> +				unsigned int timeout)
> +{
> +	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return regmap_write(wdt->pmic->regmap, WCHDG_TIMER_CR, timeout - 1);

What happens if the configured timeout is 1 ? Does that translate to a 1-second
timeout ?

This function also has to set wdd->timeout.

> +}
> +
> +static const struct watchdog_info pmic_watchdog_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,

No WDIOF_MAGICCLOSE ?

> +	.identity = "STPMIC1 PMIC Watchdog",
> +};
> +
> +static const struct watchdog_ops pmic_watchdog_ops = {
> +	.owner = THIS_MODULE,
> +	.start = pmic_wdt_start,
> +	.stop = pmic_wdt_stop,
> +	.ping = pmic_wdt_ping,
> +	.set_timeout = pmic_wdt_set_timeout,
> +};
> +
> +static int pmic_wdt_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct stpmic1_dev *pmic;
> +	struct stpmic1_wdt *wdt;
> +
> +	if (!pdev->dev.parent)
> +		return -EINVAL;
> +
> +	pmic = dev_get_drvdata(pdev->dev.parent);
> +	if (!pmic)
> +		return -EINVAL;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(struct stpmic1_wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->pmic = pmic;
> +
> +	wdt->wdtdev.info = &pmic_watchdog_info;
> +	wdt->wdtdev.ops = &pmic_watchdog_ops;
> +	wdt->wdtdev.min_timeout = PMIC_WDT_MIN_TIMEOUT;
> +	wdt->wdtdev.max_timeout = PMIC_WDT_MAX_TIMEOUT;
> +	wdt->wdtdev.timeout = PMIC_WDT_MIN_TIMEOUT;

Are you sure about that ? A timeout of 1 second may be a cause for unexpected
reboots if user space is busy. Personally I find it better to set a larger
default and let userspace configure a tighter value if so desired.

Also,
	watchdog_init_timeout(&wdt->wdtdev, 0, &pdev->dev);
might be desirable if you want to be able to specify the timeout in the
devicetree file.


> +
> +	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
> +
> +	watchdog_set_drvdata(&wdt->wdtdev, wdt);
> +	dev_set_drvdata(&pdev->dev, wdt);

Unless I am missing something this should not be needed.

> +
> +	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdtdev);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(wdt->pmic->dev, "PMIC Watchdog driver probed\n");
> +	return 0;
> +}
> +
> +static const struct of_device_id of_pmic_wdt_match[] = {
> +	{ .compatible = "st,stpmic1-wdt" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, of_pmic_wdt_match);
> +
> +static struct platform_driver stpmic1_wdt_driver = {
> +	.probe = pmic_wdt_probe,
> +	.driver = {
> +		.name = "stpmic1-wdt",
> +		.of_match_table = of_pmic_wdt_match,
> +	},
> +};
> +module_platform_driver(stpmic1_wdt_driver);
> +
> +MODULE_DESCRIPTION("Watchdog driver for STPMIC1 device");
> +MODULE_AUTHOR("Pascal Paillet");
> +MODULE_LICENSE("GPL v2");
> 

From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 2/8] mfd: stpmic1: add stpmic1 driver
Date: Tue, 13 Nov 2018 07:40:37 +0000
Message-ID: <20181113074037.GC29388@dell>
References: <1540830122-2577-1-git-send-email-p.paillet@st.com>
 <1540830122-2577-3-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1540830122-2577-3-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "axel.lin@ingics.com" <axel.lin@ingics.com>
List-Id: linux-input@vger.kernel.org

On Mon, 29 Oct 2018, Pascal PAILLET-LME wrote:

> stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10

"STPMIC1 is a PMIC"

> regulators, 3 power switches, a watchdog and an input for a power on key.
> 
> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> ---
> changes in v5:
> * use macro to define regmap register ranges
> * use REGMAP_IRQ_REG marco to define interrupts
> * remove st properties
> 
>  drivers/mfd/Kconfig         |  13 +++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/stpmic1.c       | 215 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stpmic1.h | 212 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 444 insertions(+)
>  create mode 100644 drivers/mfd/stpmic1.c
>  create mode 100644 include/linux/mfd/stpmic1.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 11841f4..07e39a6 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1855,6 +1855,22 @@ config MFD_STM32_TIMERS
>  	  for PWM and IIO Timer. This driver allow to share the
>  	  registers between the others drivers.
>  
> +config MFD_STPMIC1
> +	tristate "Support for STPMIC1 PMIC"
> +	depends on (I2C=y && OF)
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	select MFD_CORE
> +	help
> +	  Support for ST Microelectronics STPMIC1 PMIC. STPMIC1 has power on
> +	  key, watchdog and regulator functionalities which are supported via
> +	  the relevant subsystems.  This driver provides core support for the
> +	  STPMIC1, in order to use the actual functionaltiy of the device other

s/,/./

> +	  drivers must be enabled.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called stpmic1.
> +
>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
>  
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 5856a94..76fff14 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -232,6 +232,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
>  obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
>  
>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
> +obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
>  obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
>  
>  obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
> diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
> new file mode 100644
> index 0000000..2f4fd5e
> --- /dev/null
> +++ b/drivers/mfd/stpmic1.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) STMicroelectronics 2018
> +// Author: Pascal Paillet <p.paillet@st.com>
> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/stpmic1.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_wakeirq.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/mfd/st,stpmic1.h>
> +
> +#define STPMIC1_MAIN_IRQ 0
> +
> +static const struct regmap_range stpmic1_readable_ranges[] = {
> +	regmap_reg_range(TURN_ON_SR, VERSION_SR),
> +	regmap_reg_range(SWOFF_PWRCTRL_CR, LDO6_STDBY_CR),
> +	regmap_reg_range(BST_SW_CR, BST_SW_CR),
> +	regmap_reg_range(INT_PENDING_R1, INT_PENDING_R4),
> +	regmap_reg_range(INT_CLEAR_R1, INT_CLEAR_R4),
> +	regmap_reg_range(INT_MASK_R1, INT_MASK_R4),
> +	regmap_reg_range(INT_SET_MASK_R1, INT_SET_MASK_R4),
> +	regmap_reg_range(INT_CLEAR_MASK_R1, INT_CLEAR_MASK_R4),
> +	regmap_reg_range(INT_SRC_R1, INT_SRC_R1),
> +};
> +
> +static const struct regmap_range stpmic1_writeable_ranges[] = {
> +	regmap_reg_range(SWOFF_PWRCTRL_CR, LDO6_STDBY_CR),
> +	regmap_reg_range(BST_SW_CR, BST_SW_CR),
> +	regmap_reg_range(INT_CLEAR_R1, INT_CLEAR_R4),
> +	regmap_reg_range(INT_SET_MASK_R1, INT_SET_MASK_R4),
> +	regmap_reg_range(INT_CLEAR_MASK_R1, INT_CLEAR_MASK_R4),
> +};
> +
> +static const struct regmap_range stpmic1_volatile_ranges[] = {
> +	regmap_reg_range(TURN_ON_SR, VERSION_SR),
> +	regmap_reg_range(WCHDG_CR, WCHDG_CR),
> +	regmap_reg_range(INT_PENDING_R1, INT_PENDING_R4),
> +	regmap_reg_range(INT_SRC_R1, INT_SRC_R4),
> +};

Nice!

> +static const struct regmap_access_table stpmic1_readable_table = {
> +	.yes_ranges = stpmic1_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(stpmic1_readable_ranges),
> +};
> +
> +static const struct regmap_access_table stpmic1_writeable_table = {
> +	.yes_ranges = stpmic1_writeable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(stpmic1_writeable_ranges),
> +};
> +
> +static const struct regmap_access_table stpmic1_volatile_table = {
> +	.yes_ranges = stpmic1_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(stpmic1_volatile_ranges),
> +};
> +
> +const struct regmap_config stpmic1_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_RBTREE,
> +	.max_register = PMIC_MAX_REGISTER_ADDRESS,
> +	.rd_table = &stpmic1_readable_table,
> +	.wr_table = &stpmic1_writeable_table,
> +	.volatile_table = &stpmic1_volatile_table,
> +};
> +
> +static const struct regmap_irq stpmic1_irqs[] = {
> +	REGMAP_IRQ_REG(IT_PONKEY_F, 0, 0x01),
> +	REGMAP_IRQ_REG(IT_PONKEY_R, 0, 0x02),
> +	REGMAP_IRQ_REG(IT_WAKEUP_F, 0, 0x04),
> +	REGMAP_IRQ_REG(IT_WAKEUP_R, 0, 0x08),
> +	REGMAP_IRQ_REG(IT_VBUS_OTG_F, 0, 0x10),
> +	REGMAP_IRQ_REG(IT_VBUS_OTG_R, 0, 0x20),
> +	REGMAP_IRQ_REG(IT_SWOUT_F, 0, 0x40),
> +	REGMAP_IRQ_REG(IT_SWOUT_R, 0, 0x80),
> +
> +	REGMAP_IRQ_REG(IT_CURLIM_BUCK1, 1, 0x01),
> +	REGMAP_IRQ_REG(IT_CURLIM_BUCK2, 1, 0x02),
> +	REGMAP_IRQ_REG(IT_CURLIM_BUCK3, 1, 0x04),
> +	REGMAP_IRQ_REG(IT_CURLIM_BUCK4, 1, 0x08),
> +	REGMAP_IRQ_REG(IT_OCP_OTG, 1, 0x10),
> +	REGMAP_IRQ_REG(IT_OCP_SWOUT, 1, 0x20),
> +	REGMAP_IRQ_REG(IT_OCP_BOOST, 1, 0x40),
> +	REGMAP_IRQ_REG(IT_OVP_BOOST, 1, 0x80),
> +
> +	REGMAP_IRQ_REG(IT_CURLIM_LDO1, 2, 0x01),
> +	REGMAP_IRQ_REG(IT_CURLIM_LDO2, 2, 0x02),
> +	REGMAP_IRQ_REG(IT_CURLIM_LDO3, 2, 0x04),
> +	REGMAP_IRQ_REG(IT_CURLIM_LDO4, 2, 0x08),
> +	REGMAP_IRQ_REG(IT_CURLIM_LDO5, 2, 0x10),
> +	REGMAP_IRQ_REG(IT_CURLIM_LDO6, 2, 0x20),
> +	REGMAP_IRQ_REG(IT_SHORT_SWOTG, 2, 0x40),
> +	REGMAP_IRQ_REG(IT_SHORT_SWOUT, 2, 0x80),
> +
> +	REGMAP_IRQ_REG(IT_TWARN_F, 3, 0x01),
> +	REGMAP_IRQ_REG(IT_TWARN_R, 3, 0x02),
> +	REGMAP_IRQ_REG(IT_VINLOW_F, 3, 0x04),
> +	REGMAP_IRQ_REG(IT_VINLOW_R, 3, 0x08),
> +	REGMAP_IRQ_REG(IT_SWIN_F, 3, 0x40),
> +	REGMAP_IRQ_REG(IT_SWIN_R, 3, 0x80),
> +};
> +
> +static const struct regmap_irq_chip stpmic1_regmap_irq_chip = {
> +	.name = "pmic_irq",
> +	.status_base = INT_PENDING_R1,
> +	.mask_base = INT_CLEAR_MASK_R1,
> +	.unmask_base = INT_SET_MASK_R1,
> +	.ack_base = INT_CLEAR_R1,
> +	.num_regs = STPMIC1_PMIC_NUM_IRQ_REGS,
> +	.irqs = stpmic1_irqs,
> +	.num_irqs = ARRAY_SIZE(stpmic1_irqs),
> +};
> +
> +static int stpmic1_probe(struct i2c_client *i2c,
> +			 const struct i2c_device_id *id)
> +{
> +	struct stpmic1 *ddata;
> +	struct device *dev = &i2c->dev;
> +	int ret;
> +	struct device_node *np = dev->of_node;
> +	u32 reg;
> +
> +	ddata = devm_kzalloc(dev, sizeof(struct stpmic1), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, ddata);
> +	ddata->dev = dev;
> +
> +	ddata->regmap = devm_regmap_init_i2c(i2c, &stpmic1_regmap_config);
> +	if (IS_ERR(ddata->regmap))
> +		return PTR_ERR(ddata->regmap);
> +
> +	ddata->irq = of_irq_get(np, STPMIC1_MAIN_IRQ);
> +	if (ddata->irq < 0) {
> +		dev_err(dev, "Failed to get main IRQ: %d\n", ddata->irq);
> +		return ddata->irq;
> +	}
> +
> +	/* Read Version ID */

I think the MACRO name and error message make this comment
superfluous.

> +	ret = regmap_read(ddata->regmap, VERSION_SR, &reg);
> +	if (ret) {
> +		dev_err(dev, "Unable to read pmic version\n");

"PMIC"

> +		return ret;
> +	}
> +	dev_info(dev, "PMIC Chip Version: 0x%x\n", reg);
> +
> +	/* Initialize PMIC IRQ Chip & IRQ domains associated */

"associated IRQ domains"

> +	ret = devm_regmap_add_irq_chip(dev, ddata->regmap, ddata->irq,
> +				       IRQF_ONESHOT | IRQF_SHARED,
> +				       0, &stpmic1_regmap_irq_chip,
> +				       &ddata->irq_data);
> +	if (ret) {
> +		dev_err(dev, "IRQ Chip registration failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return devm_of_platform_populate(dev);
> +}
> +
> +static const struct i2c_device_id stpmic1_id[] = {
> +	{ "stpmic1"},
> +	{}
> +};

I don't think this is required any more.

> +MODULE_DEVICE_TABLE(i2c, stpmic1_id);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

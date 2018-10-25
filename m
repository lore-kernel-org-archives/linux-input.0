From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/8] mfd: stpmic1: add stpmic1 driver
Date: Thu, 25 Oct 2018 12:21:56 +0100
Message-ID: <20181025112156.GB4870@dell>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-3-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539853324-29051-3-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>
List-Id: linux-input@vger.kernel.org

On Thu, 18 Oct 2018, Pascal PAILLET-LME wrote:

> From: pascal paillet <p.paillet@st.com>
> 
> stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10
> regulators , 3 switches, a watchdog and an input for a power on key.

Same comments as for the DT binding patch.

> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v4:
> * rename PONKEY_PU_ACTIVE to PONKEY_PU_INACTIVE
> 
>  drivers/mfd/Kconfig         |  13 ++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/stpmic1.c       | 401 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stpmic1.h | 212 +++++++++++++++++++++++
>  4 files changed, 627 insertions(+)
>  create mode 100644 drivers/mfd/stpmic1.c
>  create mode 100644 include/linux/mfd/stpmic1.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 11841f4..b8dabc7 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1855,6 +1855,19 @@ config MFD_STM32_TIMERS
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
> +	  Support for ST Microelectronics STPMIC1 PMIC. STPMIC1 MFD driver is

Remove 'MFD' and replace with something else.

MFD is not a real thing.  It's a Linuxisum.

> +	  the core driver for STPMIC1 component that mainly handles interrupts.

You need to document what the child devices are.

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
> index 0000000..90dfee4
> --- /dev/null
> +++ b/drivers/mfd/stpmic1.c
> @@ -0,0 +1,401 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) STMicroelectronics 2018

'\n' here.

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
> +#define STPMIC1_WAKEUP_IRQ 1
> +
> +static bool stpmic1_reg_readable(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case TURN_ON_SR:
> +	case TURN_OFF_SR:
> +	case ICC_LDO_TURN_OFF_SR:
> +	case ICC_BUCK_TURN_OFF_SR:
> +	case RREQ_STATE_SR:
> +	case VERSION_SR:
> +	case SWOFF_PWRCTRL_CR:
> +	case PADS_PULL_CR:
> +	case BUCKS_PD_CR:
> +	case LDO14_PD_CR:
> +	case LDO56_VREF_PD_CR:
> +	case VBUS_DET_VIN_CR:
> +	case PKEY_TURNOFF_CR:
> +	case BUCKS_MASK_RANK_CR:
> +	case BUCKS_MASK_RESET_CR:
> +	case LDOS_MASK_RANK_CR:
> +	case LDOS_MASK_RESET_CR:
> +	case WCHDG_CR:
> +	case WCHDG_TIMER_CR:
> +	case BUCKS_ICCTO_CR:
> +	case LDOS_ICCTO_CR:
> +	case BUCK1_ACTIVE_CR:
> +	case BUCK2_ACTIVE_CR:
> +	case BUCK3_ACTIVE_CR:
> +	case BUCK4_ACTIVE_CR:
> +	case VREF_DDR_ACTIVE_CR:
> +	case LDO1_ACTIVE_CR:
> +	case LDO2_ACTIVE_CR:
> +	case LDO3_ACTIVE_CR:
> +	case LDO4_ACTIVE_CR:
> +	case LDO5_ACTIVE_CR:
> +	case LDO6_ACTIVE_CR:
> +	case BUCK1_STDBY_CR:
> +	case BUCK2_STDBY_CR:
> +	case BUCK3_STDBY_CR:
> +	case BUCK4_STDBY_CR:
> +	case VREF_DDR_STDBY_CR:
> +	case LDO1_STDBY_CR:
> +	case LDO2_STDBY_CR:
> +	case LDO3_STDBY_CR:
> +	case LDO4_STDBY_CR:
> +	case LDO5_STDBY_CR:
> +	case LDO6_STDBY_CR:
> +	case BST_SW_CR:
> +	case INT_PENDING_R1:
> +	case INT_PENDING_R2:
> +	case INT_PENDING_R3:
> +	case INT_PENDING_R4:
> +	case INT_DBG_LATCH_R1:
> +	case INT_DBG_LATCH_R2:
> +	case INT_DBG_LATCH_R3:
> +	case INT_DBG_LATCH_R4:
> +	case INT_CLEAR_R1:
> +	case INT_CLEAR_R2:
> +	case INT_CLEAR_R3:
> +	case INT_CLEAR_R4:
> +	case INT_MASK_R1:
> +	case INT_MASK_R2:
> +	case INT_MASK_R3:
> +	case INT_MASK_R4:
> +	case INT_SET_MASK_R1:
> +	case INT_SET_MASK_R2:
> +	case INT_SET_MASK_R3:
> +	case INT_SET_MASK_R4:
> +	case INT_CLEAR_MASK_R1:
> +	case INT_CLEAR_MASK_R2:
> +	case INT_CLEAR_MASK_R3:
> +	case INT_CLEAR_MASK_R4:
> +	case INT_SRC_R1:
> +	case INT_SRC_R2:
> +	case INT_SRC_R3:
> +	case INT_SRC_R4:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool stpmic1_reg_writeable(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case SWOFF_PWRCTRL_CR:
> +	case PADS_PULL_CR:
> +	case BUCKS_PD_CR:
> +	case LDO14_PD_CR:
> +	case LDO56_VREF_PD_CR:
> +	case VBUS_DET_VIN_CR:
> +	case PKEY_TURNOFF_CR:
> +	case BUCKS_MASK_RANK_CR:
> +	case BUCKS_MASK_RESET_CR:
> +	case LDOS_MASK_RANK_CR:
> +	case LDOS_MASK_RESET_CR:
> +	case WCHDG_CR:
> +	case WCHDG_TIMER_CR:
> +	case BUCKS_ICCTO_CR:
> +	case LDOS_ICCTO_CR:
> +	case BUCK1_ACTIVE_CR:
> +	case BUCK2_ACTIVE_CR:
> +	case BUCK3_ACTIVE_CR:
> +	case BUCK4_ACTIVE_CR:
> +	case VREF_DDR_ACTIVE_CR:
> +	case LDO1_ACTIVE_CR:
> +	case LDO2_ACTIVE_CR:
> +	case LDO3_ACTIVE_CR:
> +	case LDO4_ACTIVE_CR:
> +	case LDO5_ACTIVE_CR:
> +	case LDO6_ACTIVE_CR:
> +	case BUCK1_STDBY_CR:
> +	case BUCK2_STDBY_CR:
> +	case BUCK3_STDBY_CR:
> +	case BUCK4_STDBY_CR:
> +	case VREF_DDR_STDBY_CR:
> +	case LDO1_STDBY_CR:
> +	case LDO2_STDBY_CR:
> +	case LDO3_STDBY_CR:
> +	case LDO4_STDBY_CR:
> +	case LDO5_STDBY_CR:
> +	case LDO6_STDBY_CR:
> +	case BST_SW_CR:
> +	case INT_DBG_LATCH_R1:
> +	case INT_DBG_LATCH_R2:
> +	case INT_DBG_LATCH_R3:
> +	case INT_DBG_LATCH_R4:
> +	case INT_CLEAR_R1:
> +	case INT_CLEAR_R2:
> +	case INT_CLEAR_R3:
> +	case INT_CLEAR_R4:
> +	case INT_SET_MASK_R1:
> +	case INT_SET_MASK_R2:
> +	case INT_SET_MASK_R3:
> +	case INT_SET_MASK_R4:
> +	case INT_CLEAR_MASK_R1:
> +	case INT_CLEAR_MASK_R2:
> +	case INT_CLEAR_MASK_R3:
> +	case INT_CLEAR_MASK_R4:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool stpmic1_reg_volatile(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case TURN_ON_SR:
> +	case TURN_OFF_SR:
> +	case ICC_LDO_TURN_OFF_SR:
> +	case ICC_BUCK_TURN_OFF_SR:
> +	case RREQ_STATE_SR:
> +	case INT_PENDING_R1:
> +	case INT_PENDING_R2:
> +	case INT_PENDING_R3:
> +	case INT_PENDING_R4:
> +	case INT_SRC_R1:
> +	case INT_SRC_R2:
> +	case INT_SRC_R3:
> +	case INT_SRC_R4:
> +	case WCHDG_CR:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

Can you use ranges for all of these?

> +const struct regmap_config stpmic1_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_RBTREE,
> +	.max_register = PMIC_MAX_REGISTER_ADDRESS,
> +	.readable_reg = stpmic1_reg_readable,
> +	.writeable_reg = stpmic1_reg_writeable,
> +	.volatile_reg = stpmic1_reg_volatile,
> +};
> +
> +static const struct regmap_irq stpmic1_irqs[] = {
> +	[IT_PONKEY_F]		= { .mask = 0x01 },
> +	[IT_PONKEY_R]		= { .mask = 0x02 },
> +	[IT_WAKEUP_F]		= { .mask = 0x04 },
> +	[IT_WAKEUP_R]		= { .mask = 0x08 },
> +	[IT_VBUS_OTG_F]		= { .mask = 0x10 },
> +	[IT_VBUS_OTG_R]		= { .mask = 0x20 },
> +	[IT_SWOUT_F]		= { .mask = 0x40 },
> +	[IT_SWOUT_R]		= { .mask = 0x80 },
> +
> +	[IT_CURLIM_BUCK1]	= { .reg_offset = 1, .mask = 0x01 },
> +	[IT_CURLIM_BUCK2]	= { .reg_offset = 1, .mask = 0x02 },
> +	[IT_CURLIM_BUCK3]	= { .reg_offset = 1, .mask = 0x04 },
> +	[IT_CURLIM_BUCK4]	= { .reg_offset = 1, .mask = 0x08 },
> +	[IT_OCP_OTG]		= { .reg_offset = 1, .mask = 0x10 },
> +	[IT_OCP_SWOUT]		= { .reg_offset = 1, .mask = 0x20 },
> +	[IT_OCP_BOOST]		= { .reg_offset = 1, .mask = 0x40 },
> +	[IT_OVP_BOOST]		= { .reg_offset = 1, .mask = 0x80 },
> +
> +	[IT_CURLIM_LDO1]	= { .reg_offset = 2, .mask = 0x01 },
> +	[IT_CURLIM_LDO2]	= { .reg_offset = 2, .mask = 0x02 },
> +	[IT_CURLIM_LDO3]	= { .reg_offset = 2, .mask = 0x04 },
> +	[IT_CURLIM_LDO4]	= { .reg_offset = 2, .mask = 0x08 },
> +	[IT_CURLIM_LDO5]	= { .reg_offset = 2, .mask = 0x10 },
> +	[IT_CURLIM_LDO6]	= { .reg_offset = 2, .mask = 0x20 },
> +	[IT_SHORT_SWOTG]	= { .reg_offset = 2, .mask = 0x40 },
> +	[IT_SHORT_SWOUT]	= { .reg_offset = 2, .mask = 0x80 },
> +
> +	[IT_TWARN_F]		= { .reg_offset = 3, .mask = 0x01 },
> +	[IT_TWARN_R]		= { .reg_offset = 3, .mask = 0x02 },
> +	[IT_VINLOW_F]		= { .reg_offset = 3, .mask = 0x04 },
> +	[IT_VINLOW_R]		= { .reg_offset = 3, .mask = 0x08 },
> +	[IT_SWIN_F]		= { .reg_offset = 3, .mask = 0x40 },
> +	[IT_SWIN_R]		= { .reg_offset = 3, .mask = 0x80 },
> +};

There should be a MACRO for doing this.

If there isn't, you should author one and put it in the Regmap header.

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
> +	if (!of_property_read_u32(np, "st,main-control-register", &reg)) {

I'm still waiting on feedback from Rob as to whether this is
acceptable.  I suggest that it isn't.

> +		ret = regmap_update_bits(ddata->regmap,
> +					 SWOFF_PWRCTRL_CR,
> +					 PWRCTRL_POLARITY_HIGH |
> +					 PWRCTRL_PIN_VALID |
> +					 RESTART_REQUEST_ENABLED,
> +					 reg);
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed to update main control register: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	/* Read Version ID */
> +	ret = regmap_read(ddata->regmap, VERSION_SR, &reg);
> +	if (ret) {
> +		dev_err(dev, "Unable to read pmic version\n");

"PMIC"

> +		return ret;
> +	}
> +	dev_info(dev, "PMIC Chip Version: 0x%x\n", reg);

[...]

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

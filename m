Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26347A0DC
	for <linux-input@vger.kernel.org>; Thu,  7 May 2026 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181965; cv=none; b=Ry7J00F5/qP9XNrHOzrewZ8cQ+s2XgQjYq6zMCojP/w9CnF3Y+0ajzxWOkbgsOhevLwNDE8mxtJWXjX+XgMIABWwgK2b3tqCvW2M4YHAR01oncyPp3g/DKbMPHxm9OPGDl+S8zfolDikgBEks5yN9JC2E7ApU/JIbTKARyZGm30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181965; c=relaxed/simple;
	bh=dT0urRuov7dtyuwkosF5iahzIGppZ1yfYLFJQDHPYlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR+9T7I11wmoD4TgiKrlieD3HyyWTcOyhmDFyMFWLlx1KO5ys9rHr+OSwoWWJmWqRx5GssGdsfH5CtKyZ11llhEI5iHd4SoRzlLFfLgAErw79h4mgeV+Ttuya0UkoFSkWR+B+6EsW8je+G5mGGixay5cnZjQ2ngbqXqVTkWMDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3twtOGI; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3twtOGI"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so653318eec.0
        for <linux-input@vger.kernel.org>; Thu, 07 May 2026 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778181960; x=1778786760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mAvCtvyE5zxgP8jXFXdJfsusiJQSW5cUbcGYUjn/lEc=;
        b=f3twtOGIxpiSPPPx2Z0UmJyHHOk/cOgF3cOso9sKz35Aq+HJEBg/65cJJVy1y4ylO8
         +rKy51gPQ8OO3M7Zpi+VzEmtpxZg1g/fGYV1sppEmFQcHBo9QDCMDEzzdWk00hUzP6nI
         Zy1HNh9RXVzjC9gWeAbrAgilKwlggNc2M56v/0ukz/HD/jSdxZYnyqiqqG+9SM2+vBH1
         rTH/mmfA+r10w8YTRrQGvUYtyl74Kr4Nmbyh0prqd9CHUX6dSgzQjnKynknxJEZ+M/sf
         GDWIeCzPe7h4iOlG4f7X6aNJTibHhXEQPcYm3h6quBdO3HfuLIdGKhptIoAQZOZfLFC7
         V6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778181960; x=1778786760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAvCtvyE5zxgP8jXFXdJfsusiJQSW5cUbcGYUjn/lEc=;
        b=fGF1hCwK/yG6BCE8o2iyzKfPHKzsR32Igu1fIuasf6VEHbkaNeu1vNiT2JjqeE41jX
         GInRaL8AFPw9Gx/0nJhZEIkwyhNfn0JHW//0BcJz+8jNE6TArpgCPIH3BrIvmF8h1Cks
         tiwZeC0yZBFNB205DZR2JzL96dO/ItxRieZ37wmCQY1w/kOZmH6Pl9Ie+8iTc6Hxf9fu
         evdhJvjjCusfVvYJ5XYtG7pKbUggOIigbLc4Y+sC4Ehpqs8Xd5CX/gLAEmtR2BYP3CLt
         FrDkQZ9YdMA+aeSHZz71Yay+pe56AUkwarQ+kp6W8xpS8vkOqTegw6V94ss2Z0EN6ThV
         +1pQ==
X-Forwarded-Encrypted: i=1; AFNElJ/v6jwn0yqvOIW0YMk0ZDK6iBSlwLU99KewWX4zwcpK/SrGkyj5f0aP+k99zVozJVNkludNJWsn1apVDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKBg2tNAgWy8eOzsXCGgGiKWjTrmaK/MwZ7yYjKX3M1LLeis5P
	iLE/NuFj60CrRFMh0t1HbyOT6bJ8oWiPYTNpl/BW8mRZX8ZejsFw6gf4
X-Gm-Gg: Acq92OEPHlkYy8Ap7sCMcwelN35ANcAG2f+1Ouz+TanebRD9FEYVdCYMvF16nl7B2YX
	wiOxbRfzZILnCiOanKOzIMaZ2yfx/LWIdA+ZX9scwSDsZK7JAuOIHysfObbebACqiLSbSrbBsMM
	j7FP5BXGfJ2askJSzOBetACMd43PmTSiBO2GNFzONLZ4qX3UnDfuCwE/vjh2ZoQ9kb4024H+Obh
	SzTWPxebPDvUiaI5+xBd7zFNJdzZPZMbnjI/O1xj5Cco/qYHz9EaTrgIZy0raPziv8n2PjJDvr1
	gTrVJ2FJVCrCe/xr9IHPCV2WFy+tqChnRq5fxxGTCYZdL4KqrOP8dYQectfqB35Y3cijsCX65nD
	9Qh3vJ9Z9QYNGE2SOZxg+i7hUshXczUlxF+093qkeF8NNfSJIHjzxLLMtRGofYuK8m57zwUFOEb
	o6PoevI7sPAmb00l25EfprPDkjGTGFka0n89O8Dt0L68uhDZqY+zo5d0wpqS1PJpqhnVzzAoa7O
	vU=
X-Received: by 2002:a05:7300:df4b:b0:2d2:129a:1694 with SMTP id 5a478bee46e88-2f54d79b993mr4481271eec.18.1778181959761;
        Thu, 07 May 2026 12:25:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6a50:9473:7750:56ef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f82c06a638sm418484eec.13.2026.05.07.12.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:25:59 -0700 (PDT)
Date: Thu, 7 May 2026 12:25:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Input: isa1200 - new driver for Imagis ISA1200
Message-ID: <afzJUcvQth6v9KGC@google.com>
References: <20260507133948.75704-1-clamor95@gmail.com>
 <20260507133948.75704-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507133948.75704-3-clamor95@gmail.com>

Hi Svyatoslav,

On Thu, May 07, 2026 at 04:39:48PM +0300, Svyatoslav Ryhel wrote:
> From: Linus Walleij <linusw@kernel.org>
> 
> The ISA1200 is a haptic feedback unit from Imagis Technology using two
> motors for haptic feedback in mobile phones. Used in many mobile devices
> c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsung Beam
> GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.
> 
> The exact datasheet for the ISA1200 is not available; all data was modeled
> based on available downstream kernel sources for various devices and
> fragments of information scattered across the internet.
> 
> Tested-by: Linus Walleij <linusw@kernel.org> # GT-I9070 Janice
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/input/misc/Kconfig   |  12 +
>  drivers/input/misc/Makefile  |   1 +
>  drivers/input/misc/isa1200.c | 540 +++++++++++++++++++++++++++++++++++
>  3 files changed, 553 insertions(+)
>  create mode 100644 drivers/input/misc/isa1200.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 94a753fcb64f..52f192104ee2 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -852,6 +852,18 @@ config INPUT_IQS7222
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called iqs7222.
>  
> +config INPUT_ISA1200_HAPTIC
> +	tristate "Imagis ISA1200 haptic feedback unit"
> +	depends on I2C
> +	select INPUT_FF_MEMLESS
> +	select REGMAP_I2C
> +	help
> +	  Say Y to enable support for the Imagis ISA1200 haptic
> +	  feedback unit.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called isa1200.
> +
>  config INPUT_CMA3000
>  	tristate "VTI CMA3000 Tri-axis accelerometer"
>  	help
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 415fc4e2918b..d62bf2e9d85f 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -49,6 +49,7 @@ obj-$(CONFIG_INPUT_IMS_PCU)		+= ims-pcu.o
>  obj-$(CONFIG_INPUT_IQS269A)		+= iqs269a.o
>  obj-$(CONFIG_INPUT_IQS626A)		+= iqs626a.o
>  obj-$(CONFIG_INPUT_IQS7222)		+= iqs7222.o
> +obj-$(CONFIG_INPUT_ISA1200_HAPTIC)	+= isa1200.o
>  obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
>  obj-$(CONFIG_INPUT_KXTJ9)		+= kxtj9.o
>  obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
> diff --git a/drivers/input/misc/isa1200.c b/drivers/input/misc/isa1200.c
> new file mode 100644
> index 000000000000..f8dba8a95c7d
> --- /dev/null
> +++ b/drivers/input/misc/isa1200.c
> @@ -0,0 +1,540 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/array_size.h>
> +#include <linux/bitmap.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/devm-helpers.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/units.h>
> +
> +/*
> + * System control (LDO regulator)
> + *
> + * LDO voltage to register mapping is linear, but it is split in two parts:
> + * 2.3V - 3.0V map to 0x08 - 0x0f; 3.1V - 3.8V map to 0x00 - 0x7
> + */
> +
> +#define ISA1200_SCTRL			0x00
> +#define ISA1200_LDO_VOLTAGE_BASE	0x08
> +#define ISA1200_LDO_VOLTAGE_STEP	100000
> +#define ISA1200_LDO_VOLTAGE_2V3		23
> +#define ISA1200_LDO_VOLTAGE_3V1		31
> +#define ISA1200_LDO_VOLTAGE_MIN		2300000
> +#define ISA1200_LDO_VOLTAGE_MAX		3800000
> +
> +/*
> + * The output frequency is calculated with this formula:
> + *
> + *                 base clock frequency
> + * fout = -----------------------------------------
> + *        (128 - PWM_FREQ) * 2 * PLLDIV * PWM_PERIOD
> + *
> + * The base clock frequency is the clock frequency provided on the
> + * clock input to the chip, divided by the value in HCTRL0
> + *
> + * PWM_FREQ is configured in register HCTRL4, it is common to set this
> + * to 0 to get only two variables to calculate.
> + *
> + * PLLDIV is configured in register HCTRL3 (bits 7..4, so 0..15)
> + * PWM_PERIOD is configured in register HCTRL6
> + * Further the duty cycle can be configured in HCTRL5
> + */
> +
> +/*
> + * HCTRL0 configures clock or PWM input and selects the divider for
> + * the clock input.
> + */
> +#define ISA1200_HCTRL0			0x30
> +#define ISA1200_HCTRL0_HAP_ENABLE	BIT(7)
> +#define ISA1200_HCTRL0_PWM_GEN_MODE	BIT(4)
> +#define ISA1200_HCTRL0_PWM_INPUT_MODE	BIT(3)
> +#define ISA1200_HCTRL0_CLKDIV_128	128
> +
> +/*
> + * HCTRL1 configures the motor type and clock sourse
> + */
> +#define ISA1200_HCTRL1			0x31
> +#define ISA1200_HCTRL1_EXT_CLOCK	BIT(7)
> +#define ISA1200_HCTRL1_DAC_INVERT	BIT(6)
> +#define ISA1200_HCTRL1_MODE(n)		(((n) & 1) << 5)

I wonder if this should simply be BIT(5) and you conditionally use it in
the code. The macro is not really usable to disable the setting...

> +
> +/* HCTRL2 controls software reset of the chip */
> +#define ISA1200_HCTRL2			0x32
> +#define ISA1200_HCTRL2_SW_RESET		BIT(0)
> +
> +/*
> + * HCTRL3 controls the PLL divisor
> + *
> + * Bits [0,1] are always set to 1 (we don't know what they are
> + * used for) and bit 4 and upward control the PLL divisor.
> + */
> +#define ISA1200_HCTRL3			0x33
> +#define ISA1200_HCTRL3_DEFAULT		0x03
> +#define ISA1200_HCTRL3_PLLDIV(n)	(((n) & 0xf) << 4)
> +
> +/* HCTRL4 controls the PWM frequency of external channel */
> +#define ISA1200_HCTRL4			0x34
> +
> +/* HCTRL5 controls the PWM high duty cycle of internal channel */
> +#define ISA1200_HCTRL5			0x35
> +
> +/* HCTRL6 controls the PWM period of internal channel */
> +#define ISA1200_HCTRL6			0x36
> +#define ISA1200_HCTRL6_PERIOD_SCALE	100
> +
> +/* The use for these registers is unknown but they exist */
> +#define ISA1200_HCTRL7			0x37
> +#define ISA1200_HCTRL8			0x38
> +#define ISA1200_HCTRL9			0x39
> +#define ISA1200_HCTRLA			0x3a
> +#define ISA1200_HCTRLB			0x3b
> +#define ISA1200_HCTRLC			0x3c
> +#define ISA1200_HCTRLD			0x3d
> +
> +#define ISA1200_EN_PINS_MAX		2
> +
> +struct isa1200_config {
> +	u32 ldo_voltage;
> +	u32 mode;
> +	u32 clkdiv;
> +	u32 plldiv;
> +	u32 freq;
> +	u32 period;
> +	u32 duty;
> +};
> +
> +struct isa1200 {
> +	struct input_dev *input;
> +	struct regmap *map;
> +
> +	struct clk *clk;
> +	struct pwm_device *pwm;
> +	struct gpio_descs *enable_gpios;
> +
> +	struct work_struct play_work;
> +	struct isa1200_config config;
> +
> +	int level;
> +	bool clk_on;

I think you need not only clk_on, but general "active" flag that you
would set at the end of isa1200_start().

> +};
> +
> +static const struct regmap_config isa1200_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = ISA1200_HCTRLD,
> +};
> +
> +static void isa1200_start(struct isa1200 *isa)
> +{
> +	struct isa1200_config *config = &isa->config;
> +	struct pwm_state state;
> +	u8 hctrl0 = 0, hctrl1 = 0;
> +	DECLARE_BITMAP(values, ISA1200_EN_PINS_MAX);
> +	int ret;

Please use "error" or "err" for all variables that only hold error codes
(or 0) instead of a real value that is used for something.

> +
> +	if (!isa->clk_on) {
> +		ret = clk_prepare_enable(isa->clk);

This return 0 on success so

		if (error)
			return;

> +		if (ret < 0)
> +			return;
> +
> +		isa->clk_on = true;
> +	}
> +
> +	bitmap_fill(values, ISA1200_EN_PINS_MAX);
> +	gpiod_multi_set_value_cansleep(isa->enable_gpios, values);
> +
> +	usleep_range(200, 300);
> +
> +	regmap_write(isa->map, ISA1200_SCTRL, config->ldo_voltage);
> +
> +	if (isa->clk) {
> +		hctrl0 = ISA1200_HCTRL0_PWM_GEN_MODE;
> +		hctrl1 = ISA1200_HCTRL1_EXT_CLOCK;
> +	}
> +
> +	if (isa->pwm) {
> +		hctrl0 = ISA1200_HCTRL0_PWM_INPUT_MODE;
> +		hctrl1 = 0;
> +	}
> +
> +	hctrl0 |= __ffs(config->clkdiv / ISA1200_HCTRL0_CLKDIV_128);
> +	hctrl1 |= ISA1200_HCTRL1_DAC_INVERT;
> +	hctrl1 |= ISA1200_HCTRL1_MODE(config->mode);
> +
> +	regmap_write(isa->map, ISA1200_HCTRL0, hctrl0);
> +	regmap_write(isa->map, ISA1200_HCTRL1, hctrl1);
> +
> +	/* Make sure to de-assert software reset */
> +	regmap_write(isa->map, ISA1200_HCTRL2, 0x00);
> +
> +	/* PLL divisor */
> +	regmap_write(isa->map, ISA1200_HCTRL3,
> +		     ISA1200_HCTRL3_PLLDIV(config->plldiv) |
> +		     ISA1200_HCTRL3_DEFAULT);
> +
> +	/* Frequency */
> +	regmap_write(isa->map, ISA1200_HCTRL4, config->freq);
> +	/* Duty cycle */
> +	regmap_write(isa->map, ISA1200_HCTRL5, config->period >> 1);
> +	/* Period */
> +	regmap_write(isa->map, ISA1200_HCTRL6, config->period);
> +
> +	hctrl0 |= ISA1200_HCTRL0_HAP_ENABLE;
> +	regmap_write(isa->map, ISA1200_HCTRL0, hctrl0);
> +
> +	if (isa->clk)
> +		regmap_write(isa->map, ISA1200_HCTRL5, config->duty);
> +
> +	if (isa->pwm) {
> +		pwm_get_state(isa->pwm, &state);
> +		state.duty_cycle = config->duty;
> +		state.enabled = true;
> +		pwm_apply_might_sleep(isa->pwm, &state);
> +	}
> +}
> +
> +static void isa1200_power_off(void *data)
> +{
> +	struct isa1200 *isa = data;
> +
> +	DECLARE_BITMAP(values, ISA1200_EN_PINS_MAX);
> +
> +	bitmap_zero(values, ISA1200_EN_PINS_MAX);
> +	gpiod_multi_set_value_cansleep(isa->enable_gpios, values);
> +
> +	if (isa->clk_on) {
> +		clk_disable_unprepare(isa->clk);
> +		isa->clk_on = false;
> +	}
> +}
> +
> +static void isa1200_stop(struct isa1200 *isa)
> +{
> +	struct pwm_state state;
> +
> +	if (isa->pwm) {
> +		pwm_get_state(isa->pwm, &state);
> +		state.duty_cycle = 0;
> +		state.enabled = false;
> +		pwm_apply_might_sleep(isa->pwm, &state);
> +	}
> +
> +	regmap_write(isa->map, ISA1200_HCTRL0, 0x00);
> +	isa1200_power_off(isa);
> +}
> +
> +static void isa1200_play_work(struct work_struct *work)
> +{
> +	struct isa1200 *isa =
> +		container_of(work, struct isa1200, play_work);
> +
> +	guard(mutex)(&isa->input->mutex);

I think this mutex is dangerous here. You really want to stop/cancel
work in suspend() and close() instead of blocking on the mutex and then
continuing.

> +
> +	if (isa->level)
> +		isa1200_start(isa);
> +	else
> +		isa1200_stop(isa);
> +}
> +
> +static int isa1200_vibrator_play_effect(struct input_dev *input, void *data,
> +					struct ff_effect *effect)
> +{
> +	struct isa1200 *isa = input_get_drvdata(input);
> +	int level;
> +
> +	/*
> +	 * TODO: we currently only support rumble.
> +	 * The ISA1200 can control two motors and some devices
> +	 * also have two motors mounted.
> +	 */
> +	level = effect->u.rumble.strong_magnitude;
> +	if (!level)
> +		level = effect->u.rumble.weak_magnitude;
> +
> +	dev_dbg(&input->dev, "FF effect type %d level %d\n",
> +		effect->type, level);
> +
> +	if (isa->level != level) {
> +		isa->level = level;
> +		schedule_work(&isa->play_work);
> +	}
> +
> +	return 0;
> +}
> +
> +static void isa1200_vibrator_close(struct input_dev *input)
> +{
> +	struct isa1200 *isa = input_get_drvdata(input);
> +
> +	cancel_work_sync(&isa->play_work);
> +
> +	if (isa->level)

So here I think you need to check that "active" flag that would represent
the committed state.

> +		isa1200_stop(isa);
> +
> +	isa->level = 0;
> +}
> +
> +static int isa1200_of_probe(struct i2c_client *client)
> +{
> +	static const char * const isa1200_supplies[] = { "vdd", "vddp" };
> +	struct isa1200 *isa = i2c_get_clientdata(client);
> +	struct isa1200_config *config = &isa->config;
> +	struct device *dev = &client->dev;
> +	struct fwnode_handle *ldo_node;
> +	int ret;
> +
> +	isa->clk = devm_clk_get_optional(dev, NULL);
> +	if (IS_ERR(isa->clk))
> +		return dev_err_probe(dev, PTR_ERR(isa->clk),
> +				     "failed to get clock\n");
> +
> +	isa->pwm = devm_pwm_get(dev, NULL);
> +	if (IS_ERR(isa->pwm)) {
> +		ret = PTR_ERR(isa->pwm);
> +		if (ret == -ENODEV || ret == -EINVAL)
> +			isa->pwm = NULL;
> +		else
> +			return dev_err_probe(dev, ret, "getting PWM\n");
> +	}
> +
> +	if (!isa->clk && !isa->pwm)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "clock or PWM are required, none were provided\n");
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(isa1200_supplies),
> +					     isa1200_supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set up supplies\n");
> +
> +	isa->enable_gpios = devm_gpiod_get_array_optional(dev, "control",
> +							  GPIOD_OUT_LOW);
> +	if (IS_ERR(isa->enable_gpios))
> +		return dev_err_probe(dev, PTR_ERR(isa->enable_gpios),
> +				     "failed to get enable gpios\n");
> +
> +	ldo_node = device_get_named_child_node(dev, "ldo");
> +	if (!ldo_node)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "failed to get embedded LDO node\n");
> +
> +	ret = fwnode_property_read_u32(ldo_node, "regulator-min-microvolt",
> +				       &config->ldo_voltage);
> +	fwnode_handle_put(ldo_node);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to get ldo voltage\n");
> +
> +	config->ldo_voltage = clamp(config->ldo_voltage,
> +				    ISA1200_LDO_VOLTAGE_MIN,
> +				    ISA1200_LDO_VOLTAGE_MAX);
> +
> +	config->ldo_voltage /= ISA1200_LDO_VOLTAGE_STEP;
> +	if (config->ldo_voltage < ISA1200_LDO_VOLTAGE_3V1)
> +		config->ldo_voltage = config->ldo_voltage -
> +				      ISA1200_LDO_VOLTAGE_2V3 +
> +				      ISA1200_LDO_VOLTAGE_BASE;
> +	else
> +		config->ldo_voltage -= ISA1200_LDO_VOLTAGE_3V1;
> +
> +	config->mode = 0; /* LRA_MODE */
> +	device_property_read_u32(dev, "imagis,mode", &config->mode);
> +
> +	config->clkdiv = ISA1200_HCTRL0_CLKDIV_128;
> +	device_property_read_u32(dev, "imagis,clk-div", &config->clkdiv);
> +	if (!config->clkdiv)
> +		return dev_err_probe(dev, -EINVAL, "clk-div cannot be zero\n");
> +
> +	config->clkdiv = clamp(config->clkdiv, ISA1200_HCTRL0_CLKDIV_128,
> +			       ISA1200_HCTRL0_CLKDIV_128 << 3);
> +
> +	ret = device_property_read_u32(dev, "imagis,pll-div", &config->plldiv);
> +	if (ret < 0 || !config->plldiv)
> +		config->plldiv = 1;
> +
> +	config->period = 0;
> +	config->freq = 0;
> +	config->duty = 0;
> +
> +	if (isa->clk) {
> +		ret = device_property_read_u32(dev, "imagis,period-ns",
> +					       &config->period);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to get period\n");
> +
> +		/*
> +		 * TODO: The scale value is arbitrary, but it fits observations
> +		 * quite well, and the exact conversion method is unknown.
> +		 * The period property value returned above is the HCTRL6
> +		 * register value set by the vendor code, multiplied by 100.
> +		 */
> +		config->period /= ISA1200_HCTRL6_PERIOD_SCALE;
> +		config->duty = config->period >> 1;
> +	}
> +
> +	if (isa->pwm) {
> +		struct pwm_state state;
> +
> +		pwm_init_state(isa->pwm, &state);
> +
> +		if (!state.period)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "PWM period cannot be zero\n");
> +
> +		config->freq = div64_u64(NANO, state.period * config->clkdiv);
> +		config->duty = state.period >> 1;
> +
> +		ret = pwm_apply_might_sleep(isa->pwm, &state);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to apply initial PWM state\n");
> +	}
> +
> +	/*
> +	 * TODO: If device is using a clock, this property should return the
> +	 * value written to the HCTRL5 register by downstrem code. It likely
> +	 * needs to be converted into a meaningful duty cycle value, though
> +	 * unfortunately the exact conversion mechanism is unknown. If the
> +	 * device uses PWM, this property will return the correct duty cycle
> +	 * in nanoseconds.
> +	 */
> +	device_property_read_u32(dev, "imagis,duty-cycle-ns", &config->duty);
> +
> +	return 0;
> +}
> +
> +static int isa1200_probe(struct i2c_client *client)
> +{
> +	struct isa1200 *isa;
> +	struct device *dev = &client->dev;
> +	DECLARE_BITMAP(values, ISA1200_EN_PINS_MAX);
> +	u32 val;
> +	int ret;
> +
> +	isa = devm_kzalloc(dev, sizeof(*isa), GFP_KERNEL);
> +	if (!isa)
> +		return -ENOMEM;
> +
> +	isa->input = devm_input_allocate_device(dev);
> +	if (!isa->input)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, isa);
> +
> +	ret = isa1200_of_probe(client);
> +	if (ret)
> +		return ret;
> +
> +	isa->map = devm_regmap_init_i2c(client, &isa1200_regmap_config);
> +	if (IS_ERR(isa->map))
> +		return dev_err_probe(dev, PTR_ERR(isa->map),
> +				     "failed to initialize register map\n");
> +
> +	ret = clk_prepare_enable(isa->clk);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to enable clock\n");
> +
> +	isa->clk_on = true;
> +
> +	bitmap_fill(values, ISA1200_EN_PINS_MAX);
> +	gpiod_multi_set_value_cansleep(isa->enable_gpios, values);

You should factor our isa1200_power_on() from isa1200_start() and use it
here.

> +
> +	ret = devm_add_action_or_reset(dev, isa1200_power_off, isa);
> +	if (ret)
> +		return ret;

close() is taking care of powering off the device.

> +
> +	usleep_range(200, 300);
> +
> +	/* Read a register so we know that regmap and I2C transport works */
> +	ret = regmap_read(isa->map, ISA1200_SCTRL, &val);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to read SCTRL\n");

You should call isa1200_power_off() here. You do not know when the first
effect will play. In the meantime the device should be in low power
state.

> +
> +	ret = devm_work_autocancel(dev, &isa->play_work, isa1200_play_work);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to init work\n");

I do not think you need it here. You supply input->close() and that
should take care of stopping/canceling the work. Input core guarantees
to call close() if the device is "open" whne unregistering.

> +
> +	isa->input->name = "isa1200-haptic";
> +	isa->input->id.bustype = BUS_HOST;

Not BUS_I2C?

> +	isa->input->dev.parent = dev;

Parent is already set by devm_input_allocate_device().

> +	isa->input->close = isa1200_vibrator_close;
> +
> +	input_set_drvdata(isa->input, isa);
> +
> +	/* TODO: this hardware can likely support more than rumble */
> +	input_set_capability(isa->input, EV_FF, FF_RUMBLE);
> +
> +	ret = input_ff_create_memless(isa->input, NULL,
> +				      isa1200_vibrator_play_effect);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "couldn't create FF dev\n");

"failed ..."

> +
> +	ret = input_register_device(isa->input);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "couldn't register input dev\n");

"failed ..."

> +
> +	return ret;

	return 0;

> +}
> +
> +static int isa1200_suspend(struct device *dev)
> +{
> +	struct isa1200 *isa = dev_get_drvdata(dev);
> +
> +	cancel_work_sync(&isa->play_work);

Move it under input_device_enabled().

> +
> +	guard(mutex)(&isa->input->mutex);
> +
> +	if (input_device_enabled(isa->input))
> +		if (isa->level)
> +			isa1200_stop(isa);
> +
> +	return 0;
> +}
> +
> +static int isa1200_resume(struct device *dev)
> +{
> +	struct isa1200 *isa = dev_get_drvdata(dev);
> +
> +	guard(mutex)(&isa->input->mutex);
> +
> +	if (input_device_enabled(isa->input))
> +		if (isa->level)
> +			isa1200_start(isa);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(isa1200_pm_ops, isa1200_suspend, isa1200_resume);
> +
> +static const struct of_device_id isa1200_of_match[] = {
> +	{ .compatible = "imagis,isa1200" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, isa1200_of_match);
> +
> +static struct i2c_driver isa1200_i2c_driver = {
> +	.driver = {
> +		.name = "isa1200",
> +		.of_match_table = isa1200_of_match,
> +		.pm = pm_sleep_ptr(&isa1200_pm_ops),
> +	},
> +	.probe = isa1200_probe,
> +};
> +module_i2c_driver(isa1200_i2c_driver);
> +
> +MODULE_AUTHOR("Linus Walleij <linusw@kernel.org>");
> +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> +MODULE_DESCRIPTION("Imagis ISA1200 haptic feedback unit");
> +MODULE_LICENSE("GPL");

Thanks.

-- 
Dmitry

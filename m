Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057B248F64;
	Mon, 17 Aug 2026 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968504; cv=none; b=DWRZ46xKNqNlYU8kPgYHDel8qDi+ZogRiN8c1yvPpHJ87EeaKm8DGwaNi2cTvY2fnSjFdkCaIkiQfvfCBN7rP2VV3pCQYs2uVx2odiz8Ni3znUax2ko+7zUsk06N1utFPEmaVobdIfRv38o9JJZS54wKRQrNEsUtD1+ERXFHK9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968504; c=relaxed/simple;
	bh=Nk2/S/yFEzGk9/5Mb0xRheo0KmpqB7rQnBaFdrbN348=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aU56dK1Zi0eRNOz601UlYax73M0oJxmKXZHRSneImJe0j41RkZhOLEVkkT1lXZy+cLb3BudfuxSDGk5M7LcN3bO3o+R/d3Snw/L1xt3zK1SsmEj8p3qsFz8Fo+WXAJ7BC7EaxOQwU6tsESZMPxL+WikESwZu1iwv14QyZiFJMUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=jDJ/l4ud; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="jDJ/l4ud"
Received: from [172.16.124.192] (ip-78-44-13-22.bb.vodafone.cz [78.44.13.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 782A35340C3E;
	Mon, 17 Aug 2026 14:08:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1786968492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jluRJklxXbVUN6SZeTzgIAhbOed+xK/URQN2QpjjPyQ=;
	b=jDJ/l4uddvms3XNadnAWNJ8WdfAjW3U2Ti5uRssF7fswBX7kOe4YSDdKqwXKjDrOuPlJcf
	ZMHpFiFvxblrreyJhQApohFLyoGTjXeRBpYCC8J1zq6RU8xZ1FTix3RVPjAWbH9B+wXo5I
	54my1+dzOkn+h1G02Kr5fIkaUuqHp9Q=
Message-ID: <214bbcf7-38ba-458b-81ba-d7f3a42cb73d@ixit.cz>
Date: Mon, 17 Aug 2026 14:08:11 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] input: misc: Add Qualcomm SPMI PMIC haptics driver
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: David Collins <david.collins@oss.qualcomm.com>,
 Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
 Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260806-qcom-spmi-haptics-v6-0-19fcecd5204f@oss.qualcomm.com>
 <20260806-qcom-spmi-haptics-v6-2-19fcecd5204f@oss.qualcomm.com>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260806-qcom-spmi-haptics-v6-2-19fcecd5204f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/08/2026 08:21, Fenglin Wu wrote:
> Add an initial driver for the Qualcomm PMIH0108 PMIC haptics module,
> named as HAP530_HV. This module supports several play modes, including
> DIRECT_PLAY, FIFO, PAT_MEM, and SWR, each with distinct data sourcing
> and hardware data handling logic. Currently, the driver provides support
> for two play modes using the input force-feedback framework: FF_CONSTANT
> effect for DIRECT_PLAY mode and FF_PERIODIC effect with FF_CUSTOM
> waveform for FIFO mode.
> 
> Assisted-by: Claude:claude-4-8-opus
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>   drivers/input/misc/Kconfig             |   11 +
>   drivers/input/misc/Makefile            |    1 +
>   drivers/input/misc/qcom-spmi-haptics.c | 1252 ++++++++++++++++++++++++++++++++
>   3 files changed, 1264 insertions(+)
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 1f6c57dba030..4f40940973e4 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -236,6 +236,17 @@ config INPUT_PMIC8XXX_PWRKEY
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called pmic8xxx-pwrkey.
>   
> +config INPUT_QCOM_SPMI_HAPTICS
> +	tristate "Qualcomm SPMI PMIC haptics support"
> +	depends on MFD_SPMI_PMIC
> +	help
> +	  Say Y to enable support for the Qualcomm PMIH0108 SPMI PMIC haptics
> +	  module. Supports DIRECT_PLAY, FIFO streaming play modes via the
> +	  Linux input force-feedback framework.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called qcom-spmi-haptics.
> +
>   config INPUT_SPARCSPKR
>   	tristate "SPARC Speaker support"
>   	depends on PCI && SPARC64
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 2281d6803fce..c5c9aa139a11 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_INPUT_PMIC8XXX_PWRKEY)	+= pmic8xxx-pwrkey.o
>   obj-$(CONFIG_INPUT_POWERMATE)		+= powermate.o
>   obj-$(CONFIG_INPUT_PWM_BEEPER)		+= pwm-beeper.o
>   obj-$(CONFIG_INPUT_PWM_VIBRA)		+= pwm-vibra.o
> +obj-$(CONFIG_INPUT_QCOM_SPMI_HAPTICS)	+= qcom-spmi-haptics.o
>   obj-$(CONFIG_INPUT_QNAP_MCU)		+= qnap-mcu-input.o
>   obj-$(CONFIG_INPUT_RAVE_SP_PWRBUTTON)	+= rave-sp-pwrbutton.o
>   obj-$(CONFIG_INPUT_RB532_BUTTON)	+= rb532_button.o
> diff --git a/drivers/input/misc/qcom-spmi-haptics.c b/drivers/input/misc/qcom-spmi-haptics.c
> new file mode 100644
> index 000000000000..91465e7a6645
> --- /dev/null
> +++ b/drivers/input/misc/qcom-spmi-haptics.c
> @@ -0,0 +1,1252 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/list.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/workqueue.h>
> +
> +/* HAP_CFG register offsets, bit fields, value constants */
> +#define HAP_CFG_INT_RT_STS_REG		0x10
> +#define  FIFO_EMPTY_BIT			BIT(1)
> +#define HAP_CFG_EN_CTL_REG		0x46
> +#define  HAPTICS_EN_BIT			BIT(7)
> +#define HAP_CFG_VMAX_REG		0x48
> +#define   VMAX_STEP_MV			50
> +#define   VMAX_MV_MAX			10000
> +#define HAP_CFG_SPMI_PLAY_REG		0x4C
> +#define  PLAY_EN_BIT			BIT(7)
> +#define  PAT_SRC_MASK			GENMASK(2, 0)
> +#define   PAT_SRC_FIFO			0
> +#define   PAT_SRC_DIRECT_PLAY		1
> +#define HAP_CFG_TLRA_OL_HIGH_REG	0x5C
> +#define  TLRA_OL_MSB_MASK		GENMASK(3, 0)
> +#define   TLRA_STEP_US			5
> +#define   TLRA_US_MAX			20475
> +#define HAP_CFG_TLRA_OL_LOW_REG		0x5D
> +#define HAP_CFG_DRV_DUTY_CFG_REG	0x60
> +#define  ADT_DRV_DUTY_EN_BIT		BIT(7)
> +#define  ADT_BRK_DUTY_EN_BIT		BIT(6)
> +#define  DRV_DUTY_MASK			GENMASK(5, 3)
> +#define   AUTORES_DRV_DUTY_62P5		2
> +#define  BRK_DUTY_MASK			GENMASK(2, 0)
> +#define   AUTORES_BRK_DUTY_62P5		5
> +#define HAP_CFG_ZX_WIND_CFG_REG		0x62
> +#define  ZX_DEBOUNCE_MASK		GENMASK(6, 4)
> +#define   AUTORES_ZX_DEBOUNCE		3
> +#define  ZX_WIN_HEIGHT_MASK		GENMASK(2, 0)
> +#define   AUTORES_ZX_WIN_HEIGHT		2
> +#define HAP_CFG_AUTORES_CFG_REG		0x63
> +#define  AUTORES_EN_BIT			BIT(7)
> +#define  AUTORES_EN_DLY_MASK		GENMASK(6, 2)
> +#define   AUTORES_EN_DLY_CYCLES		10
> +#define  AUTORES_ERR_WIN_MASK		GENMASK(1, 0)
> +#define   AUTORES_ERR_WIN_25PCT		1
> +#define HAP_CFG_FAULT_CLR_REG		0x66
> +#define  ZX_TO_FAULT_CLR_BIT		BIT(4)
> +#define  SC_CLR_BIT			BIT(2)
> +#define  AUTO_RES_ERR_CLR_BIT		BIT(1)
> +#define  HPWR_RDY_FAULT_CLR_BIT		BIT(0)
> +#define  FAULT_CLR_ALL	(ZX_TO_FAULT_CLR_BIT | SC_CLR_BIT | \
> +			 AUTO_RES_ERR_CLR_BIT | HPWR_RDY_FAULT_CLR_BIT)
> +#define HAP_CFG_RAMP_DN_CFG2_REG	0x86
> +#define  AUTORES_PRE_HIZ_DLY_10US	1
> +
> +/* HAP_PTN register offsets, bit fields, value constants */
> +#define HAP_PTN_FIFO_DIN_0_REG		0x20
> +#define HAP_PTN_FIFO_PLAY_RATE_REG	0x24
> +#define  FIFO_PLAY_RATE_MASK		GENMASK(3, 0)
> +#define HAP_PTN_DIRECT_PLAY_REG		0x26
> +#define HAP_PTN_FIFO_EMPTY_CFG_REG	0x2A
> +#define  FIFO_THRESH_LSB		64
> +#define HAP_PTN_FIFO_DIN_1B_REG		0x2C
> +#define HAP_PTN_MEM_OP_ACCESS_REG	0x2D
> +#define  MEM_FLUSH_RELOAD_BIT		BIT(0)
> +#define HAP_PTN_MMAP_FIFO_REG		0xA0
> +#define  MMAP_FIFO_EXIST_BIT		BIT(7)
> +#define  MMAP_FIFO_LEN_MASK		GENMASK(6, 0)
> +
> +#define HAP530_MEM_TOTAL_BYTES		8192
> +#define FIFO_EMPTY_THRESH		256
> +#define FIFO_INIT_FILL			320
> +
> +#define HAPTICS_AUTOSUSPEND_MS		1000
> +
> +/*
> + * FF_CUSTOM data layout (custom_data[] of type s16):
> + *   [0] = play rate (PLAY_RATE_*)
> + *   [1] = vmax in mV (0 = use device default from qcom,vmax-microvolt)
> + *   [2..N-1] = signed 8-bit PCM samples packed one per s16 (lower byte used)
> + */
> +#define CUSTOM_DATA_RATE_IDX		0
> +#define CUSTOM_DATA_VMAX_IDX		1
> +#define CUSTOM_DATA_SAMPLE_START	2
> +#define CUSTOM_DATA_MAX_LEN		(48 * 1024)
> +
> +#define HAPTICS_MAX_EFFECTS		8
> +
> +enum qcom_haptics_mode {
> +	HAPTICS_MODE_NONE,
> +	HAPTICS_DIRECT_PLAY,
> +	HAPTICS_FIFO,
> +};
> +
> +enum qcom_haptics_play_rate {
> +	PLAY_RATE_T_LRA       = 0,
> +	PLAY_RATE_T_LRA_DIV_2 = 1,
> +	PLAY_RATE_T_LRA_DIV_4 = 2,
> +	PLAY_RATE_T_LRA_DIV_8 = 3,
> +	PLAY_RATE_T_LRA_X_2   = 4,
> +	PLAY_RATE_T_LRA_X_4   = 5,
> +	PLAY_RATE_T_LRA_X_8   = 6,
> +	PLAY_RATE_RESERVED    = 7,
> +	PLAY_RATE_F_8KHZ      = 8,
> +	PLAY_RATE_F_16KHZ     = 9,
> +	PLAY_RATE_F_24KHZ     = 10,
> +	PLAY_RATE_F_32KHZ     = 11,
> +	PLAY_RATE_F_44P1KHZ   = 12,
> +	PLAY_RATE_F_48KHZ     = 13,
> +	PLAY_RATE_MAX	      = PLAY_RATE_F_48KHZ,
> +};
> +
> +/**
> + * struct qcom_haptics_effect - A haptics effect
> + * @mode:	haptics HW play mode
> + * @vmax_mv:	peak voltage of the haptics output waveform
> + * @length_ms:	vibration play duration
> + * @amplitude:	DIRECT_PLAY mode output waveform amplitude
> + * @play_rate:	FIFO mode play rate
> + * @fifo_data:	8-bit data samples consumed in FIFO mode
> + * @data_len:	length of the FIFO data samples
> + */
> +struct qcom_haptics_effect {
> +	enum qcom_haptics_mode mode;
> +	u32 vmax_mv;
> +	u32 length_ms;
> +
> +	u8 amplitude;
> +
> +	enum qcom_haptics_play_rate play_rate;
> +	s8 *fifo_data;
> +	u32 data_len;
> +};
> +
> +/**
> + * struct haptics_play_req - A haptics play request
> + * @node:	list node of the request
> + * @effect_id:	effect index of the request
> + * @play:	flag of starting or stopping the play
> + */
> +struct haptics_play_req {
> +	struct list_head node;
> +	int effect_id;
> +	bool play;
> +};
> +
> +/**
> + * struct qcom_haptics
> + * @dev:          underlying SPMI device
> + * @regmap:       regmap for SPMI register access
> + * @input:        input device exposing the FF interface
> + * @cfg_base:     base address of the CFG peripheral
> + * @ptn_base:     base address of the PTN peripheral
> + * @t_lra_us:     LRA resonance period in microseconds
> + * @vmax_mv:      maximum actuator drive voltage in millivolts
> + * @fifo_len:     programmed HW FIFO depth in bytes
> + * @gain:         playback gain scaler
> + * @gain_work:    work that changes gain setting for active play
> + * @play_work:    delayed work that plays the queued requests
> + * @stop_work:    delayed work that auto-stops the active effect on duration expiry
> + * @play_lock:    mutex lock to serialize playbacks
> + * @play_queue_lock: spinlock protecting @play_queue
> + * @play_queue:   The list of pending start/stop requests
> + * @active_effect_id: index into @effects[] currently under play
> + * @active_mode:  mode of the effect currently armed in hardware
> + * @stop_timeline: the jiffies value at which @stop_work would execute
> + * @fifo_empty_irq: IRQ number for the FIFO-empty interrupt
> + * @pm_ref_held:  true while a pm_runtime_get is held
> + * @irq_enabled:  true if fifo_empty_irq is enabled
> + * @fifo_lock:    mutex protecting the FIFO streaming data
> + * @fifo_data:    pointer of the data buffer for FIFO streaming
> + * @data_len:     length of the data buffer for current effect
> + * @data_written: number of samples written to the hardware FIFO
> + * @effects:      table of the effects
> + */
> +struct qcom_haptics {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct input_dev *input;
> +
> +	u32 cfg_base;
> +	u32 ptn_base;
> +	u32 t_lra_us;
> +	u32 vmax_mv;
> +	u32 fifo_len;
> +	atomic_t gain;
> +	struct work_struct gain_work;
> +
> +	struct delayed_work play_work;
> +	struct delayed_work stop_work;
> +	struct mutex play_lock; /* mutex used to serialize playbacks */
> +
> +	spinlock_t play_queue_lock; /* protects play_queue */
> +	struct list_head play_queue;
> +
> +	int active_effect_id;
> +	enum qcom_haptics_mode active_mode;
> +	unsigned long stop_timeline;
> +
> +	int fifo_empty_irq;
> +	bool pm_ref_held;
> +	bool irq_enabled;
> +
> +	struct mutex fifo_lock; /* protect the FIFO data during play */
> +	const s8 *fifo_data;
> +	u32 data_len;
> +	u32 data_written;
> +
> +	struct qcom_haptics_effect effects[HAPTICS_MAX_EFFECTS];
> +};
> +
> +static int cfg_write(struct qcom_haptics *h, u32 off, u32 val)
> +{
> +	return regmap_write(h->regmap, h->cfg_base + off, val);
> +}
> +
> +static int cfg_update_bits(struct qcom_haptics *h, u32 off, u32 mask, u32 val)
> +{
> +	return regmap_update_bits(h->regmap, h->cfg_base + off, mask, val);
> +}
> +
> +static int ptn_write(struct qcom_haptics *h, u32 off, u32 val)
> +{
> +	return regmap_write(h->regmap, h->ptn_base + off, val);
> +}
> +
> +static int ptn_update_bits(struct qcom_haptics *h, u32 off, u32 mask, u32 val)
> +{
> +	return regmap_update_bits(h->regmap, h->ptn_base + off, mask, val);
> +}
> +
> +static int ptn_bulk_write(struct qcom_haptics *h, u32 off,
> +			  const void *buf, size_t count)
> +{
> +	return regmap_bulk_write(h->regmap, h->ptn_base + off, buf, count);
> +}
> +
> +static int haptics_clear_faults(struct qcom_haptics *h)
> +{
> +	return cfg_write(h, HAP_CFG_FAULT_CLR_REG, FAULT_CLR_ALL);
> +}
> +
> +static int haptics_set_vmax(struct qcom_haptics *h, u32 vmax_mv)
> +{
> +	return cfg_write(h, HAP_CFG_VMAX_REG, vmax_mv / VMAX_STEP_MV);
> +}
> +
> +static int haptics_config_lra_period(struct qcom_haptics *h)
> +{
> +	u32 tmp = h->t_lra_us / TLRA_STEP_US;
> +	int err;
> +
> +	err = cfg_write(h, HAP_CFG_TLRA_OL_HIGH_REG, (tmp >> 8) & TLRA_OL_MSB_MASK);
> +	if (err)
> +		return err;
> +
> +	err = cfg_write(h, HAP_CFG_TLRA_OL_LOW_REG, tmp & 0xFF);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int haptics_enable_module(struct qcom_haptics *h, bool enable)
> +{
> +	return cfg_update_bits(h, HAP_CFG_EN_CTL_REG, HAPTICS_EN_BIT,
> +			       enable ? HAPTICS_EN_BIT : 0);
> +}
> +
> +static int haptics_configure_autores(struct qcom_haptics *h)
> +{
> +	int err;
> +
> +	/* AUTORES_CFG: enable, 10-cycle delay, 25% error window */
> +	err = cfg_write(h, HAP_CFG_AUTORES_CFG_REG,
> +			AUTORES_EN_BIT |
> +			FIELD_PREP(AUTORES_EN_DLY_MASK, AUTORES_EN_DLY_CYCLES) |
> +			FIELD_PREP(AUTORES_ERR_WIN_MASK, AUTORES_ERR_WIN_25PCT));
> +	if (err)
> +		return err;
> +
> +	/* DRV_DUTY: adaptive drive/brake duty cycles at 62.5% */
> +	err = cfg_write(h, HAP_CFG_DRV_DUTY_CFG_REG,
> +			ADT_DRV_DUTY_EN_BIT | ADT_BRK_DUTY_EN_BIT |
> +			FIELD_PREP(DRV_DUTY_MASK, AUTORES_DRV_DUTY_62P5) |
> +			FIELD_PREP(BRK_DUTY_MASK, AUTORES_BRK_DUTY_62P5));
> +	if (err)
> +		return err;
> +
> +	/* Pre-HIZ delay: 10 µs */
> +	err = cfg_write(h, HAP_CFG_RAMP_DN_CFG2_REG, AUTORES_PRE_HIZ_DLY_10US);
> +	if (err)
> +		return err;
> +
> +	/* Zero-cross window: debounce 3, no hysteresis, height 2 */
> +	err = cfg_write(h, HAP_CFG_ZX_WIND_CFG_REG,
> +			 FIELD_PREP(ZX_DEBOUNCE_MASK, AUTORES_ZX_DEBOUNCE) |
> +			 FIELD_PREP(ZX_WIN_HEIGHT_MASK, AUTORES_ZX_WIN_HEIGHT));
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int haptics_write_fifo_chunk(struct qcom_haptics *h,
> +				    const s8 *data, u32 len)
> +{
> +	u32 bulk_len = ALIGN_DOWN(len, 4);
> +	int i, err;
> +
> +	/*
> +	 * FIFO data writing supports both 4-byte bulk writes using registers
> +	 * [HAP_PTN_FIFO_DIN_0_REG ... HAP_PTN_FIFO_DIN_3_REG], and 1-byte writes
> +	 * using the HAP_PTN_FIFO_DIN_1B_REG register. The 4-byte bulk write is more
> +	 * efficient, so use 4-byte writes for the initial 4-byte aligned data,
> +	 * and 1-byte writes for any trailing remainder.
> +	 */
> +	for (i = 0; i < bulk_len; i += 4) {
> +		err = ptn_bulk_write(h, HAP_PTN_FIFO_DIN_0_REG, &data[i], 4);
> +		if (err)
> +			return err;
> +	}
> +
> +	for (; i < len; i++) {
> +		err = ptn_write(h, HAP_PTN_FIFO_DIN_1B_REG, (u8)data[i]);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int haptics_configure_fifo_mmap(struct qcom_haptics *h)
> +{
> +	u32 fifo_len, fifo_units;
> +
> +	/* Config all memory space for FIFO usage for now */
> +	fifo_len = HAP530_MEM_TOTAL_BYTES;
> +	fifo_len = ALIGN_DOWN(fifo_len, 64);
> +	fifo_units = fifo_len / 64;
> +	h->fifo_len = fifo_len;
> +
> +	return ptn_write(h, HAP_PTN_MMAP_FIFO_REG,
> +			 MMAP_FIFO_EXIST_BIT |
> +			 FIELD_PREP(MMAP_FIFO_LEN_MASK, fifo_units - 1));
> +}
> +
> +static u32 haptics_gain_scaled_vmax(struct qcom_haptics *h, u32 vmax_mv)
> +{
> +	u16 gain = atomic_read(&h->gain);
> +
> +	return mult_frac(vmax_mv, gain, 0xFFFF);
> +}
> +
> +static void haptics_fifo_irq_enable(struct qcom_haptics *h, bool enable)
> +{
> +	if (h->irq_enabled == enable)
> +		return;
> +
> +	if (enable)
> +		enable_irq(h->fifo_empty_irq);
> +	else
> +		disable_irq_nosync(h->fifo_empty_irq);
> +
> +	h->irq_enabled = enable;
> +}
> +
> +static int haptics_enqueue_play_req(struct qcom_haptics *h, int effect_id, bool play)
> +{
> +	struct haptics_play_req *req;
> +
> +	guard(spinlock_irqsave)(&h->play_queue_lock);
> +
> +	/*
> +	 * Coalesce with an already queued request for
> +	 * the same effect instead of appending.
> +	 */
> +	list_for_each_entry(req, &h->play_queue, node) {
> +		if (req->effect_id == effect_id) {
> +			req->play = play;
> +			return 0;
> +		}
> +	}
> +
> +	req = kmalloc_obj(*req, GFP_ATOMIC);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	req->effect_id = effect_id;
> +	req->play = play;
> +
> +	list_add_tail(&req->node, &h->play_queue);
> +
> +	return 0;
> +}
> +
> +static struct haptics_play_req *haptics_dequeue_play_req(struct qcom_haptics *h)
> +{
> +	struct haptics_play_req *req = NULL;
> +
> +	guard(spinlock_irqsave)(&h->play_queue_lock);
> +
> +	if (!list_empty(&h->play_queue)) {
> +		req = list_first_entry(&h->play_queue, struct haptics_play_req, node);
> +		list_del(&req->node);
> +	}
> +
> +	return req;
> +}
> +
> +static void haptics_queue_remove_effect(struct qcom_haptics *h, int effect_id)
> +{
> +	struct haptics_play_req *req, *tmp;
> +
> +	guard(spinlock_irqsave)(&h->play_queue_lock);
> +
> +	list_for_each_entry_safe(req, tmp, &h->play_queue, node) {
> +		if (req->effect_id == effect_id) {
> +			list_del(&req->node);
> +			kfree(req);
> +		}
> +	}
> +}
> +
> +static void haptics_queue_flush(struct qcom_haptics *h)
> +{
> +	struct haptics_play_req *req, *tmp;
> +
> +	guard(spinlock_irqsave)(&h->play_queue_lock);
> +
> +	list_for_each_entry_safe(req, tmp, &h->play_queue, node) {
> +		list_del(&req->node);
> +		kfree(req);
> +	}
> +}
> +
> +static int haptics_start_direct_play(struct qcom_haptics *h, int effect_id)
> +{
> +	struct qcom_haptics_effect *eff = &h->effects[effect_id];
> +	int err;
> +
> +	err = haptics_clear_faults(h);
> +	if (err)
> +		return err;
> +
> +	/* Enable auto-resonance for DIRECT_PLAY mode */
> +	err = cfg_update_bits(h, HAP_CFG_AUTORES_CFG_REG,
> +			      AUTORES_EN_BIT, AUTORES_EN_BIT);
> +	if (err)
> +		return err;
> +
> +	err = haptics_set_vmax(h, haptics_gain_scaled_vmax(h, h->vmax_mv));
> +	if (err)
> +		return err;
> +
> +	err = ptn_write(h, HAP_PTN_DIRECT_PLAY_REG, eff->amplitude);
> +	if (err)
> +		return err;
> +
> +	err = cfg_write(h, HAP_CFG_SPMI_PLAY_REG,
> +			 PLAY_EN_BIT | FIELD_PREP(PAT_SRC_MASK, PAT_SRC_DIRECT_PLAY));
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int haptics_start_fifo(struct qcom_haptics *h, int effect_id)
> +{
> +	struct qcom_haptics_effect *eff = &h->effects[effect_id];
> +	u32 vmax = eff->vmax_mv ? eff->vmax_mv : h->vmax_mv;
> +	u32 init_len;
> +	bool data_done;
> +	int err;
> +
> +	if (!eff->fifo_data || !eff->data_len)
> +		return -EINVAL;
> +
> +	err = haptics_clear_faults(h);
> +	if (err)
> +		return err;
> +
> +	/* Disable auto-resonance for FIFO mode */
> +	err = cfg_update_bits(h, HAP_CFG_AUTORES_CFG_REG, AUTORES_EN_BIT, 0);
> +	if (err)
> +		return err;
> +
> +	err = haptics_set_vmax(h, haptics_gain_scaled_vmax(h, vmax));
> +	if (err)
> +		return err;
> +
> +	err = ptn_update_bits(h, HAP_PTN_FIFO_PLAY_RATE_REG,
> +			      FIFO_PLAY_RATE_MASK,
> +			      FIELD_PREP(FIFO_PLAY_RATE_MASK, eff->play_rate));
> +	if (err)
> +		return err;
> +
> +	/* Flush FIFO before loading new data */
> +	err = ptn_write(h, HAP_PTN_MEM_OP_ACCESS_REG, MEM_FLUSH_RELOAD_BIT);
> +	if (err)
> +		return err;
> +	err = ptn_write(h, HAP_PTN_MEM_OP_ACCESS_REG, 0);
> +	if (err)
> +		return err;
> +
> +	guard(mutex)(&h->fifo_lock);
> +
> +	/* Write the initial chunk and initialise streaming state */
> +	init_len = min_t(u32, eff->data_len, FIFO_INIT_FILL);
> +	err = haptics_write_fifo_chunk(h, eff->fifo_data, init_len);
> +	if (err)
> +		return err;
> +
> +	h->fifo_data    = eff->fifo_data;
> +	h->data_len     = eff->data_len;
> +	h->data_written = init_len;
> +
> +	/*
> +	 * Set empty threshold.  When threshold > 0 the hardware fires the
> +	 * FIFO-empty interrupt when occupancy drops below the threshold,
> +	 * allowing the driver to refill.
> +	 */
> +	data_done = (h->data_written >= h->data_len);
> +	if (!data_done) {
> +		err = ptn_write(h, HAP_PTN_FIFO_EMPTY_CFG_REG,
> +				FIFO_EMPTY_THRESH / FIFO_THRESH_LSB);
> +		if (err) {
> +			dev_err(h->dev, "set FIFO empty threshold failed, err=%d\n", err);
> +			h->fifo_data = NULL;
> +			return err;
> +		}
> +
> +		haptics_fifo_irq_enable(h, true);
> +	}
> +
> +	err = cfg_write(h, HAP_CFG_SPMI_PLAY_REG,
> +			 PLAY_EN_BIT | FIELD_PREP(PAT_SRC_MASK, PAT_SRC_FIFO));
> +	if (err) {
> +		dev_err(h->dev, "trigger FIFO play failed, err=%d\n", err);
> +		ptn_write(h, HAP_PTN_FIFO_EMPTY_CFG_REG, 0);
> +		haptics_fifo_irq_enable(h, false);
> +		h->fifo_data = NULL;
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * haptics_fifo_empty_irq: Threaded IRQ handler for the FIFO-empty interrupt.
> + *
> + * While a FIFO play is in progress the hardware fires this interrupt when
> + * the number of samples in the FIFO drops below the programmed threshold.
> + * The handler refills the FIFO from the effect's data buffer.  When all
> + * samples have been written the threshold is set to zero. The HW would
> + * stop the play automatically after all of the samples in FIFO memory are
> + * played out.
> + */
> +static irqreturn_t haptics_fifo_empty_irq(int irq, void *dev_id)
> +{
> +	struct qcom_haptics *h = dev_id;
> +	u32 sts, to_write;
> +	int err;
> +
> +	err = regmap_read(h->regmap,
> +			  h->cfg_base + HAP_CFG_INT_RT_STS_REG, &sts);
> +	if (err || !(sts & FIFO_EMPTY_BIT))
> +		return IRQ_NONE;
> +
> +	guard(mutex)(&h->fifo_lock);
> +
> +	if (!h->fifo_data)
> +		return IRQ_HANDLED;
> +
> +	/* Refill: write the next chunk */
> +	to_write = min_t(u32, h->data_len - h->data_written,
> +			 h->fifo_len - FIFO_EMPTY_THRESH);
> +	err = haptics_write_fifo_chunk(h, &h->fifo_data[h->data_written], to_write);
> +	if (err) {
> +		dev_err(h->dev, "refill FIFO samples failed, err=%d\n", err);
> +		/*
> +		 * If data refilling is failed, clear the FIFO empty threshold
> +		 * and disable the IRQ to prevent the FIFO empty IRQ being fired
> +		 * continuously. The HW would still play out the data which has
> +		 * already been programmed and then stop automatically after that.
> +		 */
> +		ptn_write(h, HAP_PTN_FIFO_EMPTY_CFG_REG, 0);
> +		haptics_fifo_irq_enable(h, false);
> +		return IRQ_HANDLED;
> +	}
> +
> +	h->data_written += to_write;
> +
> +	/* Disable the interrupt after all the data is queued */
> +	if (h->data_written >= h->data_len)
> +		ptn_write(h, HAP_PTN_FIFO_EMPTY_CFG_REG, 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * haptics_stop: stop play in HW and put runtime PM
> + * @h:	haptics device
> + * @put_noidle:	a flag to put noidle
> + *
> + * Stop HW play, clear the FIFO data if the active effect was FIFO-mode, and
> + * put runtime PM into either noidle or autosuspend based on put_noidle flag.
> + *
> + */
> +static void haptics_stop(struct qcom_haptics *h, bool put_noidle)
> +{
> +	lockdep_assert_held(&h->play_lock);
> +
> +	cancel_delayed_work(&h->stop_work);
> +
> +	cfg_write(h, HAP_CFG_SPMI_PLAY_REG, 0);
> +
> +	if (h->active_mode == HAPTICS_FIFO) {
> +		ptn_write(h, HAP_PTN_FIFO_EMPTY_CFG_REG, 0);
> +		scoped_guard(mutex, &h->fifo_lock)
> +			haptics_fifo_irq_enable(h, false);
> +
> +		/*
> +		 * Wait for an in-flight FIFO-empty IRQ thread to finish before
> +		 * clearing fifo_data below, so the handler can't touch it
> +		 * after it's freed.
> +		 */
> +		synchronize_irq(h->fifo_empty_irq);
> +
> +		scoped_guard(mutex, &h->fifo_lock)
> +			h->fifo_data = NULL;
> +	}
> +
> +	h->active_effect_id = -1;
> +	h->active_mode = HAPTICS_MODE_NONE;
> +
> +	if (h->pm_ref_held) {
> +		if (put_noidle)
> +			pm_runtime_put_noidle(h->dev);
> +		else
> +			pm_runtime_put_autosuspend(h->dev);
> +
> +		h->pm_ref_held = false;
> +	}
> +}
> +
> +/*
> + * haptics_start: start to play an effect
> + * @h:	haptics device
> + * @effect_id:	the index of the effect
> + *
> + * If an effect is currently active, stop it 1st. Acquires a PM ref
> + * if not already held, and then trigger the play based on the
> + * play mode. Update active_effect_id/active_mode on success.
> + *
> + */
> +static int haptics_start(struct qcom_haptics *h, int effect_id)
> +{
> +	struct qcom_haptics_effect *eff = &h->effects[effect_id];
> +	unsigned long timeout;
> +	int ret;
> +
> +	lockdep_assert_held(&h->play_lock);
> +
> +	if (h->active_effect_id != -1)
> +		haptics_stop(h, false);
> +
> +	/* Ignore the play if the length is 0 */
> +	if (eff->length_ms == 0)
> +		return 0;
> +
> +	if (!h->pm_ref_held) {
> +		ret = pm_runtime_resume_and_get(h->dev);
> +		if (ret < 0) {
> +			dev_err(h->dev, "failed to resume device: %d\n", ret);
> +			return ret;
> +		}
> +
> +		h->pm_ref_held = true;
> +	}
> +
> +	switch (h->effects[effect_id].mode) {
> +	case HAPTICS_DIRECT_PLAY:
> +		ret = haptics_start_direct_play(h, effect_id);
> +		break;
> +	case HAPTICS_FIFO:
> +		ret = haptics_start_fifo(h, effect_id);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	if (ret) {
> +		dev_err(h->dev, "failed to start effect %d: %d\n", effect_id, ret);
> +		if (h->pm_ref_held) {
> +			pm_runtime_put_autosuspend(h->dev);
> +			h->pm_ref_held = false;
> +		}
> +
> +		return ret;
> +	}
> +
> +	h->active_effect_id = effect_id;
> +	h->active_mode = eff->mode;
> +
> +	timeout = msecs_to_jiffies(eff->length_ms);
> +	h->stop_timeline = jiffies + timeout;
> +	mod_delayed_work(system_percpu_wq, &h->stop_work, timeout);
> +
> +	return 0;
> +}
> +
> +static void haptics_stop_work(struct work_struct *work)
> +{
> +	struct qcom_haptics *h = container_of(to_delayed_work(work),
> +					      struct qcom_haptics, stop_work);
> +
> +	guard(mutex)(&h->play_lock);
> +
> +	if (h->active_effect_id != -1 && h->stop_timeline &&
> +	    time_after_eq(jiffies, h->stop_timeline))
> +		haptics_stop(h, false);
> +}
> +
> +static void haptics_play_work(struct work_struct *work)
> +{
> +	struct qcom_haptics *h = container_of(to_delayed_work(work),
> +					      struct qcom_haptics, play_work);
> +	struct haptics_play_req *req = haptics_dequeue_play_req(h);
> +	int ret;
> +
> +	if (!req)
> +		return;
> +
> +	scoped_guard(mutex, &h->play_lock) {
> +		if (req->play) {
> +			ret = haptics_start(h, req->effect_id);
> +			if (ret)
> +				dev_err(h->dev, "play haptics failed, ret=%d\n", ret);
> +		} else if (req->effect_id == h->active_effect_id) {
> +			haptics_stop(h, false);
> +		}
> +	}
> +
> +	kfree(req);
> +
> +	/* Handle the remaining requests if the queue is not empty */
> +	guard(spinlock_irqsave)(&h->play_queue_lock);
> +	if (!list_empty(&h->play_queue))
> +		schedule_delayed_work(&h->play_work, 0);
> +}
> +
> +static void haptics_clear_effect(struct qcom_haptics *h,
> +				 struct qcom_haptics_effect *effect)
> +{
> +	guard(mutex)(&h->fifo_lock);
> +
> +	if (h->fifo_data == effect->fifo_data)
> +		h->fifo_data = NULL;
> +
> +	kvfree(effect->fifo_data);
> +	effect->fifo_data = NULL;
> +	effect->data_len  = 0;
> +	effect->play_rate = 0;
> +	effect->vmax_mv = 0;
> +	effect->length_ms = 0;
> +}
> +
> +/*
> + * haptics_fifo_length_us: Calculate the play duration of a FIFO effect.
> + * @h:	haptics device pointer
> + * @rate: FIFO data play rate
> + * @data_len: FIFO data length
> + *
> + * Each FIFO sample is played out over one play-rate period, so the total
> + * duration is the number of samples times that period:
> + *
> + *   length_us = (clk_base * data_len * multiplier) / divider
> + *
> + * For T_LRA-based rates the period derives from the LRA resonance period
> + * (h->t_lra_us): DIV_2/4/8 shorten it, X_2/4/8 lengthen it.  For the
> + * kHz-based rates the period is 1000 us / freq_khz.
> + */
> +static u64 haptics_fifo_length_us(struct qcom_haptics *h,
> +				  enum qcom_haptics_play_rate rate,
> +				  u32 data_len)
> +{
> +	u32 clk_base = 1000, multiplier = 1, divider = 1;
> +
> +	switch (rate) {
> +	case PLAY_RATE_T_LRA:
> +		clk_base = h->t_lra_us;
> +		break;
> +	case PLAY_RATE_T_LRA_DIV_2:
> +		clk_base = h->t_lra_us;
> +		divider = 2;
> +		break;
> +	case PLAY_RATE_T_LRA_DIV_4:
> +		clk_base = h->t_lra_us;
> +		divider = 4;
> +		break;
> +	case PLAY_RATE_T_LRA_DIV_8:
> +		clk_base = h->t_lra_us;
> +		divider = 8;
> +		break;
> +	case PLAY_RATE_T_LRA_X_2:
> +		clk_base = h->t_lra_us;
> +		multiplier = 2;
> +		break;
> +	case PLAY_RATE_T_LRA_X_4:
> +		clk_base = h->t_lra_us;
> +		multiplier = 4;
> +		break;
> +	case PLAY_RATE_T_LRA_X_8:
> +		clk_base = h->t_lra_us;
> +		multiplier = 8;
> +		break;
> +	case PLAY_RATE_F_8KHZ:
> +		divider = 8;
> +		break;
> +	case PLAY_RATE_F_16KHZ:
> +		divider = 16;
> +		break;
> +	case PLAY_RATE_F_24KHZ:
> +		divider = 24;
> +		break;
> +	case PLAY_RATE_F_32KHZ:
> +		divider = 32;
> +		break;
> +	case PLAY_RATE_F_44P1KHZ:
> +		clk_base *= 10;
> +		divider = 441;
> +		break;
> +	case PLAY_RATE_F_48KHZ:
> +		divider = 48;
> +		break;
> +	default:
> +		/* Unexpected rate: fall back to the resonance period. */
> +		clk_base = h->t_lra_us;
> +		break;
> +	}
> +
> +	return div_u64((u64)clk_base * data_len * multiplier, divider);
> +}
> +
> +static int haptics_upload_effect(struct input_dev *dev,
> +				 struct ff_effect *effect,
> +				 struct ff_effect *old)
> +{
> +	struct qcom_haptics *h = input_get_drvdata(dev);
> +	struct qcom_haptics_effect *priv;
> +	int id = effect->id;
> +	u32 data_len, level;
> +	u64 length_us;
> +	s8 *fifo;
> +
> +	guard(mutex)(&h->play_lock);
> +
> +	if (id < 0 || id >= HAPTICS_MAX_EFFECTS)
> +		return -EINVAL;
> +
> +	if (id == h->active_effect_id) {
> +		dev_err(h->dev, "effect %d is under playing\n", id);
> +		return -EBUSY;
> +	}
> +
> +	priv = &h->effects[id];
> +
> +	switch (effect->type) {
> +	case FF_CONSTANT:
> +		haptics_clear_effect(h, priv);
> +		level = effect->u.constant.level <= 0 ? 0 : effect->u.constant.level;
> +		priv->amplitude = (u8)mult_frac(level, 255, 0x7FFF);
> +		priv->length_ms = effect->replay.length;
> +		priv->mode = HAPTICS_DIRECT_PLAY;
> +		priv->vmax_mv = h->vmax_mv;
> +		return 0;
> +
> +	case FF_PERIODIC: {
> +		/*
> +		 * FF_RUMBLE effect is converted to FF_PERIODIC/FF_SINE and play
> +		 * it using DIRECT_PLAY mode which drives sinusoidal waveforms
> +		 */
> +		if (effect->u.periodic.waveform == FF_SINE) {
> +			haptics_clear_effect(h, priv);
> +			level = effect->u.periodic.magnitude <= 0 ?
> +				0 : effect->u.periodic.magnitude;
> +			priv->amplitude = (u8)mult_frac(level, 255, 0x7FFF);
> +			priv->length_ms = effect->replay.length;
> +			priv->mode = HAPTICS_DIRECT_PLAY;
> +			priv->vmax_mv = h->vmax_mv;
> +			return 0;
> +		}
> +
> +		if (effect->u.periodic.waveform != FF_CUSTOM)
> +			return -EINVAL;
> +		/*
> +		 * Minimum 3 elements: play-rate code + vmax + at least one sample.
> +		 * Limit the maximum data length to ~48K so that it can at least
> +		 * handle ~1s vibration at the fast (48K) play rate.
> +		 *
> +		 * custom_data here is a raw play-rate + sample buffer for direct
> +		 * HW FIFO streaming rather than a parameterized waveform, so
> +		 * replay.delay, u.periodic.magnitude and the envelope do not
> +		 * apply, and the buffer is played back exactly once per
> +		 * playback() call (no repeat-count support).
> +		 */
> +		if (effect->u.periodic.custom_len < 3 ||
> +		    effect->u.periodic.custom_len > CUSTOM_DATA_MAX_LEN + 2)
> +			return -EINVAL;
> +
> +		s16 *buf __free(kvfree) = vmemdup_array_user(effect->u.periodic.custom_data,
> +						effect->u.periodic.custom_len,
> +						sizeof(s16));
> +		if (IS_ERR(buf))
> +			return PTR_ERR(no_free_ptr(buf));
> +
> +		if (buf[CUSTOM_DATA_RATE_IDX] < 0 ||
> +		    buf[CUSTOM_DATA_RATE_IDX] > PLAY_RATE_MAX ||
> +		    buf[CUSTOM_DATA_RATE_IDX] == PLAY_RATE_RESERVED)
> +			return -EINVAL;
> +
> +		data_len = effect->u.periodic.custom_len - CUSTOM_DATA_SAMPLE_START;
> +
> +		fifo = kvmalloc(data_len, GFP_KERNEL);
> +		if (!fifo)
> +			return -ENOMEM;
> +
> +		/* Pack: one s8 sample per s16 slot (lower byte) */
> +		for (int i = 0; i < data_len; i++)
> +			fifo[i] = (s8)buf[CUSTOM_DATA_SAMPLE_START + i];
> +
> +		haptics_clear_effect(h, priv);
> +
> +		scoped_guard(mutex, &h->fifo_lock) {
> +			priv->fifo_data = fifo;
> +			priv->data_len = data_len;
> +		}
> +
> +		priv->play_rate = (u8)buf[CUSTOM_DATA_RATE_IDX];
> +		priv->vmax_mv   = (u32)clamp_val(buf[CUSTOM_DATA_VMAX_IDX], 0, VMAX_MV_MAX);
> +		length_us = haptics_fifo_length_us(h, priv->play_rate, data_len);
> +		priv->length_ms = DIV_ROUND_UP_ULL(length_us, USEC_PER_MSEC);
> +		if (effect->replay.length)
> +			priv->length_ms = min_t(u64, priv->length_ms, effect->replay.length);
> +
> +		priv->mode = HAPTICS_FIFO;
> +
> +		return 0;
> +	}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int haptics_playback(struct input_dev *dev, int effect_id, int val)
> +{
> +	struct qcom_haptics *h = input_get_drvdata(dev);
> +	int ret;
> +
> +	ret = haptics_enqueue_play_req(h, effect_id, val > 0);
> +	if (ret)
> +		return ret;
> +
> +	schedule_delayed_work(&h->play_work, 0);
> +
> +	return 0;
> +}
> +
> +static int haptics_erase(struct input_dev *dev, int effect_id)
> +{
> +	struct qcom_haptics *h = input_get_drvdata(dev);
> +	struct qcom_haptics_effect *priv = &h->effects[effect_id];
> +
> +	guard(mutex)(&h->play_lock);
> +
> +	haptics_queue_remove_effect(h, effect_id);
> +
> +	if (h->active_effect_id == effect_id)
> +		haptics_stop(h, false);
> +
> +	haptics_clear_effect(h, priv);
> +	priv->mode = HAPTICS_MODE_NONE;
> +
> +	return 0;
> +}
> +
> +static void haptics_gain_work(struct work_struct *work)
> +{
> +	struct qcom_haptics *h = container_of(work, struct qcom_haptics, gain_work);
> +	struct qcom_haptics_effect *eff;
> +	int effect_id;
> +	u32 vmax;
> +
> +	guard(mutex)(&h->play_lock);
> +
> +	effect_id = h->active_effect_id;
> +	if (effect_id == -1)
> +		return;
> +
> +	eff = &h->effects[effect_id];
> +	vmax = eff->vmax_mv ? eff->vmax_mv : h->vmax_mv;
> +
> +	haptics_set_vmax(h, haptics_gain_scaled_vmax(h, vmax));
> +}
> +
> +static void haptics_set_gain(struct input_dev *dev, u16 gain)
> +{
> +	struct qcom_haptics *h = input_get_drvdata(dev);
> +
> +	atomic_set(&h->gain, gain);
> +	schedule_work(&h->gain_work);
> +}
> +
> +static void qcom_haptics_close(struct input_dev *input)
> +{
> +	struct qcom_haptics *h = input_get_drvdata(input);
> +
> +	cancel_work_sync(&h->gain_work);
> +	cancel_delayed_work_sync(&h->play_work);
> +	cancel_delayed_work_sync(&h->stop_work);
> +	scoped_guard(mutex, &h->play_lock) {
> +		haptics_queue_flush(h);
> +		haptics_stop(h, false);
> +	}
> +}
> +
> +static void qcom_haptics_cleanup(void *data)
> +{
> +	struct qcom_haptics *h = data;
> +	int i;
> +
> +	cancel_work_sync(&h->gain_work);
> +	cancel_delayed_work_sync(&h->play_work);
> +	cancel_delayed_work_sync(&h->stop_work);
> +
> +	for (i = 0; i < HAPTICS_MAX_EFFECTS; i++)
> +		haptics_clear_effect(h, &h->effects[i]);
> +
> +	haptics_enable_module(h, false);
> +}
> +
> +static int qcom_haptics_probe(struct platform_device *pdev)
> +{
> +	struct qcom_haptics *h;
> +	struct input_dev *input;
> +	struct ff_device *ff;
> +	u32 regs[2], vmax_uv;
> +	int ret, irq;
> +
> +	h = devm_kzalloc(&pdev->dev, sizeof(*h), GFP_KERNEL);
> +	if (!h)
> +		return -ENOMEM;
> +
> +	h->dev = &pdev->dev;
> +
> +	h->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!h->regmap)
> +		return dev_err_probe(h->dev, -ENODEV, "no regmap from parent\n");
> +
> +	ret = device_property_read_u32_array(h->dev, "reg", regs, ARRAY_SIZE(regs));
> +	if (ret)
> +		return dev_err_probe(h->dev, ret, "failed to read 'reg' property\n");
> +
> +	h->cfg_base = regs[0];
> +	h->ptn_base = regs[1];
> +
> +	ret = device_property_read_u32(h->dev, "qcom,lra-period-us", &h->t_lra_us);
> +	if (ret)
> +		return dev_err_probe(h->dev, ret, "missing qcom,lra-period-us\n");
> +
> +	h->t_lra_us = clamp(h->t_lra_us, (u32)TLRA_STEP_US, (u32)TLRA_US_MAX);
> +
> +	ret = device_property_read_u32(h->dev, "qcom,vmax-microvolt", &vmax_uv);
> +	if (ret)
> +		return dev_err_probe(h->dev, ret, "missing qcom,vmax-microvolt\n");
> +
> +	h->vmax_mv = clamp(vmax_uv / 1000, (u32)VMAX_STEP_MV, (u32)VMAX_MV_MAX);
> +
> +	ret = haptics_config_lra_period(h);
> +	if (ret)
> +		return ret;
> +
> +	ret = haptics_configure_autores(h);
> +	if (ret)
> +		return ret;
> +
> +	ret = haptics_set_vmax(h, h->vmax_mv);
> +	if (ret)
> +		return ret;
> +
> +	ret = haptics_configure_fifo_mmap(h);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_mutex_init(h->dev, &h->play_lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_mutex_init(h->dev, &h->fifo_lock);
> +	if (ret)
> +		return ret;
> +
> +	spin_lock_init(&h->play_queue_lock);
> +	INIT_LIST_HEAD(&h->play_queue);
> +	INIT_DELAYED_WORK(&h->play_work, haptics_play_work);
> +	INIT_DELAYED_WORK(&h->stop_work, haptics_stop_work);
> +	INIT_WORK(&h->gain_work, haptics_gain_work);
> +	atomic_set(&h->gain, 0xFFFF);
> +	h->active_effect_id = -1;
> +
> +	ret = devm_add_action_or_reset(h->dev, qcom_haptics_cleanup, h);
> +	if (ret)
> +		return ret;
> +
> +	irq = platform_get_irq_byname(pdev, "fifo-empty");
> +	if (irq < 0)
> +		return dev_err_probe(h->dev, irq, "failed to get fifo-empty IRQ\n");
> +
> +	ret = devm_request_threaded_irq(h->dev, irq, NULL,
> +					haptics_fifo_empty_irq,
> +					IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					"qcom-haptics-fifo-empty", h);
> +	if (ret)
> +		return dev_err_probe(h->dev, ret, "failed to request fifo-empty IRQ\n");
> +
> +	h->fifo_empty_irq = irq;
> +	platform_set_drvdata(pdev, h);
> +
> +	pm_runtime_use_autosuspend(h->dev);
> +	pm_runtime_set_autosuspend_delay(h->dev, HAPTICS_AUTOSUSPEND_MS);
> +	ret = devm_pm_runtime_enable(h->dev);
> +	if (ret)
> +		return dev_err_probe(h->dev, ret, "enable runtime PM failed\n");
> +
> +	input = devm_input_allocate_device(h->dev);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	input->name = "qcom-spmi-haptics";
> +	input->id.bustype = BUS_HOST;
> +	input->close = qcom_haptics_close;
> +	input_set_drvdata(input, h);
> +	h->input = input;
> +
> +	input_set_capability(input, EV_FF, FF_CONSTANT);
> +	input_set_capability(input, EV_FF, FF_PERIODIC);
> +	input_set_capability(input, EV_FF, FF_CUSTOM);
> +	input_set_capability(input, EV_FF, FF_GAIN);
> +
> +	ret = input_ff_create(input, HAPTICS_MAX_EFFECTS);
> +	if (ret)
> +		return ret;
> +
> +	ff = input->ff;
> +	ff->upload   = haptics_upload_effect;
> +	ff->playback = haptics_playback;
> +	ff->erase    = haptics_erase;
> +	ff->set_gain = haptics_set_gain;
> +
> +	ret = input_register_device(input);
> +	if (ret)
> +		return dev_err_probe(h->dev, ret, "failed to register input device\n");
> +
> +	return 0;
> +}
> +
> +static int qcom_haptics_runtime_suspend(struct device *dev)
> +{
> +	struct qcom_haptics *h = dev_get_drvdata(dev);
> +
> +	return haptics_enable_module(h, false);
> +}
> +
> +static int qcom_haptics_runtime_resume(struct device *dev)
> +{
> +	struct qcom_haptics *h = dev_get_drvdata(dev);
> +
> +	return haptics_enable_module(h, true);
> +}
> +
> +static int qcom_haptics_suspend(struct device *dev)
> +{
> +	struct qcom_haptics *h = dev_get_drvdata(dev);
> +	int ret;
> +
> +	cancel_work_sync(&h->gain_work);
> +	disable_delayed_work_sync(&h->play_work);
> +	disable_delayed_work_sync(&h->stop_work);
> +	scoped_guard(mutex, &h->play_lock) {
> +		haptics_queue_flush(h);
> +		haptics_stop(h, true);
> +	}
> +
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret) {
> +		enable_delayed_work(&h->play_work);
> +		enable_delayed_work(&h->stop_work);
> +	}
> +
> +	return ret;
> +}
> +
> +static int qcom_haptics_resume(struct device *dev)
> +{
> +	struct qcom_haptics *h = dev_get_drvdata(dev);
> +
> +	enable_delayed_work(&h->play_work);
> +	enable_delayed_work(&h->stop_work);
> +
> +	return pm_runtime_force_resume(dev);
> +}
> +
> +static const struct dev_pm_ops qcom_haptics_pm_ops = {
> +	SYSTEM_SLEEP_PM_OPS(qcom_haptics_suspend, qcom_haptics_resume)
> +	RUNTIME_PM_OPS(qcom_haptics_runtime_suspend, qcom_haptics_runtime_resume,
> +		       NULL)
> +};
> +
> +static const struct of_device_id qcom_haptics_of_match[] = {
> +	{ .compatible = "qcom,spmi-haptics" },

I assume this won't work for the Snapdragon 845 (and related arch) SPMI haptics.

Should be the assigned compatible (and relevant data) wired to the PMIH0108 
compatible only?

Thanks
David

P.S. I'll be upstreaming SPMI haptics in approximatelly 2 months for the older 
chips, please feel free to +Cc me on followups! :)

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, qcom_haptics_of_match);
> +
> +static struct platform_driver qcom_haptics_driver = {
> +	.probe  = qcom_haptics_probe,
> +	.driver = {
> +		.name		= "qcom-spmi-haptics",
> +		.of_match_table	= qcom_haptics_of_match,
> +		.pm		= pm_ptr(&qcom_haptics_pm_ops),
> +	},
> +};
> +module_platform_driver(qcom_haptics_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm SPMI PMIC Haptics driver");
> +MODULE_LICENSE("GPL");
> 

-- 
David Heidelberg


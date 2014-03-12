From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 2/3] mfd: max8997: handle IRQs using regmap
Date: Wed, 12 Mar 2014 15:26:15 +0100
Message-ID: <1394634375.11860.8.camel@AMDC1943>
References: <1394631466-6429-1-git-send-email-r.baldyga@samsung.com>
 <1394631466-6429-3-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:65182 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbaCLO0Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Mar 2014 10:26:24 -0400
In-reply-to: <1394631466-6429-3-git-send-email-r.baldyga@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com



On Wed, 2014-03-12 at 14:37 +0100, Robert Baldyga wrote:
> This patch modifies mfd driver to use regmap for handling interrupts.
> It allows to simplify irq handling process. This modifications needed
> to make small changes in function drivers, which use interrupts.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>

(...)

> diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
> index 782d7c9..26a360d 100644
> --- a/drivers/mfd/max8997.c
> +++ b/drivers/mfd/max8997.c
> @@ -64,6 +64,49 @@ static const struct regmap_config max8997_regmap_config = {
>  	.max_register = MAX8997_REG_PMIC_END,
>  };
>  
> +static const struct regmap_irq max8997_irqs[] = {
> +	/* PMIC_INT1 interrupts */
> +	{ .reg_offset = 0, .mask = PMIC_INT1_PWRONR_MASK, },
> +	{ .reg_offset = 0, .mask = PMIC_INT1_PWRONF_MASK, },
> +	{ .reg_offset = 0, .mask = PMIC_INT1_PWRON1SEC_MASK, },
> +	{ .reg_offset = 0, .mask = PMIC_INT1_JIGONR_MASK, },
> +	{ .reg_offset = 0, .mask = PMIC_INT1_JIGONF_MASK, },
> +	{ .reg_offset = 0, .mask = PMIC_INT1_LOWBAT2_MASK, },
> +	{ .reg_offset = 0, .mask = PMIC_INT1_LOWBAT1_MASK, },
> +	/* PMIC_INT2 interrupts */
> +	{ .reg_offset = 1, .mask = PMIC_INT2_JIGR_MASK, },
> +	{ .reg_offset = 1, .mask = PMIC_INT2_JIGF_MASK, },
> +	{ .reg_offset = 1, .mask = PMIC_INT2_MR_MASK, },
> +	{ .reg_offset = 1, .mask = PMIC_INT2_DVS1OK_MASK, },
> +	{ .reg_offset = 1, .mask = PMIC_INT2_DVS2OK_MASK, },
> +	{ .reg_offset = 1, .mask = PMIC_INT2_DVS3OK_MASK, },
> +	{ .reg_offset = 1, .mask = PMIC_INT2_DVS4OK_MASK, },
> +	/* PMIC_INT3 interrupts */
> +	{ .reg_offset = 2, .mask = PMIC_INT3_CHGINS_MASK, },
> +	{ .reg_offset = 2, .mask = PMIC_INT3_CHGRM_MASK, },
> +	{ .reg_offset = 2, .mask = PMIC_INT3_DCINOVP_MASK, },
> +	{ .reg_offset = 2, .mask = PMIC_INT3_TOPOFFR_MASK, },
> +	{ .reg_offset = 2, .mask = PMIC_INT3_CHGRSTF_MASK, },
> +	{ .reg_offset = 2, .mask = PMIC_INT3_MBCHGTMEXPD_MASK, },
> +	/* PMIC_INT4 interrupts */
> +	{ .reg_offset = 3, .mask = PMIC_INT4_RTC60S_MASK, },
> +	{ .reg_offset = 3, .mask = PMIC_INT4_RTCA1_MASK, },
> +	{ .reg_offset = 3, .mask = PMIC_INT4_RTCA2_MASK, },
> +	{ .reg_offset = 3, .mask = PMIC_INT4_SMPL_INT_MASK, },
> +	{ .reg_offset = 3, .mask = PMIC_INT4_RTC1S_MASK, },
> +	{ .reg_offset = 3, .mask = PMIC_INT4_WTSR_MASK, },
> +};
> +
> +static const struct regmap_irq_chip max8997_irq_chip = {
> +	.name			= "max8997",
> +	.status_base		= MAX8997_REG_INT1,
> +	.mask_base		= MAX8997_REG_INT1MSK,
> +	.mask_invert		= false,
> +	.num_regs		= 4,
> +	.irqs			= max8997_irqs,
> +	.num_irqs		= ARRAY_SIZE(max8997_irqs),
> +};
> +
>  static const struct regmap_config max8997_regmap_rtc_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> @@ -82,6 +125,31 @@ static const struct regmap_config max8997_regmap_muic_config = {
>  	.max_register = MAX8997_MUIC_REG_END,
>  };
>  
> +static const struct regmap_irq max8997_irqs_muic[] = {
> +	/* MUIC_INT1 interrupts */
> +	{ .reg_offset = 0, .mask = MUIC_INT1_ADC_MASK, },
> +	{ .reg_offset = 0, .mask = MUIC_INT1_ADCLOW_MASK, },
> +	{ .reg_offset = 0, .mask = MUIC_INT1_ADCERROR_MASK, },
> +	/* MUIC_INT2 interrupts */
> +	{ .reg_offset = 1, .mask = MUIC_INT2_CHGTYP_MASK, },
> +	{ .reg_offset = 1, .mask = MUIC_INT2_CHGDETRUN_MASK, },
> +	{ .reg_offset = 1, .mask = MUIC_INT2_DCDTMR_MASK, },
> +	{ .reg_offset = 1, .mask = MUIC_INT2_DBCHG_MASK, },
> +	{ .reg_offset = 1, .mask = MUIC_INT2_VBVOLT_MASK, },
> +	/* MUIC_INT3 interrupts */
> +	{ .reg_offset = 2, .mask = MUIC_INT3_OVP_MASK, },
> +};
> +
> +static const struct regmap_irq_chip max8997_irq_chip_muic = {
> +	.name			= "max8997-muic",
> +	.status_base		= MAX8997_MUIC_REG_INT1,
> +	.mask_base		= MAX8997_MUIC_REG_INTMASK1,
> +	.mask_invert		= true,
> +	.num_regs		= 3,
> +	.irqs			= max8997_irqs_muic,
> +	.num_irqs		= ARRAY_SIZE(max8997_irqs_muic),
> +};
> +
>  /*
>   * Only the common platform data elements for max8997 are parsed here from the
>   * device tree. Other sub-modules of max8997 such as pmic, rtc and others have
> @@ -214,9 +282,26 @@ static int max8997_i2c_probe(struct i2c_client *i2c,
>  		goto err_regmap;
>  	}
>  
> -	pm_runtime_set_active(max8997->dev);
> +	ret = regmap_add_irq_chip(max8997->regmap, max8997->irq,
> +				IRQF_ONESHOT | IRQF_SHARED |
> +				IRQF_TRIGGER_FALLING, 0,
> +				&max8997_irq_chip, &max8997->irq_data);
> +	if (ret) {
> +		dev_err(max8997->dev, "failed to add irq chip: %d\n", ret);
> +		goto err_irq;
> +	}

In case of error here you shouldn't call regmap_del_irq_chip() so:
	goto err_regmap
The regmap_add_irq_chip() may fail before or AFTER setting the value
under max8997->irq_data. However in both error cases the memory stored
there will be freed already by regmap_add_irq_chip().

>  
> -	max8997_irq_init(max8997);
> +	ret = regmap_add_irq_chip(max8997->regmap_muic, max8997->irq,
> +				IRQF_ONESHOT | IRQF_SHARED |
> +				IRQF_TRIGGER_FALLING, 0,
> +				&max8997_irq_chip_muic,
> +				&max8997->irq_data_muic);
> +	if (ret) {
> +		dev_err(max8997->dev, "failed to add irq chip: %d\n", ret);
> +		goto err_irq_muic;

Same as above - on error remove only one regmap_irq_chip
(max8997->irq_data), not both.


Best regards,
Krzysztof


